import SwiftUI
import SlideKit

struct IntroductionSlide: Slide {
    var body: some View {
        HeaderSlide("SlideKit") {
        }
    }
}

struct IntroductionSlide_Previews: PreviewProvider {
    static var previews: some View {
        SlidePreview {
            IntroductionSlide()
        }
    }
}
