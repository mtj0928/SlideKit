import SlideKit
import SwiftUI

struct CustomizedSlide: Slide {
    var body: some View {
        HeaderSlide("Customize Slide Theme") {
            Item("HeaderSlide supports HeaderSlideStyle.")
        }
        .headerSlideStyle(CustomHeaderSlideStyle())
    }
}

struct CustomHeaderSlideStyle: HeaderSlideStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack(alignment: .leading) {
            configuration.header
            configuration.content
        }
        .font(.system(size: 48))
    }
}

struct CustomizedHeaderSlide_Previews: PreviewProvider {
    static var previews: some View {
        SlidePreview {
            CustomizedSlide()
        }
    }
}
