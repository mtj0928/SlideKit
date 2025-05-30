import SlideKit
import SwiftUI

@Slide
struct BasicSlide: View {

    enum SlidePhase: Int, PhasedState {
        case initial, next
    }

    @Phase var phase: SlidePhase

    var body: some View {
        HeaderSlide("How to use the slide") {
            Item("Please tap the right half of this window") {
                Item("You can go to the next state")
            }
            if phase == .next {
                Item("Please tap the left half of this window") {
                    Item("You can back the previous slide")
                }
            }
        }
    }

    var backwardTransition: AnyTransition {
        .push(from: .leading)
    }

    var forwardTransition: AnyTransition {
        .push(from: .trailing)
    }
}

struct BasicSlide_Previews: PreviewProvider {
    static var previews: some View {
        SlidePreview {
            BasicSlide()
                .phase(.next)
        }
    }
}
