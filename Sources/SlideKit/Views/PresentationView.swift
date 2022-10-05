//
//  PresentationView.swift
//  
//
//  Created by Junnosuke Matsumoto on 2022/08/24.
//

#if os(macOS)
import AppKit
#endif
import SwiftUI

public struct PresentationView<Content>: View where Content: View {

    private let slideSize: CGSize
    private let content: () -> Content

#if os(macOS)
    private let windowEventHandler: PresentationWindowEventHandler
#endif

    public init(slideSize: CGSize, content: @escaping () -> Content) {
        self.slideSize = slideSize
        self.content = content
#if os(macOS)
        self.windowEventHandler = PresentationWindowEventHandler(slideSize: slideSize)
#endif
    }

    public var body: some View {
        ZStack(alignment: .center) {
            Color.black
            SlideScreen(slideSize: slideSize) {
                content()
            }
#if os(macOS)
            .aspectRatio(slideSize, contentMode: .fit)
            .clipped()
#else
            .clipped()
            .aspectRatio(slideSize, contentMode: .fit)
#endif

        }
        .ignoresSafeArea()
#if os(macOS)
        .configureWindow { window in
            window?.delegate = windowEventHandler
            window?.standardWindowButton(.zoomButton)?.isHidden = true
            window?.standardWindowButton(.miniaturizeButton)?.isHidden = true
            window?.standardWindowButton(.closeButton)?.isHidden = true
        }
#endif
    }
}

#if os(macOS)
public class PresentationWindowEventHandler: NSObject, NSWindowDelegate {
    public let slideSize: CGSize

    init(slideSize: CGSize) {
        self.slideSize = slideSize
    }

    public func windowWillResize(_ sender: NSWindow, to frameSize: NSSize) -> NSSize {
        NSSize(width: slideSize.ratio * frameSize.height, height: frameSize.height)
    }
}
#endif
