//
//  PhasedState.swift
//  
//
//  Created by Junnosuke Matsumoto on 2022/08/23.
//

public protocol PhasedState: RawRepresentable, CaseIterable where Self.RawValue == Int, Self.AllCases == [Self] {
    static var initial: Self { get }
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

    public func when(_ state: Self) -> Bool {
        self.rawValue == state.rawValue
    }
}
