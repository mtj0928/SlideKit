import SlideKit
import SwiftUI

struct TitleSlide: Slide {
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
