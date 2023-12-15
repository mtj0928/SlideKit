import SlideKit
import SwiftUI

@Slide
struct TitleSlide: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 32) {
            Text("SlideKit Presentations")
                .fontWeight(.heavy)
                .font(.system(size: 120))
            Text("YOUR_NAME")
                .fontWeight(.semibold)
                .font(.system(size: 48))
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        .foregroundColor(.white)
        .background(Color.accentColor)
    }

    var shouldHideIndex: Bool { true }
}

struct TitleSlide_Previews: PreviewProvider {
    static var previews: some View {
        SlidePreview {
            TitleSlide()
        }
    }
}
