//
//  BasicSlide.swift
//  SlideKitDemo-iOS
//
//  Created by Junnosuke Matsumoto on 2022/08/26.
//

import SlideKit
import SwiftUI

struct BasicSlide: Slide {
    var body: some View {
        HeaderSlide("Title") {
            Item("Hoge") {
                Item("Fuga")
                Item("Piyo")
            }
            Item {
                SlideHStack(spacing: 16) {
                    Text("Hoge")
                    Circle()
                }
            } child: {
                Item("AAA")
            }
        }
    }
}

struct BasicSlide_Previews: PreviewProvider {
    static var previews: some View {
        SlidePreview {
            BasicSlide()
        }
    }
}
