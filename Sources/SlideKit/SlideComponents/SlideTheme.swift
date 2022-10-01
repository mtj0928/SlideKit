//
//  SlideTheme.swift
//  
//
//  Created by Junnosuke Matsumoto on 2022/09/18.
//

import SwiftUI

public protocol SlideTheme {
    associatedtype HeaderSlideStyle: SlideKit.HeaderSlideStyle
    associatedtype ItemStyle: SlideKit.ItemStyle
    associatedtype IndexStyle: SlideKit.IndexStyle

    var headerSlideStyle: HeaderSlideStyle { get }
    var itemStyle: ItemStyle { get }
    var indexStyle: IndexStyle { get }
}

extension SlideTheme where HeaderSlideStyle == DefaultHeaderSlideStyle {
    public var headerSlideStyle: DefaultHeaderSlideStyle {
        DefaultHeaderSlideStyle()
    }
}

extension SlideTheme where ItemStyle == DefaultItemStyle {
    public var itemStyle: DefaultItemStyle {
        DefaultItemStyle()
    }
}

extension SlideTheme where IndexStyle == DefaultIndexStyle {
    public var indexStyle: DefaultIndexStyle {
        DefaultIndexStyle()
    }
}

public struct DefaultSlideTheme: SlideTheme {
    public let headerSlideStyle = DefaultHeaderSlideStyle()
    public let itemStyle = DefaultItemStyle()
    public let indexStyle = DefaultIndexStyle()
}

extension SlideTheme where Self == DefaultSlideTheme {
    public static var `default`: DefaultSlideTheme {
        DefaultSlideTheme()
    }
}

extension View {
    public func slideTheme(_ theme: some SlideTheme) -> some View {
        self.headerSlideStyle(theme.headerSlideStyle)
            .itemStyle(theme.itemStyle)
            .indexStyle(theme.indexStyle)
    }
}
