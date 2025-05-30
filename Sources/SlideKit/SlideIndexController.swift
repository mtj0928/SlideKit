import Foundation
import SwiftUI

/// A controller managing the current slide index.
@MainActor
public final class SlideIndexController: ObservableObject {

    @Published
    public private(set) var currentIndex: Int

    /// The last index of the slide before the current index was changed.
    /// This is useful for determining the previous slide index.
    /// It is `nil` when the current index is changed for the first time.
    internal var lastIndex: Int?

    /// Updates the current index and stores the previous index.
    /// - Parameter currentIndex: The new index to set as the current index.
    private func updateCurrentIndex(_ currentIndex: Int) {
        lastIndex = self.currentIndex
        self.currentIndex = currentIndex
    }

    @Published
    public private(set) var currentScript = ""

    public let slides: [any Slide]

    private let objectContainer: ObservableObjectContainer

    public var currentSlide: any Slide {
        slides[currentIndex]
    }

    /// A closure that defines the transition to be applied when the slide changes.
    public typealias SlideTransition = (_ from: Int?, _ to: Int) -> AnyTransition

    /// The transition to be applied when the slide changes.
    /// Defaults to `.identity`, meaning no transition.
    public var transition: SlideTransition = { from, to in
        return .identity
    }

    public init(
        index: Int = 0,
        container: ObservableObjectContainer = ObservableObjectContainerKey.defaultValue,
        transition: @escaping SlideTransition = { _, _ in .identity },
        @SlideBuilder slideBuilder: () -> [any Slide]
    ) {
        self.slides = slideBuilder()
        self.objectContainer = container
        self.transition = transition

        guard index < slides.count else {
            fatalError("index must be less than the number of slides.")
        }

        self.currentIndex = index
    }

    @discardableResult
    public func forward() -> Bool {
        withAnimation {
            defer { currentScript = currentSlide.script(on: objectContainer) }
            let phasedStateStore = getPhasedStateStore(at: currentIndex)
            if phasedStateStore.forward() {
                return true
            }

            guard currentIndex + 1 < slides.count else {
                return false
            }
            updateCurrentIndex(currentIndex + 1)
            let newPhasedStateStore = getPhasedStateStore(at: currentIndex)
            newPhasedStateStore.backToFirst()
            return true
        }
    }

    @discardableResult
    public func back() -> Bool {
        withAnimation {
            defer { currentScript = currentSlide.script(on: objectContainer) }
            let phasedStateStore = getPhasedStateStore(at: currentIndex)
            if phasedStateStore.back() {
                return true
            }

            guard 0 < currentIndex else {
                return false
            }
            updateCurrentIndex(currentIndex - 1)
            let newPhasedStateStore = getPhasedStateStore(at: currentIndex)
            newPhasedStateStore.forwardToLast()
            return true
        }
    }

    public func backToFirst() {
        withAnimation {
            updateCurrentIndex(0)
            let phasedStateStore = getPhasedStateStore(at: currentIndex)
            phasedStateStore.backToFirst()
            currentScript = currentSlide.script(on: objectContainer)
        }
    }

    private func getPhasedStateStore(at index: Int) -> any PhasedStateStoreProtocol {
        let slide = slides[index]
        return slide.typeErasedPhasedStateStore(on: objectContainer)
    }

    public func move(to index: Int) {
        withAnimation {
            updateCurrentIndex(index)
            let newPhasedStateStore = getPhasedStateStore(at: currentIndex)
            newPhasedStateStore.backToFirst()
            currentScript = currentSlide.script(on: objectContainer)
        }
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
