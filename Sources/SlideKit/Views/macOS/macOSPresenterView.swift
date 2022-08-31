//
//  macOSPresenterView.swift
//  
//
//  Created by Junnosuke Matsumoto on 2022/08/31.
//

#if os(macOS)
import Combine
import Foundation
import SwiftUI

public struct macOSPresenterView<Content>: View where Content: View {

    private let slideSize: CGSize
    private let content: () -> Content

    @State
    private var startDate = Date()

    @ObservedObject
    private var slideIndexController: SlideIndexController

    public init(
        slideSize: CGSize,
        slideIndexController: SlideIndexController,
        content: @escaping () -> Content
    ) {
        self.slideSize = slideSize
        self.slideIndexController = slideIndexController
        self.content = content
    }

    public var body: some View {
        VStack {
            HStack {
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
            HStack {
                VStack(alignment: .leading) {
                    scriptView
                    stopwatch
                }
                HStack {
                    backButton
                    forwardButton
                }
            }
            .padding(.horizontal)
            .padding(.bottom)
            .frame(minHeight: 100)
        }
        .background(.black)
#if os(macOS)
        .overlay {
            menuButton
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                .padding()
        }
#endif
    }

    private var menuButton: some View {
        Menu {
            backToFirstButton
        } label: {
            Image(systemName: "ellipsis.circle")
                .resizable()
                .scaledToFit()
        }
        .frame(width: 40, height: 40)
    }

    private var backToFirstButton: some View {
        Button {
            slideIndexController.backToFirst()
        } label: {
            Image(systemName: "arrowshape.turn.up.backward.2")
            Text("Back to first")
        }
    }

    private var scriptView: some View {
        ScrollView {
            HStack(spacing: .zero) {
                Text(slideIndexController.currentSlide.script)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.leading)
                    .lineLimit(nil)
                    .frame(minHeight: 100)
                Spacer(minLength: .zero)
            }
        }
    }

    private var backButton: some View {
        indexControlButton(systemName: "arrow.backward.circle.fill") {
            slideIndexController.back()
        }
    }

    private var forwardButton: some View {
        indexControlButton(systemName: "arrow.forward.circle.fill") {
            slideIndexController.forward()
        }
    }

    private func indexControlButton(systemName: String, completion: @escaping () -> Void) -> some View {
        Button {
            completion()
        } label: {
            Image(systemName: systemName)
                .resizable()
                .scaledToFit()
                .frame(height: 20)
        }
        .buttonStyle(.plain)
        .foregroundColor(.white)
        .frame(maxHeight: .infinity, alignment: .center)
    }

    private var stopwatch: some View {
        HStack {
            Button {
                startDate = Date()
            } label: {
                Image(systemName: "arrow.counterclockwise.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
            }
            .buttonStyle(.plain)
            Text(startDate, style: .timer)
                .font(.title)
                .fontWeight(.heavy)
        }
        .foregroundColor(.white)
    }
}

class Stopwatch: ObservableObject {

    @Published var startDate = Date()
    @Published var elapsedTime: TimeInterval = .zero

    private var cancellable: AnyCancellable?

    init() {
        cancellable = Timer.publish(every: 1, on: .main, in: .default)
            .autoconnect()
            .sink(receiveValue: { [weak self] _ in
                guard let self = self else { return }
                self.elapsedTime = Date().timeIntervalSince(self.startDate)
            })
    }
}

struct macOSPresenterView_Previews: PreviewProvider {
    static var previews: some View {
        macOSPresenterView(
            slideSize: SlideSize.standard16_9,
            slideIndexController: .previews
        ) {
            SlideRouterView(slideIndexController: .previews)
        }
        .preferredColorScheme(.light)
    }
}
#endif
