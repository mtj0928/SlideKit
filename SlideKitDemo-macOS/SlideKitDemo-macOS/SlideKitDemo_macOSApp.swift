//
//  SlideKitDemo_macOSApp.swift
//  SlideKitDemo-macOS
//
//  Created by Junnosuke Matsumoto on 2022/08/26.
//

import SwiftUI
import SlideKit

@main
struct SlideKitDemo_macOSApp: App {

    /// Edit slide configurations in SlideConfiguration.swift
    private static let configuration = SlideConfiguration()

    /// A presentation content view.
    /// Edit the view if you'd like to set environment, overlay view or background view here.
    var presentationContentView: some View {
        SlideRouterView(slideIndexController: Self.configuration.slideIndexController)
            .slideTheme(Self.configuration.theme)
            .background(.white)
    }

    var body: some Scene {
        WindowGroup {
            PresentationView(slideSize: Self.configuration.size) {
                presentationContentView
            }
        }
        .setupAsPresentationWindow(Self.configuration.slideIndexController, appName: "slide")

        WindowGroup {
            macOSPresenterView(
                slideSize: Self.configuration.size,
                slideIndexController: Self.configuration.slideIndexController
            ) {
                presentationContentView
            }
        }
        .setupAsPresenterWindow()
    }
}
