import SwiftUI

struct InstrumentCreationView: View {
    @Binding var currentView: AppView
    @State var signals = ["Sine", "Square", "Sawtooth", "Triangle", "Noise"]
    @State var signalInput = "Sine"
    @State var frequency: Float = 500
    @State var duration: Float = 5
    @State var amplitude: Float = 0.5
    
    let defaultEdgeInset = EdgeInsets(top: 50, leading: 0, bottom: 0, trailing: 0)
    
    let decimalFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    var body: some View {
        VStack {
            Text("Instrument Creation")
                .padding(defaultEdgeInset)
                .font(.system(size: 36, weight: .bold, design: .rounded))
            Text("Signal Type")
                .padding(defaultEdgeInset)
                .font(.system(size: 24, weight: .bold, design: .rounded))
            Picker("Signal Type", selection: $signalInput) {
                ForEach(signals, id: \.self) { item in
                    Text(item)
                }
            }
            Text("Frequency")
                .padding(defaultEdgeInset)
                .font(.system(size: 24, weight: .bold, design: .rounded))
            TextField("Frequency", value: $frequency, formatter: decimalFormatter)
                .multilineTextAlignment(.center)
            Text("Duration")
                .padding(defaultEdgeInset)
                .font(.system(size: 24, weight: .bold, design: .rounded))
            TextField("Duration", value: $duration, formatter: decimalFormatter)
                .multilineTextAlignment(.center)
            Text("Amplitude")
                .padding(defaultEdgeInset)
                .font(.system(size: 24, weight: .bold, design: .rounded))
            TextField("Amplitude", value: $amplitude, formatter: decimalFormatter)
                .multilineTextAlignment(.center)
        }
    }
    
    func previewInstrument() {
        
    }
}
