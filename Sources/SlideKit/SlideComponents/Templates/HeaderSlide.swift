//
//  HeaderSlide.swift
//  
//
//  Created by Junnosuke Matsumoto on 2022/08/25.
//

import SwiftUI

public struct HeaderSlide: View {

    @Environment(\.headerSlideStyle)
    private var style

    private var configuration: HeaderSlideStyleConfiguration

    public init(_ header: String, fontWeight: Font.Weight = .semibold, @ViewBuilder content: @escaping () -> some View) {
        self.configuration = HeaderSlideStyleConfiguration(
            header: .init {
                Text(header)
                    .fontWeight(fontWeight)
            },
            content: .init { content() }
        )
    }

    public init(@ViewBuilder header: @escaping () -> some View, @ViewBuilder content: @escaping () -> some View) {
        self.configuration = HeaderSlideStyleConfiguration(
            header: .init { header() },
            content: .init { content() }
        )
    }

    public var body: some View {
        style.makeBody(configuration: configuration)
    }
}
