//
//  HeaderSlideStyle.swift
//  
//
//  Created by Junnosuke Matsumoto on 2022/09/16.
//

import SwiftUI

enum HeaderSlideStyleKey: EnvironmentKey {
    static let defaultValue: AnyHeaderSlideStyle = AnyHeaderSlideStyle(style: .default)
}

extension EnvironmentValues {
    var headerSlideStyle: AnyHeaderSlideStyle {
        get { self[HeaderSlideStyleKey.self] }
        set { self[HeaderSlideStyleKey.self] = newValue }
    }
}

extension View {
    public func headerSlideStyle(_ style: some HeaderSlideStyle) -> some View {
        environment(\.headerSlideStyle, AnyHeaderSlideStyle(style: style))
    }
}
public protocol HeaderSlideStyle {
    associatedtype Body : View

    @ViewBuilder func makeBody(configuration: Self.Configuration) -> Self.Body

    typealias Configuration = HeaderSlideStyleConfiguration
}

extension HeaderSlideStyle where Self == DefaultHeaderSlideStyle {
    public static var `default`: some HeaderSlideStyle {
        DefaultHeaderSlideStyle()
    }
}

public struct HeaderSlideStyleConfiguration {

    public struct Header: View {
        private let view: () -> AnyView

        init(view: @escaping () -> some View) {
            self.view = { AnyView(view()) }
        }

        public var body: some View { view() }
    }

    public struct Content: View {
        private let view: () -> AnyView

        init(view: @escaping () -> some View) {
            self.view = { AnyView(view()) }
        }

        public var body: some View { view() }
    }

    public var header: HeaderSlideStyleConfiguration.Header

    public var content: HeaderSlideStyleConfiguration.Content
}

struct AnyHeaderSlideStyle: HeaderSlideStyle {
    private let converter: (Configuration) -> AnyView

    init(style: some HeaderSlideStyle) {
        converter = { configuration in
            AnyView(style.makeBody(configuration: configuration))
        }
    }

    func makeBody(configuration: Configuration) -> some View {
        AnyView(converter(configuration))
    }
}

public struct DefaultHeaderSlideStyle: HeaderSlideStyle {
    public func makeBody(configuration: Configuration) -> some View {
        SlideVStack(alignment: .leading, spacing: .zero) {
            SlideVStack(alignment: .leading, spacing: 80) {
                SlideHStack(spacing: 32) {
                    Capsule()
                        .foregroundColor(.accentColor)
                        .slideFrame(width: 10, height: 120)
                    configuration.header
                        .slideFontSize(90)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                SlideVStack(alignment: .leading, spacing: 48) {
                    configuration.content
                        .slideFontSize(48)
                }
            }
            Spacer(minLength: 0)
        }
        .slidePadding(60)
    }
}
