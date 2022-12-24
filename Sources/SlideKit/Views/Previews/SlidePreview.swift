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

    @Environment(\.previewForegroundColor)
    private var foregroundColor: Color

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
                .foregroundColor(foregroundColor)
        }
        .ignoresSafeArea()
        .aspectRatio(slideSize, contentMode: .fit)
    }

    public func previewColor(foreground: Color = .black, background: Color = .white) -> some View {
        self.environment(\.previewBackgroundColor, background)
            .environment(\.previewForegroundColor, foreground)
    }
}

private enum PreviewBackgroundColorKey: EnvironmentKey {
    static let defaultValue = Color.white
}

extension EnvironmentValues {
    fileprivate var previewBackgroundColor: Color {
        get { self[PreviewBackgroundColorKey.self] }
        set { self[PreviewBackgroundColorKey.self] = newValue }
    }
}

private enum PreviewForegroundColorKey: EnvironmentKey {
    static let defaultValue = Color.black
}

extension EnvironmentValues {
    fileprivate var previewForegroundColor: Color {
        get { self[PreviewForegroundColorKey.self] }
        set { self[PreviewForegroundColorKey.self] = newValue }
    }
}
