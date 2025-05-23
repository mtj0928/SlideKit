import SwiftSyntaxInk
import SyntaxInk
import SwiftUI

public struct Code<
    Grammar: SyntaxInk.Grammar,
    Theme: SyntaxInk.Theme
>: View where Grammar.Token == Theme.Token {
    let code: String
    let syntaxHighlighter: SyntaxHighlighter<Grammar, Theme>

    public init(_ code: String, syntaxHighlighter: SyntaxHighlighter<Grammar, Theme>) {
        self.code = code
        self.syntaxHighlighter = syntaxHighlighter
    }

    public init(
        _ code: String,
        syntaxHighlighter: SwiftSyntaxHighlighter = .presentation
    ) where Grammar == SwiftGrammar, Theme == SwiftTheme {
        self.code = code
        self.syntaxHighlighter = syntaxHighlighter
    }

    public var body: some View {
        let attributedString = syntaxHighlighter.highlight(code)
        Text(attributedString)
    }
}

#Preview {
    let sourceCode = """
    #if os(macOS)
    #Preview {
        let hoge = Hoge("hoge", \\.hoge).call()
        switch hoge {
        case .hoge: break
        }
        return hoge
    }
    #endif
    """
    SlidePreview {
        ViewSlide {
            Code(sourceCode)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(32)
        }
    }
}
