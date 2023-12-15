import SlideKit
import SwiftUI

@Slide
struct CustomizedSlide: View {
    var body: some View {
        HeaderSlide("Customize Slide Theme") {
            Item("HeaderSlide supports HeaderSlideStyle.")
        }
    }
}

struct CustomizedHeaderSlide_Previews: PreviewProvider {
    static var previews: some View {
        SlidePreview {
            CustomizedSlide()
        }
    }
}
