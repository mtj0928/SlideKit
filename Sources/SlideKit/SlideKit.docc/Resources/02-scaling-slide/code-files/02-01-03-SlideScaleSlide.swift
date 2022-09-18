import SlideKit
import SwiftUI

struct SlideScaleSlide: Slide {

    @Environment(\.slideScale)
    var slideScale: CGFloat

    var body: some View {
        HeaderSlide("SlideScale on SlideKit") {
            Item("View on SlideKit is needed to be scaled to keep the ratio of layout and the slide.")

            Item("This shape is not scaled.") {
                VStack(spacing: 8) {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.accentColor)
                        .frame(width: 150, height: 150)
                    Text("Non-scaled Shape")
                        .font(.system(size: 30))
                }
            }
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
