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
                .environment(\.screenSize, proxy.size)
        }
        .aspectRatio(slideSize.width / slideSize.height, contentMode: .fit)
        .environment(\.slideSize, slideSize)
    }
}
