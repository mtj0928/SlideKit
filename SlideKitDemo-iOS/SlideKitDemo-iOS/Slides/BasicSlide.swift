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

struct SampleSlide: Slide {
    var body: some View {
        HeaderSlide("Sample Slide") {
            Item("This is a sample slide.") {
                Item("Preview is also available.")
            }
            Item("You can remove the slide.")
        }
    }
}

struct BasicSlide_Previews: PreviewProvider {
    static var previews: some View {
        SlidePreview {
            SampleSlide()
        }
    }
}
