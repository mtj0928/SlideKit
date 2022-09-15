//
//  EnvironmentValues+ObservableObjectContainer.swift
//  
//
//  Created by Junnosuke Matsumoto on 2022/08/23.
//

import SwiftUI

private enum Key: EnvironmentKey {
    static let defaultValue = ObservableObjectContainer()
}

extension EnvironmentValues {

    public var observableObjectContainer: ObservableObjectContainer {
        get { self[Key.self] }
        set { self[Key.self] = newValue }
    }
}
