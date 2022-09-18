import SlideKit
import SwiftUI

struct CodeSlide: Slide {

    var body: some View {
        HeaderSlide("Code Slide") {
            Text("Syntax Highlight is supported.")
            Code(code, slideFontSize: 32)
        }
    }
}

private let code = """
struct CodeSlide: Slide {

    var body: some View {
        HeaderSlide("Code Slide") {
            Text("Syntax Highlight is supported.")
            Code(code, slideFontSize: 32)
        }
    }
}
"""

struct CodeSlide_Previews: PreviewProvider {
    static var previews: some View {
        SlidePreview {
            CodeSlide()
        }
    }
}
