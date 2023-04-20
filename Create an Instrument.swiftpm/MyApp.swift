import SwiftUI

enum AppView {
    case onboarding, instrumentCreation, instrumentInteraction
}

@main
struct MyApp: App {
    @State var currentView: AppView = .onboarding
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                switch currentView {
                case .onboarding:
                    OnboardingView(currentView: $currentView)
                case .instrumentCreation:
                    InstrumentCreationView(currentView: $currentView)
                case .instrumentInteraction:
                    InstrumentInteractionView()
                }
            }
        }
    }
}
