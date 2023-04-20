import Foundation

enum SignalType: String, CaseIterable {
    case sine = "Sine"
    case square = "Square"
    case sawtooth = "Sawtooth"
    case triangle = "Triangle"
    case noise = "Noise"
    
    static var allStrings: [String] {
        return Self.allCases.map { $0.rawValue }
    }
}
