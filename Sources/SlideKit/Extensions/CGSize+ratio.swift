//
//  CGSize+ratio.swift
//  
//
//  Created by Junnosuke Matsumoto on 2022/08/31.
//

import SwiftUI

extension CGSize {
    public var ratio: CGFloat {
        width / height
    }
}
