//
//  Item.swift
//  
//
//  Created by Junnosuke Matsumoto on 2022/08/26.
//

import SwiftUI

public enum ItemAccessory {
    case bullet
    case string(String)
    case number(Int)
}

extension ItemAccessory: ExpressibleByStringLiteral {
    public init(stringLiteral value: StringLiteralType) {
        self = .string(value)
    }
}

extension ItemAccessory: ExpressibleByIntegerLiteral {
    public init(integerLiteral value: IntegerLiteralType) {
        self = .number(value)
    }
}

public struct Item: View {

    @Environment(\.itemStyle)
    private var itemStyle

    @Environment(\.itemDepth)
    private var itemDepth

    private let accessory: ItemAccessory?
    private let label: () -> AnyView
    private let fontSize: CGFloat
    private let child: (() -> AnyView)?

    public init(
        _ text: LocalizedStringKey,
        fontSize: CGFloat = 48,
        accessory: ItemAccessory? = .bullet,
        @ViewBuilder child: @escaping () -> some View
    ) {
        self.label = { AnyView(Text(text)) }
        self.child = { AnyView(child()) }
        self.accessory = accessory
        self.fontSize = fontSize
    }

    public init(
        accessory: ItemAccessory? = .bullet,
        fontSize: CGFloat = 48,
        label: @escaping () -> some View,
        @ViewBuilder child: @escaping () -> some View
    ) {
        self.label = { AnyView(label()) }
        self.child = { AnyView(child()) }
        self.accessory = accessory
        self.fontSize = fontSize
    }

    public init(
        _ text: String,
        fontSize: CGFloat = 48,
        accessory: ItemAccessory? = .bullet
    ) {
        self.label = { AnyView(Text(text)) }
        self.child = nil
        self.accessory = accessory
        self.fontSize = fontSize
    }

    public init(
        accessory: ItemAccessory? = .bullet,
        fontSize: CGFloat = 48,
        label: @escaping () -> some View
    ) {
        self.label = { AnyView(label()) }
        self.child = { AnyView(EmptyView()) }
        self.accessory = accessory
        self.fontSize = fontSize
    }

    public var body: some View {
        itemStyle.makeBody(configuration: .init(
            accessory: accessory,
            label: .init { label() },
            fontSize: fontSize,
            itemDepth: itemDepth,
            child: .init {
                child?()
            }
        ))
    }
}
