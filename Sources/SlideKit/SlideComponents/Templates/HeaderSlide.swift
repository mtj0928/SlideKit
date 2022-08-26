//
//  HeaderSlide.swift
//  
//
//  Created by Junnosuke Matsumoto on 2022/08/25.
//

import SwiftUI

public struct HeaderSlide<Header, Content>: Slide where Header: View, Content: View {

    let header: () -> Header
    let content: () -> Content

    public init(_ header: String, @ViewBuilder content: @escaping () -> Content) where Header == Text {
        self.header = {
            Text(header)
                .fontWeight(.semibold)
        }
        self.content = content
    }

    public init(@ViewBuilder header: @escaping () -> Header, @ViewBuilder content: @escaping () -> Content) {
        self.header = header
        self.content = content
    }

    public var body: some View {
        SlideVStack(alignment: .leading, spacing: .zero) {
            SlideVStack(alignment: .leading, spacing: 80) {
                SlideHStack(spacing: 32) {
                    Capsule()
                        .foregroundColor(.accentColor)
                        .slideFrame(width: 10, height: 120)
                    header()
                        .slideFontSize(90)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                SlideVStack(alignment: .leading, spacing: 48) {
                    content()
                        .slideFontSize(48)
                }
            }
            Spacer(minLength: 0)
        }
        .slidePadding(60)
    }
}
