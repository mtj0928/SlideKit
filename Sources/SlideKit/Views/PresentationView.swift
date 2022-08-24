//
//  PresentationView.swift
//  
//
//  Created by Junnosuke Matsumoto on 2022/08/24.
//

import SwiftUI

public struct PresentationView<Content>: View where Content: View {

    private let slideSize: CGSize
    private let content: () -> Content

    public init(slideSize: CGSize, content: @escaping () -> Content) {
        self.slideSize = slideSize
        self.content = content
    }

    public var body: some View {
        ZStack(alignment: .center) {
            Color.black
                .ignoresSafeArea()
            SlideScreen(slideSize: slideSize) {
                content()
            }
            .clipped()
        }
    }
}
