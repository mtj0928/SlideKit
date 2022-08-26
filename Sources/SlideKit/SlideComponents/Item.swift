//
//  Item.swift
//  
//
//  Created by JP27007 on 2022/08/26.
//

import SwiftUI

public enum ItemAccessory {
    case bullet
    case string(String)
}

extension ItemAccessory: ExpressibleByStringLiteral {
    public init(stringLiteral value: StringLiteralType) {
        self = .string(value)
    }
}

extension ItemAccessory: ExpressibleByIntegerLiteral {
    public init(integerLiteral value: IntegerLiteralType) {
        self = .string("\(value)")
    }
}

public struct Item<Label, ChildContent>: View where Label: View, ChildContent: View {

    private let label: () -> Label
    private let accessory: ItemAccessory?
    private let child: (() -> ChildContent)?
    private let slideFontSize: CGFloat

    public init(
        _ text: LocalizedStringKey,
        slideFontSize: CGFloat = 48,
        accessory: ItemAccessory? = .bullet,
        @ViewBuilder child: @escaping () -> ChildContent
    ) where Label == Text {
        self.label = { Text(text) }
        self.child = child
        self.accessory = accessory
        self.slideFontSize = slideFontSize
    }

    public init(
        accessory: ItemAccessory? = .bullet,
        slideFontSize: CGFloat = 48,
        label: @escaping () -> Label,
        @ViewBuilder child: @escaping () -> ChildContent
    ) {
        self.label = label
        self.child = child
        self.accessory = accessory
        self.slideFontSize = 48
    }

    public init(
        _ text: String,
        slideFontSize: CGFloat = 48,
        accessory: ItemAccessory? = .bullet
    ) where Label == Text, ChildContent == EmptyView {
        self.label = { Text(text) }
        self.accessory = accessory
        self.child = { EmptyView() }
        self.slideFontSize = slideFontSize
    }

    public init(
        accessory: ItemAccessory? = .bullet,
        slideFontSize: CGFloat = 48,
        label: @escaping () -> Label
    ) where ChildContent == EmptyView {
        self.label = label
        self.child = { EmptyView() }
        self.accessory = accessory
        self.slideFontSize = slideFontSize
    }

    public var body: some View {
        SlideVStack(alignment: .leading, spacing: 28) {
            SlideHStack(alignment: .firstTextBaseline, spacing: slideFontSize * 0.5) {
                Group {
                    switch accessory {
                    case .bullet:
                        Circle()
                            .slideFrame(width: slideFontSize * 20 / 48, height: slideFontSize * 20 / 48)
                            .aspectRatio(1.0, contentMode: .fill)
                            .slideOffset(y: -slideFontSize / 5)
                    case .string(let text):
                        Text("\(text).")
                    case nil: EmptyView()
                    }
                }
                .slideFontSize(slideFontSize)

                label()
                    .slideFontSize(slideFontSize)
                    .fixedSize()
            }

            if let child = child {
                child()
                    .slidePadding(.leading, slideFontSize)
            }
        }
    }
}

