//
//  BasicSlide.swift
//  SlideKitDemo-macOS
//
//  Created by Junnosuke Matsumoto on 2022/08/27.
//

import SlideKit
import SwiftUI

struct BasicSlide: Slide {

    enum SlidePhasedState: Int, PhasedState {
        case initial, next
    }

    @Phase var phasedStateStore

    var body: some View {
        HeaderSlide("How to use the slide") {
            Item("Please tap the right half of this window") {
                Item("You can go to the next state")
                Item("You can also use ⌘ + k")
            }
            if phasedStateStore.when(.next) {
                Item("Please tap the left half of this window") {
                    Item("You can back the previous slide")
                    Item("You can also use ⌘ + j")
                }
            }
        }
    }
}

struct BasicSlide_Previews: PreviewProvider {
    static var previews: some View {
        SlidePreview {
            BasicSlide()
        }
        .preferredColorScheme(.light)
    }
}
