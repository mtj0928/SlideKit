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
                Item("You can also use \"return\" or \"→\"")
            }
            if phasedStateStore.when(.next) {
                Item("Please tap the left half of this window") {
                    Item("You can back the previous slide")
                    Item("You can also use \"←\"")
                }
            }
        }
    }

    var script: String {
        switch phasedStateStore.current {
        case .initial:
            return """
                    Let me show how to use the slide.
                    You can go to the next state by tapping he right half of this window.
                    """
        case .next:
            return """
                    Also, you can go to the back state by tapping he left half of this window
                    """
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
