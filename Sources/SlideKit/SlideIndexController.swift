//
//  SlideIndexController.swift
//  
//
//  Created by Junnosuke Matsumoto on 2022/08/23.
//

import Foundation

public class SlideIndexController: ObservableObject {

    @Published
    public private(set) var currentIndex: Int

    @Published
    public private(set) var currentScript = ""

    public let slides: [any Slide]

    public var currentSlide: any Slide {
        slides[currentIndex]
    }

    public init(index: Int = 0, @SlideBuilder slideBuilder: () -> [any Slide]) {
        self.slides = slideBuilder()

        guard index < slides.count else {
            fatalError("index must be less than the number of slides.")
        }

        self.currentIndex = index
    }

    @discardableResult
    public func forward() -> Bool {
        defer { currentScript = currentSlide.script }
        let phasedStateStore = getPhasedStateStore(at: currentIndex)
        if phasedStateStore.forward() {
            return true
        }

        guard currentIndex + 1 < slides.count else {
            return false
        }
        currentIndex += 1
        let newPhasedStateStore = getPhasedStateStore(at: currentIndex)
        newPhasedStateStore.backToFirst()
        return true
    }

    @discardableResult
    public func back() -> Bool {
        defer { currentScript = currentSlide.script }
        let phasedStateStore = getPhasedStateStore(at: currentIndex)
        if phasedStateStore.back() {
            return true
        }

        guard 0 < currentIndex else {
            return false
        }
        currentIndex -= 1
        let newPhasedStateStore = getPhasedStateStore(at: currentIndex)
        newPhasedStateStore.forwardToLast()
        return true
    }

    public func backToFirst() {
        currentIndex = 0
        let phasedStateStore = getPhasedStateStore(at: currentIndex)
        phasedStateStore.backToFirst()
        currentScript = currentSlide.script
    }

    private func getPhasedStateStore(at index: Int) -> any PhasedStateStoreProtocol {
        let slide = slides[index]
        return slide.typeErasedPhasedStateStore
    }

    public func move(to index: Int) {
        currentIndex = index
        let newPhasedStateStore = getPhasedStateStore(at: currentIndex)
        newPhasedStateStore.backToFirst()
    }
}

extension Slide {
    fileprivate var typeErasedPhasedStateStore: any PhasedStateStoreProtocol {
        phasedStateStore
    }
}
