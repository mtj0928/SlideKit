import SlideKit
import SwiftUI

struct TitleSlide: Slide {
    var body: some View {
        SlideVStack(alignment: .leading, spacing: 32) {
            Text("SlideKit Presentations")
            Text("YOUR_NAME")
        }
        .slidePadding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
    }
}

struct TitleSlide_Previews: PreviewProvider {
    static var previews: some View {
        SlidePreview {
            TitleSlide()
        }
    }
}
