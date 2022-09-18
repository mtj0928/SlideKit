import SwiftUI
import SlideKit

struct IntroductionSlide: Slide {
    var body: some View {
        HeaderSlide("SlideKit") {
            Item("SlideKit helps you make presentation slides by SwiftUI.")
            Item("The followings are provided.")
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
