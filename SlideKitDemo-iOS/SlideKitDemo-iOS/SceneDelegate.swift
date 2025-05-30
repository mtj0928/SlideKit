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
    static let slideIndexController = SlideIndexController(index: 0, transition: { from, to in
        if let from, from > to {
            return .push(from: .leading)
        } else {
            return .push(from: .trailing)
        }
    }) {
        BasicSlide()
        CodeSlide()
        CustomHeaderStyleSlide()
    }

    var window: UIWindow?

    var content: some View {
        SlideRouterView(slideIndexController: Self.slideIndexController)
            .background(.white)
            .foregroundColor(.black)
    }

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        setup(scene, willConnectTo: session, options: connectionOptions)
    }
}
