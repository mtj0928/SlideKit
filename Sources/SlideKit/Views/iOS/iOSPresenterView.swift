//
//  iOSPresenterView.swift
//  
//
//  Created by Junnosuke Matsumoto on 2022/08/24.
//

import SwiftUI

#if canImport(UIKit)
public struct iOSPresenterView<Content>: View where Content: View {

    private let slideSize: CGSize
    @ObservedObject private var slideIndexController: SlideIndexController
    @ObservedObject private var externalDisplayManager: ExternalDisplayManager
    private let content: () -> Content

    public init(
        slideSize: CGSize,
        slideIndexController: SlideIndexController,
        externalDisplayManager: ExternalDisplayManager,
        content: @escaping () -> Content
    ) {
        self.slideSize = slideSize
        self.slideIndexController = slideIndexController
        self.externalDisplayManager = externalDisplayManager
        self.content = content
    }

    public var body: some View {
        ZStack(alignment: .center) {
            Color.slideDefaultBackground
            SlideScreen(slideSize: slideSize) {
                content()
            }
            .clipped()
#if os(iOS)
            .overlay {
                menuButton
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                    .padding()
            }
#endif
        }
        .ignoresSafeArea()
    }

    private var menuButton: some View {
        Menu {
            backToFirstButton
            externalDisplayButton
        } label: {
            Image(systemName: "ellipsis.circle")
                .resizable()
                .scaledToFit()
        }
        .frame(width: 40, height: 40)
    }

    private var externalDisplayButton: some View {
        Button(
            action: {
                externalDisplayManager.switchDisplayMode()
            },
            label: {
                switch externalDisplayManager.externalDisplayMode {
                case .presentation:
                    Image(systemName: "airplayvideo")
                    Text("Switch to mirroring")
                case .mirroring:
                    Image(systemName: "play.rectangle.on.rectangle")
                    Text("Switch to presentation")
                }
            }
        )
        .buttonStyle(.borderedProminent)
        .padding(8)
    }

    private var backToFirstButton: some View {
        Button {
            slideIndexController.backToFirst()
        } label: {
            Image(systemName: "arrowshape.turn.up.backward.2")
            Text("Back to first")
        }
    }
}

struct iOSPresenterView_Previews: PreviewProvider {
    static var previews: some View {
        iOSPresenterView(
            slideSize: SlideSize.standard16_9,
            slideIndexController: .previews,
            externalDisplayManager: .previews
        ) {
            SlideRouterView(slideIndexController: .previews)
        }
    }
}
#endif
