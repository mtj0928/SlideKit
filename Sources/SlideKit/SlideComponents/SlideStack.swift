//
//  SlideStack.swift
//
//
//  Created by Junnosuke Matsumoto on 2022/08/25.
//

import SwiftUI

public struct SlideHStack<Content>: View where Content: View {

    @Environment(\.slideScale) private var slideScale
    private let alignment: VerticalAlignment
    private let spacing: CGFloat
    private let content: () -> Content

    public init(alignment: VerticalAlignment = .center, spacing: CGFloat = .zero, @ViewBuilder content: @escaping () -> Content) {
        self.alignment = alignment
        self.spacing = spacing
        self.content = content
    }

    public var body: some View {
        HStack(alignment: alignment, spacing: slideScale * spacing) {
            content()
        }
    }
}

public struct SlideVStack<Content>: View where Content: View {

    @Environment(\.slideScale) private var slideScale
    private let alignment: HorizontalAlignment
    private let spacing: CGFloat
    private let content: () -> Content

    public init(alignment: HorizontalAlignment = .center, spacing: CGFloat = .zero, @ViewBuilder content: @escaping () -> Content) {
        self.alignment = alignment
        self.spacing = spacing
        self.content = content
    }

    public var body: some View {
        VStack(alignment: alignment, spacing: slideScale * spacing) {
            content()
        }
    }
}
