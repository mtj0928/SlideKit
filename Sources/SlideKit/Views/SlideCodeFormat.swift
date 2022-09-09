//
//  File.swift
//  
//
//  Created by Junnosuke Matsumoto on 2022/09/09.
//

import Splash
#if os(iOS)
import UIKit
#else
import AppKit
#endif


struct SlideCodeFormat: OutputFormat {
    let theme: Theme
    let lineSpacing: CGFloat

    func makeBuilder() -> Builder {
        SlideCodeFormat.Builder(theme: theme, lineSpacing: lineSpacing)
    }
}

extension SlideCodeFormat {
    struct Builder: OutputBuilder {
        let theme: Theme
        let lineSpacing: CGFloat

        init(theme: Theme, lineSpacing: CGFloat) {
            self.theme = theme
            self.lineSpacing = lineSpacing
        }

#if os(iOS)
        typealias Font = UIFont
#else
        typealias Font = NSFont
#endif
        private lazy var regularFont = Font.monospacedSystemFont(ofSize: CGFloat(theme.font.size), weight: .regular)
        private lazy var boldFont = Font.monospacedSystemFont(ofSize: CGFloat(theme.font.size), weight: .medium)
        private var string = NSMutableAttributedString()

        mutating func font(type: TokenType) -> Font {
            switch type {
            case .keyword: return boldFont
            default: return regularFont
            }
        }

        public mutating func addToken(_ token: String, ofType type: TokenType) {
            let color = theme.tokenColors[type] ?? Color(red: 1, green: 1, blue: 1)
            append(token, font: font(type: type), color: color)
        }

        public mutating func addPlainText(_ text: String) {
            append(text, font: regularFont, color: theme.plainTextColor)
        }

        public mutating func addWhitespace(_ whitespace: String) {
            let color = Color(red: 1, green: 1, blue: 1)
            append(whitespace, font: regularFont, color: color)
        }

        public func build() -> NSAttributedString {
            return NSAttributedString(attributedString: string)
        }

        private func append(_ string: String, font: Font, color: Splash.Color) {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = lineSpacing

            let attributedString = NSAttributedString(string: string, attributes: [
                .foregroundColor: color,
                .font: font,
                .paragraphStyle: paragraphStyle
            ])

            self.string.append(attributedString)
        }
    }
}

extension Splash.Color {
    convenience init(red: CGFloat, green: CGFloat, blue: CGFloat) {
        self.init(red: red, green: green, blue: blue, alpha: 1)
    }
}
