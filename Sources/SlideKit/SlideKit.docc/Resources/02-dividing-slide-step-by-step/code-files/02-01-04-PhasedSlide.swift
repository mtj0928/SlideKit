import SlideKit
import SwiftUI

struct PhasedSlide: Slide {

    enum Substep: Int, PhasedState {
        case initial, second, third
    }

    @Phase
    var phasedStateStore: PhasedStateStore<Substep>

    var body: some View {
        HeaderSlide("Phased Slide") {
            Item("Slide can be divided to multiple steps by defining PhasedState.", accessory: nil) {
                Item("1st step", accessory: 1)
                if phasedStateStore.after(.second) {
                    Item("2nd step", accessory: 2)
                }
                if phasedStateStore.after(.third) {
                    Item("3rd step", accessory: 3)
                }
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
