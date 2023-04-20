import Foundation
import AVFoundation

private let twoPi = 2 * Float.pi

struct InstrumentPlayer {
    var frequency: Float
    var amplitude: Float

    let sine = { (phase: Float) -> Float in
        return sin(phase)
    }

    let whiteNoise = { (phase: Float) -> Float in
        return ((Float(arc4random_uniform(UINT32_MAX)) / Float(UINT32_MAX)) * 2 - 1)
    }

    let sawtooth = { (phase: Float) -> Float in
        return 1.0 - 2.0 * (phase * (1.0 / twoPi))
    }

    let square = { (phase: Float) -> Float in
        if phase <= Float.pi {
            return 1.0
        } else {
            return -1.0
        }
    }

    let triangle = { (phase: Float) -> Float in
        var value = (2.0 * (phase * (1.0 / twoPi))) - 1.0
        if value < 0.0 {
            value = -value
        }
        return 2.0 * (value - 0.5)
    }

    var signal: (Float) -> Float
    
    private lazy var audioEngine: AVAudioEngine = {
        let engine = setupEngine()
        return engine
    }()
    
    init(signal: SignalType, frequency: Float, amplitude: Float) {
        switch signal {
        case .sine:
            self.signal = sine
        case .square:
            self.signal = square
        case .sawtooth:
            self.signal = sawtooth
        case .triangle:
            self.signal = triangle
        case .noise:
            self.signal = whiteNoise
        }
        self.frequency = frequency
        self.amplitude = amplitude
    }
    
    func setupEngine() -> AVAudioEngine {
        let engine = AVAudioEngine()
        let mainMixer = engine.mainMixerNode
        let output = engine.outputNode
        let outputFormat = output.inputFormat(forBus: 0)
        let sampleRate = Float(outputFormat.sampleRate)
        let inputFormat = AVAudioFormat(commonFormat: outputFormat.commonFormat,
                                        sampleRate: outputFormat.sampleRate,
                                        channels: 1,
                                        interleaved: outputFormat.isInterleaved)

        var currentPhase: Float = 0
        let phaseIncrement = (twoPi / sampleRate) * frequency

        let sourceNode = AVAudioSourceNode { _, _, frameCount, audioBufferList -> OSStatus in
            let ablPointer = UnsafeMutableAudioBufferListPointer(audioBufferList)
            for frame in 0..<Int(frameCount) {
                let value = signal(currentPhase) * amplitude
                currentPhase += phaseIncrement
                if currentPhase >= twoPi {
                    currentPhase -= twoPi
                }
                if currentPhase < 0.0 {
                    currentPhase += twoPi
                }
                for buffer in ablPointer {
                    let buf: UnsafeMutableBufferPointer<Float> = UnsafeMutableBufferPointer(buffer)
                    buf[frame] = value
                }
            }
            return noErr
        }

        engine.attach(sourceNode)

        engine.connect(sourceNode, to: mainMixer, format: inputFormat)
        engine.connect(mainMixer, to: output, format: outputFormat)
        mainMixer.outputVolume = 0.5
        
        return engine
    }
    
    mutating func startEngine() {
        do {
            try audioEngine.start()
//            CFRunLoopRun()
//            audioEngine.stop()
        } catch {
            print("Could not start engine: \(error)")
        }
    }
    
    mutating func stopEngine() {
        audioEngine.stop()
    }
}
