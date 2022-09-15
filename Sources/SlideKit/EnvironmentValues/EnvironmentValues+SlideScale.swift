//
//  EnvironmentValues+SlideScale.swift
//  
//
//  Created by Junnosuke Matsumoto on 2022/08/24.
//

import SwiftUI

extension EnvironmentValues {
    public var slideScale: CGFloat {
        get {
            let slideSize = self.slideSize
            let screenSize = self.screenSize

            let widthScale = screenSize.width / slideSize.width
            let heightScale = screenSize.height / slideSize.height
            return min(widthScale, heightScale)
        }
    }
}
