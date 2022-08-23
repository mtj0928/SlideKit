//
//  PhasedState.swift
//  
//
//  Created by Junnosuke Matsumoto on 2022/08/23.
//

public protocol PhasedState {
    static var initial: Self { get }

    func back() -> Self?
    func forward() -> Self?
}

extension PhasedState where Self: RawRepresentable, Self.RawValue == Int {

    public func back() -> Self? {
        Self(rawValue: rawValue - 1)
    }

    public func forward() -> Self? {
        Self(rawValue: rawValue + 1)
    }
}
