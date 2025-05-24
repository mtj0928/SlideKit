import SwiftSyntaxInk
import SyntaxInk
import SwiftUI

extension SyntaxHighlighter where Self == SwiftSyntaxHighlighter {

    /// A color theme matching Xcode's "Presentation" theme
    public static var presentation: Self {
        presentation(size: 48)
    }

    /// A color theme matching Xcode's "Presentation" theme
    public static func presentation(size: CGFloat) -> Self {
        SwiftSyntaxHighlighter(theme: SwiftTheme { kind in
            var base = SyntaxStyle(
                font: .custom(name: "Menlo", size: size, weight: .regular),
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
    public static func presentationDark(size: CGFloat) -> Self {
        SwiftSyntaxHighlighter(theme: SwiftTheme { kind in
            var base = SyntaxStyle(
                font: .custom(name: "Menlo", size: size, weight: .regular),
                color: SyntaxColor(red: 255, green: 255, blue: 255)
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
}
