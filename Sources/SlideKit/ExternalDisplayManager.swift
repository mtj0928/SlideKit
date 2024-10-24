//
//  ExternalDisplayManager.swift
//  
//
//  Created by Junnosuke Matsumoto on 2022/08/24.
//

#if os(iOS)
import SwiftUI
import UIKit

@available(iOS 15.0, *)
@MainActor public final class ExternalDisplayManager: ObservableObject {

    @Published
    public private(set) var externalDisplayMode = ExternalDisplayMode.presentation

    private let slideIndexController: SlideIndexController

    public init(slideIndexController: SlideIndexController) {
        self.slideIndexController = slideIndexController
    }

    @MainActor
    public func switchDisplayMode() {
        switch externalDisplayMode {
        case .presentation: switchToMirroring()
        case .mirroring: switchToPresentation()
        }
        externalDisplayMode = externalDisplayMode.opposite
    }

    @MainActor
    private func switchToMirroring() {
        externalDisplayWindowScenes.forEach { windowScene in
            guard windowScene.delegate != nil else { return }
            guard let windowSceneDelegate = windowScene.delegate as? any SlideWindowSceneDelegate else {
                fatalError("WindowScene must conform SlideWindowSceneDelegate")
            }
            windowSceneDelegate.startMirroring()
        }
    }

    @MainActor
    private func switchToPresentation() {
        externalDisplayWindowScenes.forEach { windowScene in
            guard windowScene.delegate != nil else { return }
            guard let windowSceneDelegate = windowScene.delegate as? any SlideWindowSceneDelegate else {
                fatalError("WindowScene must conform SlideWindowSceneDelegate")
            }
            windowSceneDelegate.startPresentation(windowScene: windowScene)
        }
    }
}

@available(iOS 15.0, *)
extension ExternalDisplayManager {

    private var externalDisplayWindowScenes: [UIWindowScene] {
        UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .filter { $0.session.role == .externalDisplay }
    }
}

public enum ExternalDisplayMode {
    case presentation
    case mirroring

    var opposite: ExternalDisplayMode {
        switch self {
        case .presentation: return .mirroring
        case .mirroring: return .presentation
        }
    }
}
#endif
