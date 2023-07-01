//
//  TitleSlide.swift
//  SlideKitDemo-iOS
//
//  Created by Junnosuke Matsumoto on 2022/08/25.
//

import SlideKit
import SwiftUI

@SlidePage
struct TitleSlide: View {

    enum SlidePhasedState: Int, PhasedState {
        case initial, double
    }

    let title: String
    @Phase var phase: SlidePhasedState

    var body: some View {
        VStack {
            Text(title)
            if phase == .double {
                Text(title)
            }
        }
        .font(.system(size: 50))
    }
}

struct TitleSlide_Previews: PreviewProvider {
    static var previews: some View {
        SlidePreview {
            TitleSlide(title: "Hoge")
            TitleSlide(title: "Piyo")
        }
        .preferredColorScheme(.dark)
    }
}
