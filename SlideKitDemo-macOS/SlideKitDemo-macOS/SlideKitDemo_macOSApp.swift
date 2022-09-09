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

    /// Please edit the default value to the size you want
    let slideSize = SlideSize.standard16_9

    /// Please add your slide into the trailing closure
    let slideIndexController = SlideIndexController {
        BasicSlide()
    }

    var body: some Scene {
        WindowGroup {
            PresentationView(slideSize: slideSize) {
                SlideRouterView(slideIndexController: slideIndexController)
                    .background(.white)
            }
        }
        .windowStyle(.hiddenTitleBar)
        .commands {
            CommandGroup(after: .undoRedo) {
                forwardButton(.rightArrow)
                forwardButton(.return)
                backButton(.leftArrow)
            }

            CommandGroup(after: .windowList) {
                Button("Open Presenter Window") { NSWorkspace.shared.open(URL(string: "slide://editor")!) }
                    .keyboardShortcut("p", modifiers: .command)
            }
        }

        WindowGroup {
            macOSPresenterView(slideSize: slideSize, slideIndexController: slideIndexController) {
                SlideRouterView(slideIndexController: slideIndexController)
                    .background(.white)
            }
        }
        .handlesExternalEvents(matching: ["editor"])
    }
}

extension SlideKitDemo_macOSApp {

    private func forwardButton(_ key: KeyEquivalent) -> some View {
        Button("forward") { slideIndexController.forward() }
            .keyboardShortcut(key, modifiers: [])
    }

    private func backButton(_ key: KeyEquivalent) -> some View {
        Button("back") { slideIndexController.back() }
            .keyboardShortcut(key, modifiers: [])
    }
}
