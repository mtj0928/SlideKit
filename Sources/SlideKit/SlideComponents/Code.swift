
//
//  Code.swift
//  
//
//  Created by Junnosuke Matsumoto on 2022/09/09.
//

import Splash
import SwiftUI

public struct Code: View {

    @Environment(\.slideScale)
    var scale

    let code: String
    let colorTheme: CodeColorTheme
    let slideFontSize: CGFloat
    let lineSpacing: CGFloat

    public init(
        _ code: String,
        colorTheme: CodeColorTheme = .presentation,
        slideFontSize: CGFloat = 48,
        slideLineSpacing: CGFloat = 12
    ) {
        self.code = code
        self.colorTheme = colorTheme
        self.slideFontSize = slideFontSize
        self.lineSpacing = slideLineSpacing
    }

    public var body: some View {
        let fontSize = scale * slideFontSize
        let theme = colorTheme.buildTheme(with: Font(size: fontSize))
        let format = SlideCodeFormat(theme: theme)
        let highlighter = SyntaxHighlighter(format: format)
        let attributedString = highlighter.highlight(code)
        return Text(attributedString)
            .slideLineSpace(lineSpacing)
    }
}

struct Code_Previews: PreviewProvider {
    static var previews: some View {
        SlidePreview {
            ViewSlide {
                ZStack {
                    SwiftUI.Color(red: 42 / 255, green: 42 / 255, blue: 48 / 255)
                    Code(code, colorTheme: .defaultDark)
                }
            }
        }
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
