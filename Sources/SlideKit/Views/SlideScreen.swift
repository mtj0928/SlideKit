//
//  SwiftUIView.swift
//  
//
//  Created by Junnosuke Matsumoto on 2022/08/24.
//

import SwiftUI

public struct SlideScreen<Content>: View where Content: View {

    private let slideSize: CGSize
    private let content: () -> Content

    public init(slideSize: CGSize, content: @escaping () -> Content) {
        self.slideSize = slideSize
        self.content = content
    }

    public var body: some View {
        GeometryReader { proxy in
            content()
                .frame(width: slideSize.width, height: slideSize.height)
                .scaleEffect(scale(for: proxy.size), anchor: .center)
                .frame(width: proxy.size.width, height: proxy.size.height)
        }
    }

    private func scale(for screenSize: CGSize) -> CGFloat {
        let widthScale = screenSize.width / slideSize.width
        let heightScale = screenSize.height / slideSize.height
        return min(widthScale, heightScale)
    }
}
