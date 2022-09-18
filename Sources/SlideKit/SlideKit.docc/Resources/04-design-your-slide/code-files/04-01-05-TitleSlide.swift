import SlideKit
import SwiftUI

struct TitleSlide: Slide {
    var body: some View {
        SlideVStack(alignment: .leading, spacing: 32) {
            Text("SlideKit Presentations")
                .fontWeight(.heavy)
                .slideFontSize(120)
            Text("YOUR_NAME")
                .fontWeight(.semibold)
                .slideFontSize(48)
        }
        .slidePadding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        .foregroundColor(.white)
        .background(Color.accentColor)
    }
}

struct TitleSlide_Previews: PreviewProvider {
    static var previews: some View {
        SlidePreview {
            TitleSlide()
        }
    }
}
