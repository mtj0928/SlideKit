import SwiftUI
import SlideKit

@MainActor
struct SlideConfiguration {

    /// Edit the slide size.
    let size = SlideSize.standard16_9

    ///  Add your slides into the trailing closure.
    let slideIndexController = SlideIndexController(transition: { from, to in
        if let from, from > to {
            return .push(from: .leading)
        } else {
            return .push(from: .trailing)
        }
    }) {
        BasicSlide()
        CodeSlide()
        CustomHeaderStyleSlide()
    }

    let theme = CustomSlideTheme()
}

struct CustomSlideTheme: SlideTheme {
    let indexStyle = CustomIndexStyle()
}

struct CustomIndexStyle: IndexStyle {
    func makeBody(configuration: Configuration) -> some View {
        Text("\(configuration.slideIndexController.currentIndex + 1) / \(configuration.slideIndexController.slides.count)")
            .foregroundColor(.gray)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
            .font(.system(size: 30))
            .padding()
    }
}
