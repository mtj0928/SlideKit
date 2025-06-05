//
//  Slide.swift
//  
//
//  Created by Junnosuke Matsumoto on 2022/08/23.
//

import SwiftUI

/// A type that represents your presentation slide.
/// This represents one page of your presentation.
///
/// You can make your slide like this.
/// ```swift
/// struct SampleSlide: Slide {
///
///     enum Substep: Int, PhasedState {
///         case initial, second, third
///     }
///
///     @Phase var phasedStateStore: PhasedStateStore<Substep>
///
///     var body: some View {
///         HeaderSlide("Phased Slide") {
///             Item("1st step", accessory: 1)
///
///             if phasedStateStore.after(.second) {
///                 Item("2nd step", accessory: 2)
///             }
///             if phasedStateStore.after(.third) {
///                 Item("3rd step", accessory: 3)
///             }
///         }
///     }
/// }
/// ```
public protocol Slide: View {

    /// A type which shows sub-steps in your slide.
    /// The default type is ``SimplePhasedState``.
    associatedtype SlidePhasedState: PhasedState

    /// A script for the current slide. The script will be shown on presenter view (macOS only).
    /// The default value is an empty String.
    var script: String { get }

    /// A boolean value indicating whether the slide index at the right bottom is hidden or not.
    /// The default value is `false`
    var shouldHideIndex: Bool { get }

    /// Inject PhasedStateStore.
    /// This function should be called by SlideKit, please do not call the function.
    func phasesStateSore(_ phasedStateStore: PhasedStateStore<SlidePhasedState>)

    /// The transition animation when moving forward to this slide.
    /// Defines the animation effect used when transitioning to this slide.
    /// The default value is `.identity` (no animation).
    ///
    /// Example usage:
    /// ```swift
    /// var transition: AnyTransition { .slide.combined(with: .opacity) }
    /// ```
    var transition: AnyTransition { get }
}

extension Slide {
    public var script: String { "" }
    public var shouldHideIndex: Bool { false }
    public func phasesStateSore(_ phasedStateStore: PhasedStateStore<SlidePhasedState>) {}

    /// Default implementation of transition.
    /// Returns identity transition (no animation) when not overridden.
    public var transition: AnyTransition { .identity }
}
