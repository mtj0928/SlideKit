import SlideKit
import SwiftUI

struct TitleSlide: Slide {
    var body: some View {
        VStack(alignment: .leading, spacing: 32) {
            Text("SlideKit Presentations")
            Text("YOUR_NAME")
        }
    }
}

struct TitleSlide_Previews: PreviewProvider {
    static var previews: some View {
        SlidePreview {
            TitleSlide()
        }
    }
}
