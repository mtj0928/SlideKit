//
//  EnvironmentValues+SlideSize.swift.swift
//  
//
//  Created by Junnosuke Matsumoto on 2022/08/24.
//

import SwiftUI

private enum Key: EnvironmentKey {
    static let defaultValue = CGSize(width: 1920, height: 1080)
}

extension EnvironmentValues {
    public var slideSize: CGSize {
        get { self[Key.self] }
        set { self[Key.self] = newValue }
    }
}
