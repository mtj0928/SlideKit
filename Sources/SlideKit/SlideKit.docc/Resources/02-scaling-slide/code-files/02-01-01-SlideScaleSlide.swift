import SlideKit
import SwiftUI

struct SlideScaleSlide: Slide {
    var body: some View {
        HeaderSlide("SlideScale on SlideKit") {
            Item("View on SlideKit is needed to be scaled to keep the ratio of layout and the slide.")
        }
    }
}

struct SlideScaleSlide_Previews: PreviewProvider {
    static var previews: some View {
        SlidePreview {
            SlideScaleSlide()
        }
    }
}
