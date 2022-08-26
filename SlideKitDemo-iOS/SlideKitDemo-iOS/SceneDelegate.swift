//
//  SceneDelegate.swift
//  SlideKitDemo-iOS
//
//  Created by Junnosuke Matsumoto on 2022/08/25.
//

import SlideKit
import SwiftUI
import UIKit

final class SceneDelegate: NSObject, SlideWindowSceneDelegate {
    
    static let slideSize = SlideSize.standard16_9
    static let externalDisplayManager = ExternalDisplayManager(slideIndexController: slideIndexController)
    static let slideIndexController = SlideIndexController(index: 0) {
        TitleSlide(title: "Hoge")
        BasicSlide()
    }

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
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
