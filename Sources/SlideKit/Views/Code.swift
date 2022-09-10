
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
    let slideFontSize: CGFloat
    let lineSpacing: CGFloat

    public init(_ code: String, slideFontSize: CGFloat = 48, slideLineSpacing: CGFloat = 12) {
        self.code = code
        self.slideFontSize = slideFontSize
        self.lineSpacing = slideLineSpacing
    }

    public var body: some View {
        let fontSize = scale * slideFontSize
        let theme = Theme.presentation(withFont: Font(size: fontSize))
        let format = SlideCodeFormat(
            theme: theme,
            lineSpacing: scale * lineSpacing
        )
        let highlighter = SyntaxHighlighter(format: format)
        let attributedString = highlighter.highlight(code)
        return Text(attributedString)
    }
}
