//
//  SlideWindowSceneDelegate.swift
//  
//
//  Created by Junnosuke Matsumoto on 2022/08/24.
//

#if os(iOS)
import SwiftUI
import UIKit

public protocol SlideWindowSceneDelegate where Self: UIWindowSceneDelegate {
    var window: UIWindow? { get set }
    static var slideSize: CGSize { get }
    static var slideIndexController: SlideIndexController { get }
    static var externalDisplayManager: ExternalDisplayManager { get }

    func makeRootWindow(windowScene: UIWindowScene, slidePresentationMode: SlidePresentationMode) -> UIWindow
    func rootView(for presentationMode: SlidePresentationMode) -> AnyView
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

        ))
    }
}

public struct _RootView: View {
    let presentationMode: SlidePresentationMode
    let slideSize: CGSize
    let slideIndexController: SlideIndexController
    let externalDisplayManager: ExternalDisplayManager

    public var body: some View {
        switch presentationMode {
        case .presenter:
            iOSPresenterView(
                slideSize: slideSize,
                slideIndexController: slideIndexController,
                externalDisplayManager: externalDisplayManager
            ) {
                SlideRouterView(slideIndexController: slideIndexController)
                    .background(.white)
            }
        case .presentation:
            PresentationView(slideSize: slideSize) {
                SlideRouterView(slideIndexController: slideIndexController)
                    .background(.white)
            }
        }
    }
}
#endif
