import SwiftSyntaxInk
import SyntaxInk
import SwiftUI

extension SyntaxHighlighter where Self == SwiftSyntaxHighlighter {

    /// A color theme matching Xcode's "Presentation" theme
    public static var presentation: Self {
        presentation(fontSize: 48)
    }

    /// A color theme matching Xcode's "Presentation" theme
    public static func presentation(fontSize: CGFloat) -> Self {
        SwiftSyntaxHighlighter(theme: SwiftTheme { kind in
            var base = SyntaxStyle(
                font: .custom(name: "Menlo", size: fontSize, weight: .regular),
                color: SyntaxColor(red: 0, green: 0, blue: 0)
            )
            switch kind {
            case .plainText: break
            case .keywords:
                base.font.weight = .semibold
                base.color = SyntaxColor(red: 180, green: 0, blue: 98, alpha: 0.8)
            case .comments: base.color = SyntaxColor(red: 86, green: 96, blue: 107)
            case .documentationMarkup:
                base.font.name = "Helvetica"
                base.color = SyntaxColor(red: 67, green: 75, blue: 84)
            case .string:
                base.color = SyntaxColor(red: 186, green: 0, blue: 17)
            case .numbers:
                base.color = SyntaxColor(red: 0, green: 11, blue: 255)
            case .preprocessorStatements:
                base.color = SyntaxColor(red: 110, green: 32, blue: 13)
            case .typeDeclarations:
                base.color = SyntaxColor(red: 0, green: 73, blue: 117)
            case .otherDeclarations:
                base.color = SyntaxColor(red: 15, green: 104, blue: 160)
            case .otherClassNames:
                base.color = SyntaxColor(red: 46, green: 13, blue: 110)
            case .otherFunctionAndMethodNames:
                base.color = SyntaxColor(red: 92, green: 38, blue: 153)
            case .otherTypeNames:
                base.color = SyntaxColor(red: 46, green: 13, blue: 110)
            case .otherPropertiesAndGlobals:
                base.color = SyntaxColor(red: 92, green: 38, blue: 153)
            }
            return base
        })
    }

    /// A color theme matching Xcode's "Presentation Dark" theme
    public static var presentationDark: Self {
        presentationDark(fontSize: 48)
    }

    /// A color theme matching Xcode's "Presentation Dark" theme
    public static func presentationDark(fontSize: CGFloat) -> Self {
        SwiftSyntaxHighlighter(theme: SwiftTheme { kind in
            var base = SyntaxStyle(
                font: .custom(name: "Menlo", size: fontSize, weight: .regular),
                color: SyntaxColor(red: 255, green: 255, blue: 255)
            )
            #if os(iOS)
            #endif
            switch kind {
            case .plainText: break
            case .keywords:
                base.font.weight = .semibold
                base.color = SyntaxColor(red: 240, green: 36, blue: 140)
            case .comments: base.color = SyntaxColor(red: 108, green: 121, blue: 135)
            case .documentationMarkup:
                base.font.name = "Helvetica"
                base.color = SyntaxColor(red: 108, green: 121, blue: 135)
            case .string:
                base.color = SyntaxColor(red: 252, green: 70, blue: 81)
            case .numbers:
                base.color = SyntaxColor(red: 255, green: 231, blue: 109)
            case .preprocessorStatements:
                base.color = SyntaxColor(red: 253, green: 143, blue: 63)
            case .typeDeclarations:
                base.color = SyntaxColor(red: 102, green: 218, blue: 255)
            case .otherDeclarations:
                base.color = SyntaxColor(red: 53, green: 176, blue: 216)
            case .otherClassNames:
                base.color = SyntaxColor(red: 208, green: 168, blue: 255)
            case .otherFunctionAndMethodNames:
                base.color = SyntaxColor(red: 171, green: 100, blue: 255)
            case .otherTypeNames:
                base.color = SyntaxColor(red: 208, green: 168, blue: 255)
            case .otherPropertiesAndGlobals:
                base.color = SyntaxColor(red: 171, green: 100, blue: 255)
            }
            return base
        })
    }
}

extension Color {
    public static var presentation: Color {
        Color(red: 1, green: 1, blue: 1)
    }

    public static var presentationDark: Color {
        Color(CGColor(
            red: CGFloat(24) / 255.0,
            green: CGFloat(24) / 255.0,
            blue: CGFloat(28) / 255.0,
            alpha: 1.0
        ))
    }
}
