//
//  EnvironmentValues+ObservableObjectContainer.swift
//  
//
//  Created by Junnosuke Matsumoto on 2022/08/23.
//

import SwiftUI

private enum ObservableObjectContainerKey: EnvironmentKey {
    static let defaultValue = ObservableObjectContainer()
}

extension EnvironmentValues {
    public var observableObjectContainer: ObservableObjectContainer {
        get { self[ObservableObjectContainerKey.self] }
        set { self[ObservableObjectContainerKey.self] = newValue }
    }
}
