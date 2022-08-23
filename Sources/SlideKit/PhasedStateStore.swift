//
//  PhasedStateStore.swift
//  
//
//  Created by Junnosuke Matsumoto on 2022/08/23.
//

import Foundation

public class PhasedStateStore<State: PhasedState>: ObservableObject {

    @Published public private(set) var curreent: State

    public init(_ state: State = .initial) {
        self.curreent = state
    }

    @discardableResult
    public func forward() -> Bool {
        guard let newState = curreent.forward() else {
            return false
        }
        curreent = newState
        return true
    }

    @discardableResult
    public func back() -> Bool {
        guard let newState = curreent.back() else {
            return false
        }
        curreent = newState
        return true
    }
}
