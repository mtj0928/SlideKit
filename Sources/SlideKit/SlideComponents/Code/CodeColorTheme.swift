//
//  CodeColorTheme.swift
//  
//
//  Created by Junnosuke Matsumoto on 2022/09/23.
//

import Splash
import SwiftUI

public struct CodeColorTheme {

    public var plainTextColor: Splash.Color
    public var tokenColors: [TokenType: Splash.Color]

    public init(
        plainTextColor: Splash.Color,
        tokenColors: [TokenType: Splash.Color]
    ) {
        self.plainTextColor = plainTextColor
        self.tokenColors = tokenColors
    }

    func buildTheme(with font: Splash.Font) -> Splash.Theme {
        Theme(
            font: font,
            plainTextColor: plainTextColor,
            tokenColors: tokenColors,
            backgroundColor: .clear
        )
    }
}

/// Refer: Theme+Defaults.swift in Splash
extension CodeColorTheme {

    /// A color theme matching Xcode's "Presentation" theme
    public static var presentation: CodeColorTheme {
        CodeColorTheme(
            plainTextColor: Color(red: 0, green: 0, blue: 0),
            tokenColors: [
                .keyword: Splash.Color(red: 0.706, green: 0.0, blue: 0.384),
                .string: Splash.Color(red: 0.729, green: 0.0, blue: 0.067),
                .type: Splash.Color(red: 0.267, green: 0.537, blue: 0.576),
                .call: Splash.Color(red: 0.267, green: 0.537, blue: 0.576),
                .number: Splash.Color(red: 0.0, green: 0.043, blue: 1.0),
                .comment: Splash.Color(red: 0.336, green: 0.376, blue: 0.42),
                .property: Splash.Color(red: 0.267, green: 0.537, blue: 0.576),
                .dotAccess: Splash.Color(red: 0.267, green: 0.537, blue: 0.576),
                .preprocessing: Splash.Color(red: 0.431, green: 0.125, blue: 0.051)
            ]
        )
    }

    public static var defaultDark: CodeColorTheme {
        CodeColorTheme(
            plainTextColor: Color(red: 1, green: 1, blue: 1),
            tokenColors: [
                .keyword: Splash.Color(red: 252 / 255, green: 96 / 255, blue: 163 / 255),
                .string: Splash.Color(red: 252 / 255, green: 106 / 255, blue: 93 / 255),
                .type: Splash.Color(red: 158 / 255, green: 241 / 255, blue: 221 / 255),
                .call: Splash.Color(red: 103 / 255, green: 183 / 255, blue: 164 / 255),
                .number: Splash.Color(red: 208 / 255, green: 191 / 255, blue: 105 / 255),
                .comment: Splash.Color(red: 108 / 255, green: 121 / 255, blue: 134 / 255),
                .property: Splash.Color(red: 103 / 255, green: 183 / 255, blue: 164 / 255),
                .dotAccess: Splash.Color(red: 103 / 255, green: 183 / 255, blue: 164 / 255),
                .preprocessing: Splash.Color(red: 253 / 255, green: 143 / 255, blue: 63 / 255)
            ]
        )
    }
}
