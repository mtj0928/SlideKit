import XCTest
import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
@testable import SlideKit
import SlideKitMacros

let testMacros: [String: Macro.Type] = [
    "Slide": SlideMacro.self
]

final class SlideMacroTests: XCTestCase {
    func testSlideWithPhase() {
        assertMacroExpansion(
            """
            @Slide
            struct FooSlide: View {
                @Phase var state: State
            }
            """,
            expandedSource:
            """
            struct FooSlide: View {
                @Phase var state: State

                public typealias SlidePhasedState = State

                public typealias Phase = PhaseWrapper

                @Environment(\\.observableObjectContainer) private var container

                func phase(_ phase: State) -> Self {
                    let store: PhasedStateStore<State> = container.resolve {
                        PhasedStateStore(phase)
                    }
                    store.current = phase
                    return self
                }

                func phasesStateSore(_ phasedStateStore: PhasedStateStore<SlidePhasedState>) {
                    $state = phasedStateStore
                }
            }

            extension FooSlide: Slide {
            }
            """,
            macros: testMacros
        )
    }

    func testSlideWithoutPhase() {
        assertMacroExpansion(
            """
            @Slide
            struct FooSlide: View {
            }
            """,
            expandedSource:
            """
            struct FooSlide: View {

                public typealias SlidePhasedState = SimplePhasedState
            }

            extension FooSlide: Slide {
            }
            """,
            macros: testMacros
        )
    }
}
