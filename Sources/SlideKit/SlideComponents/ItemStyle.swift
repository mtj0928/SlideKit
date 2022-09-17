//
//  ItemStyle.swift
//  
//
//  Created by Junnosuke Matsumoto on 2022/09/17.
//

import SwiftUI

public protocol ItemStyle {
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
    public var fontSize: CGFloat
    public var itemDepth: Int
    public var child: Child?

    init(accessory: ItemAccessory? = nil, label: ItemConfiguration.Label, fontSize: CGFloat, itemDepth: Int, child: Child? = nil) {
        self.accessory = accessory
        self.label = label
        self.fontSize = fontSize
        self.itemDepth = itemDepth
        self.child = child
    }
}

struct AnyItemStyle: ItemStyle {
    private let converter: (Configuration) -> AnyView

    init(style: some ItemStyle) {
        converter = { configuration in
            AnyView(style.makeBody(configuration: configuration))
        }
    }

    func makeBody(configuration: Configuration) -> some View {
        AnyView(converter(configuration))
    }
}

public struct DefaultItemStyle: ItemStyle {
    public func makeBody(configuration: Configuration) -> some View {
        SlideVStack(alignment: .leading, spacing: 28) {
            SlideHStack(alignment: .firstTextBaseline, spacing: configuration.fontSize * 0.5) {
                Group {
                    switch configuration.accessory {
                    case .bullet:
                        Circle()
                            .slideFrame(width: configuration.fontSize * 20 / 48, height: configuration.fontSize * 20 / 48)
                            .aspectRatio(1.0, contentMode: .fill)
                            .slideOffset(y: -configuration.fontSize / 5)
                    case .string(let text):
                        Text("\(text).")
                    case .number(let number):
                        Text("\(number).")
                    case nil: EmptyView()
                    }
                }
                .slideFontSize(configuration.fontSize)

                configuration.label
                    .slideFontSize(configuration.fontSize)
                    .fixedSize()
            }

            if let child = configuration.child {
                child.slidePadding(.leading, configuration.fontSize)
            }
        }
    }
}

extension ItemStyle where Self == DefaultItemStyle {
    public static var `default`: DefaultItemStyle {
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
