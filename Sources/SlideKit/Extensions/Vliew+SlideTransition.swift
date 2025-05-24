//
//  Vliew+SlideTransition.swift
//  
//
//  Created by Junnosuke Matsumoto on 2022/08/24.
//

import SwiftUI

struct SlideTransitionModifier: ViewModifier {
    var back: () -> Void
    var forward: () -> Void

    @FocusState private var focused1: Bool
    @FocusState private var focused2: Bool

    func body(content: Content) -> some View {
        let opacity: CGFloat = 0.001
#if os(tvOS)
        return content.background {
            HStack(spacing: .zero) {
                Button("Back", action: back)
                    .focused($focused1)
                    .opacity(focused1 ? 1 : 0)
                Spacer()
                Button("Forward", action: forward)
                    .focused($focused2)
                    .opacity(focused2 ? 1 : 0)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        }
#else
        return content.background {
            HStack(spacing: 0) {
                Rectangle().foregroundColor(.black.opacity(opacity))
                    .onTapGesture { back() }
                Rectangle().foregroundColor(.black.opacity(opacity))
                    .onTapGesture { forward() }
            }
        }
#endif
    }
}

extension View {

    public func slideTransition(
        back: @escaping () -> Void,
        forward: @escaping () -> Void
    ) -> some View {
        self.modifier(SlideTransitionModifier(back: back, forward: forward))
    }
}
