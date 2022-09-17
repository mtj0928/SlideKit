//
//  CustomHeaderStyleSlide.swift
//  SlideKitDemo-macOS
//
//  Created by Junnosuke Matsumoto on 2022/09/17.
//

import SlideKit
import SwiftUI

struct CustomHeaderStyleSlide: Slide {
    var body: some View {
        HeaderSlide("Custom Header Style Slide") {
            Item("This is a custom header slide.")
            Item("You can customize HeaderSlide layout by HeaderSlideStyle")
        }
        .headerSlideStyle(CustomHeaderStyle())
    }
}

struct CustomHeaderStyle: HeaderSlideStyle {

    func makeBody(configuration: Configuration) -> some View {
        SlideVStack(alignment: .leading) {
            configuration.header
                .slideFontSize(90)
                .foregroundColor(.white)
                .slidePadding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background {
                    Color.accentColor
                }
            SlideVStack(alignment: .leading, spacing: 24) {
                configuration.content
            }
            .slidePadding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }
}

struct CustomHeaderStyleSlide_Previews: PreviewProvider {
    static var previews: some View {
        SlidePreview {
            CustomHeaderStyleSlide()
        }
    }
}
