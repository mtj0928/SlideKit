//
//  Code.swift
//  
//
//  Created by Junnosuke Matsumoto on 2022/09/09.
//

import Splash
import SwiftUI
#if os(iOS)
import UIKit
#else
import AppKit
#endif

public struct Code {

    let code: String
    let slideFontSize: CGFloat
    let lineSpacing: CGFloat

    public init(_ code: String, slideFontSize: CGFloat = 48, slideLineSpacing: CGFloat = 12) {
        self.code = code
        self.slideFontSize = slideFontSize
        self.lineSpacing = slideLineSpacing
    }
}

#if os(iOS)
extension Code: UIViewRepresentable {

    public func makeUIView(context: Context) -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        return label
    }

    public func updateUIView(_ uiView: UILabel, context: Context) {
        let scale = context.environment.slideScale

        let fontSize = scale * slideFontSize
        let theme = Theme.presentation(withFont: Font(size: fontSize))
        let format = SlideCodeFormat(
            theme: theme,
            lineSpacing: scale * lineSpacing
        )
        let highlighter = SyntaxHighlighter(format: format)
        uiView.attributedText = highlighter.highlight(code)
    }
}
#else
extension Code: NSViewRepresentable {

    public func makeNSView(context: Context) -> NSTextField {
        let textField = NSTextField()
        textField.isBezeled = false
        textField.drawsBackground = false
        textField.isEditable = false
        textField.isSelectable = false
        return textField
    }

    public func updateNSView(_ nsView: NSTextField, context: Context) {
        let scale = context.environment.slideScale

        let fontSize = scale * slideFontSize
        let theme = Theme.presentation(withFont: Font(size: fontSize))
        let format = SlideCodeFormat(
            theme: theme,
            lineSpacing: scale * lineSpacing
        )
        let highlighter = SyntaxHighlighter(format: format)
        nsView.attributedStringValue = highlighter.highlight(code)
    }
}
#endif
