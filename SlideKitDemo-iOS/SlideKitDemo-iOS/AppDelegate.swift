//
//  AppDelegate.swift
//  SlideKitDemo-iOS
//
//  Created by Junnosuke Matsumoto on 2022/08/25.
//

import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {

    // Don't forget to add scene configurations to Info.plist
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        let configuration = UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
        configuration.delegateClass = SceneDelegate.self
        return configuration
    }
}
