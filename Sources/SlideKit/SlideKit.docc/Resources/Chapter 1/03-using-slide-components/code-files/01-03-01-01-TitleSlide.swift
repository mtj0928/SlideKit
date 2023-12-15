import SlideKit
import SwiftUI

@Slide
struct TitleSlide: View {
    var body: some View {
        Text("Hello, World!")
    }
}

struct TitleSlide_Previews: PreviewProvider {
    static var previews: some View {
        SlidePreview {
            TitleSlide()
        }
    }
}
