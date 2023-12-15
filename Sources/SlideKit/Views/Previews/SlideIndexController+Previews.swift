//
//  SlideIndexController+Previews.swift
//  
//
//  Created by Junnosuke Matsumoto on 2022/08/24.
//

import SwiftUI

extension SlideIndexController {
    static let previews = SlideIndexController(index: 0) {
        SampleSlide(text: "Hoge")
        SampleSlide(text: "Piyo")
    }
}

@Slide
private struct SampleSlide: View {
    let text: String

    var body: some View {
        Text(text)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.white)
            .allowsHitTesting(false)
    }

    var script: String {
        "This is a script for \(text)."
    }
}
