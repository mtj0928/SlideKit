
//
//  Code.swift
//  
//
//  Created by Junnosuke Matsumoto on 2022/09/09.
//

import Splash
import SwiftUI

public struct Code: View {

    let code: String
    let colorTheme: CodeColorTheme
    let fontSize: CGFloat

    public init(
        _ code: String,
        colorTheme: CodeColorTheme = .presentation,
        fontSize: CGFloat = 48
    ) {
        self.code = code
        self.colorTheme = colorTheme
        self.fontSize = fontSize
    }

    public var body: some View {
        let theme = colorTheme.buildTheme(with: Font(size: fontSize))
        let format = SlideCodeFormat(theme: theme)
        let highlighter = SyntaxHighlighter(format: format)
        let attributedString = highlighter.highlight(code)
        return Text(attributedString)
    }
}

struct Code_Previews: PreviewProvider {
    static var previews: some View {
        SlidePreview {
            ViewSlide {
                Code(code, colorTheme: .defaultDark)
                    .lineSpacing(12)
            }
        }
        .previewSlideBackgroundColor(SwiftUI.Color(red: 42 / 255, green: 42 / 255, blue: 48 / 255))
    }

    private static var code: String {
"""
#if os(macOS)
let hoge = Hoge("hoge", \\.hoge).call()
switch hoge {
    case .hoge: break
}
return hoge
#endif
"""
    }
}
