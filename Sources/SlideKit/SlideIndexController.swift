import Foundation
import SwiftUI

/// A controller managing the current slide index.
@MainActor
public final class SlideIndexController: ObservableObject {

    @Published
    public private(set) var currentIndex: Int

    @Published
    public private(set) var currentScript = ""

    public let slides: [any Slide]

    private let objectContainer: ObservableObjectContainer

    public var currentSlide: any Slide {
        slides[currentIndex]
    }

    public init(
        index: Int = 0,
        container: ObservableObjectContainer = ObservableObjectContainerKey.defaultValue,
        @SlideBuilder slideBuilder: () -> [any Slide]
    ) {
        self.slides = slideBuilder()
        self.objectContainer = container

        guard index < slides.count else {
            fatalError("index must be less than the number of slides.")
        }
        defer { currentScript = currentSlide.script(on: objectContainer) }
        self.currentIndex = index
    }

    public init(
        index: Int = 0,
        container: ObservableObjectContainer = ObservableObjectContainerKey.defaultValue,
        slides: [any Slide]
    ) {
        self.slides = slides
        self.objectContainer = container

        guard index < slides.count else {
            fatalError("index must be less than the number of slides.")
        }
        defer { currentScript = currentSlide.script(on: objectContainer) }
        self.currentIndex = index
    }

    @discardableResult
    public func forward() -> Bool {
        defer { currentScript = currentSlide.script(on: objectContainer) }
        let phasedStateStore = getPhasedStateStore(at: currentIndex)
        if phasedStateStore.forward() {
            return true
        }

        guard currentIndex + 1 < slides.count else {
            return false
        }
        withAnimation {
            currentIndex += 1
        }
        let newPhasedStateStore = getPhasedStateStore(at: currentIndex)
        newPhasedStateStore.backToFirst()
        return true
    }

    @discardableResult
    public func back() -> Bool {
        defer { currentScript = currentSlide.script(on: objectContainer) }
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
        currentScript = currentSlide.script(on: objectContainer)
    }

    private func getPhasedStateStore(at index: Int) -> any PhasedStateStoreProtocol {
        let slide = slides[index]
        return slide.typeErasedPhasedStateStore(on: objectContainer)
    }

    public func move(to index: Int) {
        currentIndex = index
        let newPhasedStateStore = getPhasedStateStore(at: currentIndex)
        newPhasedStateStore.backToFirst()
        currentScript = currentSlide.script(on: objectContainer)
    }

    public func phaseStateStore<State: PhasedState>() -> PhasedStateStore<State> {
        objectContainer.resolve {
            PhasedStateStore()
        }
    }
}

extension Slide {
    fileprivate func typeErasedPhasedStateStore(on container: ObservableObjectContainer) -> any PhasedStateStoreProtocol {
        container.resolve {
            PhasedStateStore<SlidePhasedState>()
        }
    }

    fileprivate func script(on container: ObservableObjectContainer) -> String {
        let object = self
        let store = container.resolve {
            PhasedStateStore<SlidePhasedState>()
        }
        object.phasesStateSore(store)
        return object.script
    }
}
