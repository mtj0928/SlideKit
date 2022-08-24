//
//  Vliew+SlideTransition.swift
//  
//
//  Created by Junnosuke Matsumoto on 2022/08/24.
//

import SwiftUI

extension View {

    public func slideTransition(
        back: @escaping () -> Void,
        forward: @escaping () -> Void
    ) -> some View {
        let opacity: CGFloat = 0.001
        return self.background {
            HStack(spacing: 0) {
                Rectangle().foregroundColor(.black.opacity(opacity))
                    .onTapGesture { back() }
                Rectangle().foregroundColor(.black.opacity(opacity))
                    .onTapGesture { forward() }
            }
        }
    }
}
