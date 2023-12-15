import SlideKit
import SwiftUI

@Slide
struct CustomizedSlide: View {
    var body: some View {
        HeaderSlide("Customize Slide Theme") {
            Item("HeaderSlide supports HeaderSlideStyle.")
            Item("Item supports ItemStyle") {
                Item("Nested Item can be customized.")
            }
        }
        .headerSlideStyle(CustomHeaderSlideStyle())
        .itemStyle(CustomItemStyle())
    }
}

struct CustomHeaderSlideStyle: HeaderSlideStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            configuration.header
                .font(.system(size: 90))
                .padding(.vertical, 80)
                .frame(maxWidth: .infinity, alignment: .center)
                .foregroundColor(.accentColor)
            VStack(alignment: .leading, spacing: 90) {
                configuration.content
                    .font(.system(size: 48))
            }
        }
        .padding(.horizontal, 48)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }
}

struct CustomItemStyle: ItemStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
        configuration.child
            .padding(.leading, 90)
    }
}

struct CustomizedHeaderSlide_Previews: PreviewProvider {
    static var previews: some View {
        SlidePreview {
            CustomizedSlide()
        }
    }
}
