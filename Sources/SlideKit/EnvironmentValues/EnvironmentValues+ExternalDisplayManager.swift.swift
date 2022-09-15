//
//  EnvironmentValues+ExternalDisplayManager.swift
//  
//
//  Created by Junnosuke Matsumoto on 2022/08/24.
//

#if os(iOS)
import SwiftUI

private enum Key: EnvironmentKey {
    static let defaultValue: ExternalDisplayManager? = nil
}

@available(iOS 15.0, *)
extension EnvironmentValues {
    public var externalDisplayManager: ExternalDisplayManager? {
        get { self[Key.self] }
        set { self[Key.self] = newValue }
    }
}
#endif
