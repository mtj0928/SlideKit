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
        if let newState = curreent.forward() {
            curreent = newState
            return true
        }
        else {
            return false
        }
    }

    @discardableResult
    func back() -> Bool {
        if let newState = curreent.back() {
            curreent = newState
            return true
        }
        else {
            return false
        }
    }
}
