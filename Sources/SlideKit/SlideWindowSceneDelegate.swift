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

    func makeRootWindow(windowScene: UIWindowScene, slideIndexController: SlideIndexController, slidePresentationMode: SlidePresentationMode) -> UIWindow
}

extension SlideWindowSceneDelegate {
    func startMirroring() {
        guard self.window?.windowScene?.session.role == .externalDisplay else {
            return
        }
        window = nil
    }

    func startPresentation(windowScene: UIWindowScene, slideIndexController: SlideIndexController) {
        guard windowScene.session.role == .externalDisplay else {
            return
        }
        window = makeRootWindow(windowScene: windowScene, slideIndexController: slideIndexController, slidePresentationMode: .presentation)
    }
}
#endif
