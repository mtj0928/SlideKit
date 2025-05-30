import SlideKit
import SwiftUI

@Slide
struct CodeSlide: View {
    var body: some View {
        HeaderSlide("Syntax Highlighting") {
            Text("You can show swift code with syntax highlighting.")

            Code("""
                struct Peson: Sendable {
                    var name: String
                    var age: Int
                }
                
                let person = Person(name: "Tom", age: 22)
                print(person.name) // "Tom"
                """
            )
            .lineSpacing(10)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        }
    }

    var backwardTransition: AnyTransition {
        .push(from: .leading)
    }

    var forwardTransition: AnyTransition {
        .push(from: .trailing)
    }
}

#Preview {
    SlidePreview {
        CodeSlide()
    }
}
