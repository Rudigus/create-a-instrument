import SwiftUI

struct InstrumentCreationView: View {
    @Binding var currentView: AppView
    @State private var signals = SignalType.allStrings
    @State private var signal = SignalType.sine
    @State private var frequency: Float = 500
    @State private var amplitude: Float = 0.5
    
    private let defaultEdgeInset = EdgeInsets(top: 50, leading: 0, bottom: 0, trailing: 0)
    
    private let decimalFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    @State private var player: InstrumentPlayer?
    
    @State private var isPreviewing = false
    
    var body: some View {
        VStack {
            Text("Instrument Creation")
                .padding(defaultEdgeInset)
                .font(.system(size: 36, weight: .bold, design: .rounded))
            Text("Signal Type")
                .padding(defaultEdgeInset)
                .font(.system(size: 24, weight: .bold, design: .rounded))
            Picker("Signal Type", selection: Binding(get: { signal.rawValue }, set: { signal = SignalType(rawValue: $0) ?? .sine })) {
                ForEach(signals, id: \.self) { item in
                    Text(item)
                }
            }
            Text("Frequency")
                .padding(defaultEdgeInset)
                .font(.system(size: 24, weight: .bold, design: .rounded))
            TextField("Frequency", value: $frequency, formatter: decimalFormatter)
                .multilineTextAlignment(.center)
            Text("Amplitude")
                .padding(defaultEdgeInset)
                .font(.system(size: 24, weight: .bold, design: .rounded))
            TextField("Amplitude", value: $amplitude, formatter: decimalFormatter)
                .multilineTextAlignment(.center)
            HStack {
                if isPreviewing {
                    Button("Stop Preview") {
                        // TODO: fix animation delay
//                        withAnimation(.easeInOut(duration: 0.25).delay(0), {
                            stopPreview()
//                        })
                    }
                } else {
                    Button("Preview") {
//                        withAnimation(.easeInOut(duration: 0.25).delay(0), {
                            previewInstrument()
//                        })
                    }
                }
            }
            .padding()
        }
    }
    
    func previewInstrument() {
        isPreviewing = true
        player = InstrumentPlayer(signal: signal, frequency: frequency, amplitude: amplitude)
        player?.startEngine()
    }
    
    func stopPreview() {
        player?.stopEngine()
        isPreviewing = false
    }
}
