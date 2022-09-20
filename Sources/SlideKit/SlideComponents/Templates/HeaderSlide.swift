//
//  HeaderSlide.swift
//  
//
//  Created by Junnosuke Matsumoto on 2022/08/25.
//

import SwiftUI

/// A template slide which has a title and a content.
///
/// ``HeaderSlide``  is one of template slides.
/// The design can be customized by using ``HeaderSlideStyle``.
///
/// ```swift
/// var body: some View {
///     HeaderSlide("SampleSlide") {
///         Item("1st item")
///         Item("2nd item")
///         Item("3rd item")
///     }
///     .headerSlideStyle(CustomizedHeaderSlideStyle())
/// }
/// ```
///
/// ## Topics
/// ### Customize Style
/// - ``HeaderSlideStyle``
public struct HeaderSlide: Slide {

    @Environment(\.headerSlideStyle)
    private var style

    private var configuration: HeaderSlideStyleConfiguration

    /// Creates a header slide.
    /// - Parameters:
    ///   - header: A text which is shown on the slide
    ///   - fontWeight: A  fontWeight of the header text.
    ///   - content: A content of the slide.
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
