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

    var headerSlideStyle: HeaderSlideStyle { get }
    var itemStyle: ItemStyle { get }
}

public struct DefaultSlideTheme: SlideTheme {
    public let headerSlideStyle = DefaultHeaderSlideStyle()
    public let itemStyle = DefaultItemStyle()
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
    }
}
