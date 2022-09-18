import SlideKit
import SwiftUI

struct CodeSlide: Slide {

    var body: some View {
        HeaderSlide("Code Slide") {
        }
    }
}

struct CodeSlide_Previews: PreviewProvider {
    static var previews: some View {
        SlidePreview {
            CodeSlide()
        }
    }
}
