import SwiftUI

struct OnboardingView: View {
    let lastSlide = AppStrings.onboardingMessages.count
    @State var currentSlide = 0
    
    var body: some View {
        VStack {
            Image(systemName: AppStrings.onboardingIconNames[currentSlide])
                .imageScale(.large)
                .foregroundColor(.accentColor)
                .padding(10)
                .font(.system(size: 36, weight: .regular, design: .rounded))
            Text(AppStrings.onboardingTitles[currentSlide])
                .padding(EdgeInsets(top: 0, leading: 100, bottom: 50, trailing: 100))
                .font(.system(size: 36, weight: .bold, design: .rounded))
            Text(AppStrings.onboardingMessages[currentSlide])
                .padding(EdgeInsets(top: 0, leading: 100, bottom: 0, trailing: 100))
                .font(.system(size: 36, weight: .medium, design: .rounded))
            if currentSlide == lastSlide - 1 {
                Button("Discover") {
                    withAnimation(.easeInOut(duration: 0.25), {
                        startInstrumentCreation()
                    })
                }
                    .padding(EdgeInsets(top: 25, leading: 100, bottom: 0, trailing: 100))
                    .font(.system(size: 36, weight: .medium, design: .rounded))
            }
            HStack(spacing: 50) {
                if currentSlide > 0 {
                    Button("Back") {
                        withAnimation(.easeInOut(duration: 0.25), {
                            toPreviousSlide()
                        })
                    }
                }
                if currentSlide < lastSlide - 1 {
                    Button("Next") {
                        withAnimation(.easeInOut(duration: 0.25), {
                            toNextSlide()
                        })
                    }
                }
            }
            .padding(10)
        }
    }
    
    func toPreviousSlide() {
        currentSlide -= 1
    }
    
    func toNextSlide() {
        currentSlide += 1
    }
    
    func startInstrumentCreation() {
        
    }
}
