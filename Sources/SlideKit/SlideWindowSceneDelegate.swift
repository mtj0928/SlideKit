//
//  SlideWindowSceneDelegate.swift
//  
//
//  Created by Junnosuke Matsumoto on 2022/08/24.
//

#if os(iOS)
import UIKit

public protocol SlideWindowSceneDelegate where Self: UIWindowSceneDelegate {
    var window: UIWindow? { get set }

    func makeRootWindow(windowScene: UIWindowScene, slideIndexController: SlideIndexController) -> UIWindow
}

extension SlideWindowSceneDelegate {
    func startMirroring() {
        guard self.window?.windowScene?.session.role == .externalDisplay else {
            return
        }
        window = nil
    }

    func startPresentation(slideIndexController: SlideIndexController) {
        guard let windowScene = window?.windowScene,
            windowScene.session.role == .externalDisplay else {
            return
        }
        window = makeRootWindow(windowScene: windowScene, slideIndexController: slideIndexController)
    }
}
#endif
