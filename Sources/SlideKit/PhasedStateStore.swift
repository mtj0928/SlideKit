//
//  PhasedStateStore.swift
//  
//
//  Created by Junnosuke Matsumoto on 2022/08/23.
//

import Foundation

protocol PhasedStateStoreProtocol {
    @discardableResult func forward() -> Bool
    @discardableResult func back() -> Bool
    func backToFirst()
    func forwardToLast()
}

public class PhasedStateStore<State: PhasedState>: ObservableObject, PhasedStateStoreProtocol {

    @Published public private(set) var current: State

    public init(_ state: State = .initial) {
        self.current = state
    }

    @discardableResult
    public func forward() -> Bool {
        guard let newState = current.forward() else {
            return false
        }
        current = newState
        return true
    }

    @discardableResult
    public func back() -> Bool {
        guard let newState = current.back() else {
            return false
        }
        current = newState
        return true
    }

    public func backToFirst() {
        current = State.initial
    }

    public func forwardToLast() {
        current = State.allCases.last!
    }
}
