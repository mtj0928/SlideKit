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

    @NSApplicationDelegateAdaptor(AppDelegate.self)
    var appDelegate

    var body: some Scene {
        WindowGroup {
            ZStack {
                Color.black
                PresentationView(slideSize: appDelegate.slideSize) {
                    SlideRouterView(slideIndexController: appDelegate.slideIndexController)
                        .background(.white)
                }
                .preferredColorScheme(.light)
                .aspectRatio(appDelegate.slideSize, contentMode: .fit)
            }
            .ignoresSafeArea()
        }
        .windowStyle(.hiddenTitleBar)
        .commands {
            CommandGroup(after: .undoRedo) {
                Button("forward") {
                    appDelegate.slideIndexController.forward()
                }
                .keyboardShortcut("k", modifiers: .command)
                Button("back") {
                    appDelegate.slideIndexController.back()
                }
                .keyboardShortcut("j", modifiers: .command)
            }

            CommandGroup(replacing: CommandGroupPlacement.newItem) {
            }
        }
    }
}
class AppDelegate: NSObject, NSApplicationDelegate {

    let slideSize = SlideSize.standard16_9
    let slideIndexController = SlideIndexController(index: 0) {
        BasicSlide()
    }

    func applicationDidFinishLaunching(_ notification: Notification) {
        NSApp.windows.forEach { window in
            window.delegate = self

            window.standardWindowButton(.zoomButton)?.isHidden = true
            window.standardWindowButton(.miniaturizeButton)?.isHidden = true
            window.standardWindowButton(.closeButton)?.isHidden = true
        }
    }
}

extension AppDelegate: NSWindowDelegate {

    func windowWillResize(_ sender: NSWindow, to frameSize: NSSize) -> NSSize {
        NSSize(width: slideSize.ratio * frameSize.height, height: frameSize.height)
    }
}

extension CGSize {
    var ratio: CGFloat {
        width / height
    }
}
