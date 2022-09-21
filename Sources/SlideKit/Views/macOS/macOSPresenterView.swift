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
            }
            VStack(alignment: .leading) {
                scriptView
                stopwatch
            }
            .padding(.horizontal)
            .padding(.bottom)
            .frame(minHeight: 100)
        }
        .background(.black)
    }

    private var scriptView: some View {
        ScrollView {
            Text(slideIndexController.currentSlide.script)
                .foregroundColor(.white)
                .multilineTextAlignment(.leading)
                .lineLimit(nil)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(minHeight: 100)
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
                guard let self else { return }
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
