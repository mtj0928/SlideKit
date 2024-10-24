//
//  ItemStyle.swift
//  
//
//  Created by Junnosuke Matsumoto on 2022/09/17.
//

import SwiftUI

@MainActor
public protocol ItemStyle: Sendable {
    associatedtype Body : View

    @ViewBuilder func makeBody(configuration: Self.Configuration) -> Self.Body

    typealias Configuration = ItemConfiguration
}

public struct ItemConfiguration {

    public struct Label: View {
        private let view: () -> AnyView

        init(view: @escaping () -> some View) {
            self.view = { AnyView(view()) }
        }

        public var body: some View { view() }
    }

    public struct Child: View {
        @Environment(\.itemDepth)
        var itemDepth

        private let view: () -> AnyView

        init(view: @escaping () -> some View) {
            self.view = { AnyView(view()) }
        }

        public var body: some View { view().environment(\.itemDepth, itemDepth + 1) }
    }

    public var accessory: ItemAccessory?
    public var label: ItemConfiguration.Label
    public var itemDepth: Int
    public var child: Child?

    init(accessory: ItemAccessory? = nil, label: ItemConfiguration.Label, itemDepth: Int, child: Child? = nil) {
        self.accessory = accessory
        self.label = label
        self.itemDepth = itemDepth
        self.child = child
    }
}

struct AnyItemStyle: ItemStyle, Sendable {
    private let converter: @MainActor (Configuration) -> AnyView

    nonisolated init(style: some ItemStyle) {
        converter = { configuration in
            AnyView(style.makeBody(configuration: configuration))
        }
    }

    func makeBody(configuration: Configuration) -> some View {
        AnyView(converter(configuration))
    }
}

public struct DefaultItemStyle: ItemStyle {

    var fontSize: CGFloat = 48

    public func makeBody(configuration: Configuration) -> some View {
        VStack(alignment: .leading, spacing: 28) {
            HStack(alignment: .firstTextBaseline, spacing: fontSize * 0.5) {
                Group {
                    switch configuration.accessory {
                    case .bullet:
                        Circle()
                            .frame(width: fontSize * 20 / 48, height: fontSize * 20 / 48)
                            .aspectRatio(1.0, contentMode: .fill)
                            .offset(y: -fontSize / 5)
                    case .string(let text):
                        Text("\(text).")
                    case .number(let number):
                        Text("\(number).")
                    case nil: EmptyView()
                    }
                }
                .font(.system(size: fontSize))

                configuration.label
                    .font(.system(size: fontSize))
                    .fixedSize(horizontal: false, vertical: true)
            }

            if let child = configuration.child {
                child.padding(.leading, fontSize)
            }
        }
    }
}

extension ItemStyle where Self == DefaultItemStyle {
    public nonisolated static var `default`: DefaultItemStyle {
        DefaultItemStyle()
    }
}

enum ItemStyleKey: EnvironmentKey {
    static let defaultValue = AnyItemStyle(style: .default)
}

enum ItemDepthKey: EnvironmentKey {
    static let defaultValue = 0
}

extension EnvironmentValues {
    var itemStyle: AnyItemStyle {
        get { self[ItemStyleKey.self] }
        set { self[ItemStyleKey.self] = newValue }
    }

    var itemDepth: Int {
        get { self[ItemDepthKey.self] }
        set { self[ItemDepthKey.self] = newValue }
    }
}

extension View {
    public func itemStyle(_ style: some ItemStyle) -> some View {
        environment(\.itemStyle, AnyItemStyle(style: style))
    }
}
