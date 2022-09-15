//
//  EnvironmentValues+SlideIndexController.swift
//  
//
//  Created by Junnosuke Matsumoto on 2022/08/23.
//

import SwiftUI

private enum Key: EnvironmentKey {
    static let defaultValue: SlideIndexController? = nil
}

extension EnvironmentValues {
    public var slideIndexController: SlideIndexController? {
        get { self[Key.self] }
        set { self[Key.self] = newValue }
    }
}
