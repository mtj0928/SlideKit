import SlideKit
import SwiftUI

@Slide
struct PhasedSlide: View {

    enum Substep: Int, PhasedState {
        case initial, second, third
    }

    var body: some View {
        HeaderSlide("Phased Slide") {
            Item("Slide can be divided to multiple steps by defining PhasedState.", accessory: nil) {
                Item("1st step", accessory: 1)
                Item("2nd step", accessory: 2)
                Item("3rd step", accessory: 3)
            }
        }
    }
}

struct PhasedSlide_Previews: PreviewProvider {
    static var previews: some View {
        SlidePreview {
            PhasedSlide()
        }
    }
}
