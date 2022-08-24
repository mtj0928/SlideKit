//
//  SlidePreview.swift
//  
//
//  Created by Junnosuke Matsumoto on 2022/08/25.
//

import SwiftUI

@MainActor
public struct SlidePreview: View {

    @ObservedObject
    private var slideIndexController: SlideIndexController

    @Environment(\.previewBackgroundColor)
    private var backgroundColor: Color

    private let slideSize: CGSize

    public init(slideSize: CGSize = SlideSize.standard16_9, index: Int = 0, @SlideBuilder  _ content: () -> [any Slide]) {
        self.slideSize = slideSize
        slideIndexController = SlideIndexController(index: index, slideBuilder: content)
    }

    public var body: some View {
        PresentationView(slideSize: slideSize) {
            SlideRouterView(slideIndexController: slideIndexController)
                .background(backgroundColor)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        }
    }

    public func previewSlideBackgroundColor(_ color: Color) -> some View {
        self.environment(\.previewBackgroundColor, color)
    }
}

private enum Key: EnvironmentKey {
    static let defaultValue = Color.white
}

extension EnvironmentValues {
    fileprivate var previewBackgroundColor: Color {
        get { self[Key.self] }
        set { self[Key.self] = newValue }
    }
}
