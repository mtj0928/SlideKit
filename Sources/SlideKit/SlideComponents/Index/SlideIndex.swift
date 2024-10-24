//
//  SwiftUIView.swift
//  
//
//  Created by Junnosuke Matsumoto on 2022/09/28.
//

import SwiftUI

struct Index: View {

    @ObservedObject
    var slideIndexController: SlideIndexController

    @Environment(\.indexStyle)
    private var indexStyle

    var body: some View {
        indexStyle.makeBody(configuration: .init(slideIndexController: slideIndexController))
    }
}

enum IndexStyleKey: EnvironmentKey {
    static let defaultValue = AnyIndexStyle(indexStyle: DefaultIndexStyle())
}

extension EnvironmentValues {
    var indexStyle: AnyIndexStyle {
        get { self[IndexStyleKey.self] }
        set { self[IndexStyleKey.self] = newValue }
    }
}

@MainActor
public protocol IndexStyle: Sendable {
    typealias Configuration = IndexConfiguration
    associatedtype Body : View

    @ViewBuilder func makeBody(configuration: Self.Configuration) -> Self.Body
}

extension IndexStyle where Self == DefaultIndexStyle {
    public static var `default`: DefaultIndexStyle {
        DefaultIndexStyle()
    }
}

struct AnyIndexStyle: IndexStyle {
    let indexStyle: any IndexStyle
    func makeBody(configuration: Configuration) -> AnyView {
        AnyView(indexStyle.makeBody(configuration: configuration))
    }
}

public struct IndexConfiguration {
    public let slideIndexController: SlideIndexController
}

public struct DefaultIndexStyle: IndexStyle {
    public func makeBody(configuration: Configuration) -> some View {
        Text("\(configuration.slideIndexController.currentIndex)")
            .foregroundColor(.gray)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
            .font(.system(size: 30))
            .padding()
    }
}

extension View {
    public func indexStyle(_ style: some IndexStyle) -> some View {
        environment(\.indexStyle, AnyIndexStyle(indexStyle: style))
    }
}
