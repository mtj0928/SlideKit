//
//  TitleSlide.swift
//  SlideKitDemo-iOS
//
//  Created by Junnosuke Matsumoto on 2022/08/25.
//

import SlideKit
import SwiftUI

struct TitleSlide: Slide {

    @Environment(\.slideScale)
    var scale

    let title: String

    var body: some View {
        Text(title)
            .font(.system(size: 50 * scale))
    }
}
