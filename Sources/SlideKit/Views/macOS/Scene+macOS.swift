//
//  Scene+macOS.swift
//  
//
//  Created by Junnosuke Matsumoto on 2022/09/21.
//
#if os(macOS)
import SwiftUI

extension Scene {

    public func setupAsPresentationWindow(
        _ slideIndexController: SlideIndexController,
        appName: String
    ) -> some Scene {
        windowStyle(.hiddenTitleBar)
            .commands {
                CommandGroup(after: .undoRedo) {
                    forwardButton(.rightArrow, slideIndexController: slideIndexController)
                    forwardButton(.return, slideIndexController: slideIndexController)
                    backButton(.leftArrow, slideIndexController: slideIndexController)
                }

                CommandGroup(after: .windowList) {
                    Button("Open Presenter Window") { NSWorkspace.shared.open(URL(string: "\(appName)://editor")!) }
                        .keyboardShortcut("p", modifiers: .command)
                }
            }
    }

    private func forwardButton(_ key: KeyEquivalent, slideIndexController: SlideIndexController) -> some View {
        Button("forward") { slideIndexController.forward() }
            .keyboardShortcut(key, modifiers: [])
    }

    private func backButton(_ key: KeyEquivalent, slideIndexController: SlideIndexController) -> some View {
        Button("back") { slideIndexController.back() }
            .keyboardShortcut(key, modifiers: [])
    }

    public func setupAsPresenterWindow() -> some Scene {
        handlesExternalEvents(matching: ["editor"])
    }

    @MainActor
    public func addPDFExportCommands(
        for view: some View,
        with slideIndexController: SlideIndexController,
        size slideSize: CGSize
    ) -> some Scene {
        self.commands {
            CommandGroup(after: .importExport) {
                if #available(macOS 13.0, *) {
                    Button("Export PDF") {
                        SlidePDFExporter.export(
                            view: view,
                            with: slideIndexController,
                            size: slideSize
                        )
                    }
                }
            }
        }
    }
}
#endif
