//
//  SlideCodeFormat.swift
//  
//
//  Created by Junnosuke Matsumoto on 2022/09/09.
//

import Splash
import SwiftUI

struct SlideCodeFormat: OutputFormat {
    let theme: Theme

    func makeBuilder() -> Builder {
        SlideCodeFormat.Builder(theme: theme)
    }
}

extension SlideCodeFormat {
    struct Builder: OutputBuilder {
        let theme: Theme

        init(theme: Theme) {
            self.theme = theme
        }

        private lazy var regularFont = SwiftUI.Font.system(size: CGFloat(theme.font.size), weight: .regular, design: .monospaced)
        private lazy var boldFont = SwiftUI.Font.system(size: CGFloat(theme.font.size), weight: .semibold, design: .monospaced)
        private var string = AttributedString()

        mutating func font(type: TokenType) -> SwiftUI.Font {
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

        public func build() -> AttributedString {
            string
        }

        private mutating func append(_ string: String, font: SwiftUI.Font, color: Splash.Color) {
            var attributedString = AttributedString(string)
            attributedString.foregroundColor = Color(color)
            attributedString.font = font

            self.string.append(attributedString)
        }
    }
}

extension Splash.Color {
    public convenience init(red: CGFloat, green: CGFloat, blue: CGFloat) {
        self.init(red: red, green: green, blue: blue, alpha: 1)
    }
}
