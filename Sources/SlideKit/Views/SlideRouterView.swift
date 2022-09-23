//
//  RootSlide.swift
//  
//
//  Created by Junnosuke Matsumoto on 2022/08/24.
//

import SwiftUI

public struct SlideRouterView: View {
    @ObservedObject
    private var slideIndexController: SlideIndexController

    public init(slideIndexController: SlideIndexController) {
        self.slideIndexController = slideIndexController
    }

    public var body: some View {
        ZStack {
            AnyView(slideIndexController.currentSlide)

            if !slideIndexController.currentSlide.shouldHideIndex {
                Text("\(slideIndexController.currentIndex)")
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                    .font(.system(size: 30))
                    .padding()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .slideTransition(
            back: { slideIndexController.back() },
            forward: { slideIndexController.forward() }
        )
        .environment(\.slideIndexController, slideIndexController)
        .foregroundColor(.black)
    }
}

struct SlideRouterView_Previews: PreviewProvider {

    static var previews: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            SlideRouterView(slideIndexController: .previews)
        }
    }
}
