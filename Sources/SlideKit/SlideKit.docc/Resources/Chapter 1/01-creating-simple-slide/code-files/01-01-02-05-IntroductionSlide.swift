import SwiftUI
import SlideKit

@Slide
struct IntroductionSlide: View {
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
