//
//  TitleSlide.swift
//  SlideKitDemo-iOS
//
//  Created by Junnosuke Matsumoto on 2022/08/25.
//

import SlideKit
import SwiftUI

struct TitleSlide: Slide {

    enum SlidePhasedState: Int, PhasedState {
        case initial, double
    }

    @Phase var phasedStateStore

    let title: String

    var body: some View {
        SlideVStack {
            Text(title)
            if phasedStateStore.when(.double) {
                Text(title)
            }
        }
        .slideFontSize(50)
    }
}

struct TitleSlide_Previews: PreviewProvider {
    static var previews: some View {
        SlidePreview {
            TitleSlide(title: "Hoge")
            TitleSlide(title: "Piyo")
        }
    }
}
