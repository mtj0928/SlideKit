//
//  PhasedState.swift
//  
//
//  Created by Junnosuke Matsumoto on 2022/08/23.
//

public protocol PhasedState: RawRepresentable, CaseIterable, Equatable where Self.RawValue == Int, Self.AllCases == [Self] {

    static var initial: Self { get }

    func back() -> Self?
    func forward() -> Self?
}

extension PhasedState {

    public var isLast: Bool {
        rawValue == Self.allCases.last?.rawValue
    }

    public func back() -> Self? {
        Self(rawValue: rawValue - 1)
    }

    public func forward() -> Self? {
        Self(rawValue: rawValue + 1)
    }

    public func isAfter(_ state: Self) -> Bool {
        rawValue >= state.rawValue
    }
}

public enum SimplePhasedState: Int, PhasedState {
    case initial
}
