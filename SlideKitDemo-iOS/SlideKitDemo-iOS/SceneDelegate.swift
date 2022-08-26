//
//  SceneDelegate.swift
//  SlideKitDemo-iOS
//
//  Created by Junnosuke Matsumoto on 2022/08/25.
//

import SlideKit
import SwiftUI
import UIKit

class SceneDelegate: NSObject, SlideWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        if session.role == .externalDisplay && ExternalDisplayManager.shared.externalDisplayMode == .mirroring {
            return
        }

        self.window = makeRootWindow(
            windowScene: windowScene,
            slideIndexController: .shared,
            slidePresentationMode: session.role == .externalDisplay ? .presentation : .presenter
        )
    }

    func makeRootWindow(windowScene: UIWindowScene, slideIndexController: SlideIndexController, slidePresentationMode: SlidePresentationMode) -> UIWindow {
        let window = UIWindow(windowScene: windowScene)
        let swiftUIView = rootView(for: slidePresentationMode)
        let hostingController = UIHostingController(rootView: swiftUIView)
        window.rootViewController = hostingController
        window.makeKeyAndVisible()
        return window
    }

    @ViewBuilder
    private func rootView(for presentationMode: SlidePresentationMode) -> some View {
        switch presentationMode {
        case .presenter:
            iOSPresenterView(
                slideSize: SlideSize.standard16_9,
                slideIndexController: .shared,
                externalDisplayManager: .shared
            ) {
                SlideRouterView(slideIndexController: .shared)
                    .background(.white)
            }
        case .presentation:
            PresentationView(slideSize: SlideSize.standard16_9) {
                SlideRouterView(slideIndexController: .shared)
                    .background(.white)
            }
        }
    }
}

extension SlideIndexController {
    @MainActor
    fileprivate static let shared = SlideIndexController(index: 0) {
        TitleSlide(title: "Hoge")
        BasicSlide()
    }
}

extension ExternalDisplayManager {
    fileprivate static let shared = ExternalDisplayManager(slideIndexController: .shared)
}
