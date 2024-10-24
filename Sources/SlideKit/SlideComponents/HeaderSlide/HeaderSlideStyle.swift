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

@MainActor
public protocol HeaderSlideStyle: Sendable {
    associatedtype Body : View

    @ViewBuilder func makeBody(configuration: Self.Configuration) -> Self.Body

    typealias Configuration = HeaderSlideStyleConfiguration
}

extension HeaderSlideStyle where Self == DefaultHeaderSlideStyle {
    public nonisolated static var `default`: some HeaderSlideStyle {
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

struct AnyHeaderSlideStyle: HeaderSlideStyle, Sendable {
    private let converter: @MainActor (Configuration) -> AnyView

    nonisolated init(style: some HeaderSlideStyle) {
        converter = { @MainActor configuration in
            AnyView(style.makeBody(configuration: configuration))
        }
    }

    func makeBody(configuration: Configuration) -> some View {
        AnyView(converter(configuration))
    }
}

public struct DefaultHeaderSlideStyle: HeaderSlideStyle {
    public func makeBody(configuration: Configuration) -> some View {
        VStack(alignment: .leading, spacing: .zero) {
            VStack(alignment: .leading, spacing: 80) {
                HStack(spacing: 32) {
                    Capsule()
                        .foregroundColor(.accentColor)
                        .frame(width: 10, height: 120)
                    configuration.header
                        .font(.system(size: 90))
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                VStack(alignment: .leading, spacing: 48) {
                    configuration.content
                        .font(.system(size: 48))
                }
            }
            Spacer(minLength: 0)
        }
        .padding(60)
    }
}
