//
//  SlideWindowSceneDelegate.swift
//  
//
//  Created by Junnosuke Matsumoto on 2022/08/24.
//

#if canImport(UIKit)
import SwiftUI
import UIKit

public protocol SlideWindowSceneDelegate where Self: UIWindowSceneDelegate {
    associatedtype SlideContent: View
    var window: UIWindow? { get set }
    var content: SlideContent { get }

    static var slideSize: CGSize { get }
    static var slideIndexController: SlideIndexController { get }
    static var externalDisplayManager: ExternalDisplayManager { get }

    func makeRootWindow(windowScene: UIWindowScene, slidePresentationMode: SlidePresentationMode) -> UIWindow
    func rootView(for presentationMode: SlidePresentationMode) -> AnyView
}

extension SlideWindowSceneDelegate {

    public func setup(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        if session.role == .externalDisplay && Self.externalDisplayManager.externalDisplayMode == .mirroring {
            return
        }

        self.window = makeRootWindow(
            windowScene: windowScene,
            slidePresentationMode: session.role == .externalDisplay ? .presentation : .presenter
        )
    }
}

extension SlideWindowSceneDelegate {
    func startMirroring() {
        guard self.window?.windowScene?.session.role == .externalDisplay else {
            return
        }
        window = nil
    }

    func startPresentation(windowScene: UIWindowScene) {
        guard windowScene.session.role == .externalDisplay else {
            return
        }
        window = makeRootWindow(windowScene: windowScene, slidePresentationMode: .presentation)
    }

    public func makeRootWindow(windowScene: UIWindowScene, slidePresentationMode: SlidePresentationMode) -> UIWindow {
        let window = UIWindow(windowScene: windowScene)
        let swiftUIView = rootView(for: slidePresentationMode)
        let hostingController = UIHostingController(rootView: swiftUIView)
        window.rootViewController = hostingController
        window.makeKeyAndVisible()
        return window
    }

    public func rootView(for presentationMode: SlidePresentationMode) -> AnyView {
        AnyView(_RootView(
            presentationMode: presentationMode,
            slideSize: Self.slideSize,
            slideIndexController: Self.slideIndexController,
            externalDisplayManager: Self.externalDisplayManager
        ) { [weak self] in
            if let self {
                self.content
            } else {
                Text("failed to cast self")
            }
        })
    }
}

public struct _RootView<Content: View>: View {
    let presentationMode: SlidePresentationMode
    let slideSize: CGSize
    let slideIndexController: SlideIndexController
    let externalDisplayManager: ExternalDisplayManager

    let content: () -> Content

    init(
        presentationMode: SlidePresentationMode,
        slideSize: CGSize,
        slideIndexController: SlideIndexController,
        externalDisplayManager: ExternalDisplayManager,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.presentationMode = presentationMode
        self.slideSize = slideSize
        self.slideIndexController = slideIndexController
        self.externalDisplayManager = externalDisplayManager
        self.content = content
    }

    public var body: some View {
        switch presentationMode {
        case .presenter:
            iOSPresenterView(
                slideSize: slideSize,
                slideIndexController: slideIndexController,
                externalDisplayManager: externalDisplayManager
            ) {
                content()
            }
        case .presentation:
            PresentationView(slideSize: slideSize) {
                content()
            }
        }
    }
}
#endif
