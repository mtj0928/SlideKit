//
//  Slide.swift
//  
//
//  Created by Junnosuke Matsumoto on 2022/08/23.
//

import SwiftUI

public protocol Slide: View {

    associatedtype SlidePhasedState: PhasedState
    typealias Phase = PhaseWrapper<SlidePhasedState>

    var phasedStateStore: PhasedStateStore<SlidePhasedState> { get }
}

extension Slide where SlidePhasedState == SimplePhasedState {

    public var phasedStateStore: PhasedStateStore<SimplePhasedState> {
        PhasedStateStore()
    }
}
