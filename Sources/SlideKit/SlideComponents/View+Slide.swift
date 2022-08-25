//
//  View+Slide.swift
//  
//
//  Created by Junnosuke Matsumoto on 2022/08/25.
//

import SwiftUI

struct SlideFontModifier: ViewModifier {
    @Environment(\.slideScale) private var slideScale
    let fontSize: CGFloat

    func body(content: Content) -> some View {
        content.font(.system(size: slideScale * fontSize))
    }
}

extension View {
    public func slideFontSize(_ size: CGFloat) -> some View {
        modifier(SlideFontModifier(fontSize: size))
    }
}

struct SlidePaddingModifier: ViewModifier {

    @Environment(\.slideScale) private var slideScale

    let edges: Edge.Set
    let length: CGFloat

    func body(content: Content) -> some View {
        content.padding(edges, slideScale * length)
    }
}

extension View {
    public func slidePadding(_ edges: Edge.Set = .all, _ length: CGFloat = 24) -> some View {
        modifier(SlidePaddingModifier(edges: edges, length: length))
    }
}

struct SlideFrameModifier: ViewModifier {

    @Environment(\.slideScale) private var slideScale

    let width: CGFloat?
    let height: CGFloat?
    let alignment: Alignment

    func body(content: Content) -> some View {
        content.frame(width: width.map { slideScale * $0 }, height: height.map { slideScale * $0 }, alignment: alignment)
    }
}

extension View {
    public func slideFrame(width: CGFloat? = nil, height: CGFloat? = nil, alignment: Alignment = .center) -> some View {
        modifier(SlideFrameModifier(width: width, height: height, alignment: alignment))
    }
}

struct SlidePositionModifier: ViewModifier {

    @Environment(\.slideScale) private var slideScale

    let x: CGFloat
    let y: CGFloat

    func body(content: Content) -> some View {
        content.position(x: slideScale * x, y: slideScale * y)
    }
}

extension View {
    public func slidePosition(x: CGFloat = .zero, y: CGFloat = .zero) -> some View {
        modifier(SlidePositionModifier(x: x, y: y))
    }

    public func slidePosition(_ point: CGPoint) -> some View {
        slidePosition(x: point.x, y: point.y)
    }
}

struct SlideCornerRadiusModifier: ViewModifier {

    @Environment(\.slideScale) private var slideScale

    let radius: CGFloat
    let antialiased: Bool

    func body(content: Content) -> some View {
        content.cornerRadius(slideScale * radius, antialiased: antialiased)
    }
}

extension View {
    public func slideCornerRadius(_ radius: CGFloat, antialiased: Bool = true) -> some View {
        modifier(SlideCornerRadiusModifier(radius: radius, antialiased: antialiased))
    }
}

struct SlideOffsetModifier: ViewModifier {

    @Environment(\.slideScale) private var slideScale

    let x: CGFloat
    let y: CGFloat

    func body(content: Content) -> some View {
        content.offset(x: slideScale * x, y: slideScale * y)
    }
}

extension View {
    public func slideOffset(x: CGFloat = .zero, y: CGFloat = .zero) -> some View {
        modifier(SlideOffsetModifier(x: x, y: y))
    }

    public func slideOffset(_ size: CGSize) -> some View {
        modifier(SlideOffsetModifier(x: size.width, y: size.height))
    }
}


struct SlideShadowModifier: ViewModifier {
    @Environment(\.slideScale) private var slideScale

    let color: Color
    let radius: CGFloat
    let x: CGFloat
    let y: CGFloat

    func body(content: Content) -> some View {
        content.shadow(color: color, radius: slideScale * radius, x: slideScale * x, y: slideScale * y)
    }
}

extension View {
    public func slideShadow(
        color: Color = Color(.sRGBLinear, white: 0, opacity: 0.33),
        radius: CGFloat,
        x: CGFloat = .zero,
        y: CGFloat = .zero
    ) -> some View {
        modifier(SlideShadowModifier(color: color, radius: radius, x: x, y: y))
    }
}

struct SlideLineSpacing: ViewModifier {

    @Environment(\.slideScale) var slideScale
    let lineSpacing: CGFloat

    func body(content: Content) -> some View {
        content.lineSpacing(slideScale * lineSpacing)
    }
}

extension View {
    public func slideLineSpace(_ lineSpacing: CGFloat) -> some View {
        modifier(SlideLineSpacing(lineSpacing: lineSpacing))
    }
}
