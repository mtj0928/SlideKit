import SlideKit
import SwiftUI

@Slide
struct CodeSlide: View {

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
