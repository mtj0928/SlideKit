//
//  ViewSlide.swift
//  
//
//  Created by Junnosuke Matsumoto on 2022/09/23.
//

import SwiftUI

@Slide
public struct ViewSlide<Content: View>: View{

    let content: () -> Content
    public let script: String
    public let shouldHideIndex: Bool

    public init(script: String = "", shouldHideIndex: Bool = false, content: @escaping () -> Content) {
        self.content = content
        self.script = script
        self.shouldHideIndex = shouldHideIndex
    }

    public var body: some View {
        content()
    }
}
