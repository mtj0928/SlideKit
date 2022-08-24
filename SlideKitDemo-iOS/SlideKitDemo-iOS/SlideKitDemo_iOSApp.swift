//
//  SlideKitDemo_iOSApp.swift
//  SlideKitDemo-iOS
//
//  Created by Junnosuke Matsumoto on 2022/08/25.
//

import SwiftUI

@main
struct SlideKitDemo_iOSApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self)
    var appDelegate

    var body: some Scene {
        WindowGroup {
            EmptyView()
        }
    }
}
