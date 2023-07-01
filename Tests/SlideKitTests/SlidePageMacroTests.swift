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
                public var _phaseStore: PhasedStateStore<State> {
                    $state
                }
                public typealias SlidePhasedState = State
                func phase(_ phase: State) -> Self {
                    $state.current = phase
                    return self
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
                @Phase private var _phase: SimplePhasedState
                public var _phaseStore: PhasedStateStore<SimplePhasedState> {
                    $_phase
                }
                public typealias SlidePhasedState = SimplePhasedState
            }
            extension FooSlide: Slide {
            }
            """,
            macros: testMacros
        )
    }
}
