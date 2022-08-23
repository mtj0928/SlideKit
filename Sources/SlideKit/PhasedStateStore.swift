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

    public func backToFirst() {
        curreent = State.initial
    }

    public func forwardToLast() {
        curreent = State.allCases.last!
    }
}
