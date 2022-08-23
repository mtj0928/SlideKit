//
//  EnvironmentValues+ScreenSize.swift
//  
//
//  Created by Junnosuke Matsumoto on 2022/08/24.
//

import SwiftUI

private enum Key: EnvironmentKey {
    static let defaultValue: CGSize = .zero
}

extension EnvironmentValues {
    public var screenSize: CGSize {
        get { self[Key.self] }
        set { self[Key.self] = newValue }
    }
}
