//
//  BasicSlide.swift
//  SlideKitDemo-macOS
//
//  Created by Junnosuke Matsumoto on 2022/08/27.
//

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
                Item("You can also use \"return\" or \"→\"")
            }
            if phase == .next {
                Item("Please tap the left half of this window") {
                    Item("You can back the previous slide")
                    Item("You can also use \"←\"")
                }
            }
        }
    }

    var script: String {
        switch phase {
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
                .phase(.next)
        }
    }
}
