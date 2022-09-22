//
//  SlideConfiguration.swift
//
//  Created by Junnosuke Matsumoto on 2022/08/26.
//

import SwiftUI
import SlideKit

struct SlideConfiguration {

    /// Edit the slide size.
    let size = SlideSize.standard16_9

    ///  Add your slides into the trailing closure.
    let slideIndexController = SlideIndexController {
        BasicSlide()
        CustomHeaderStyleSlide()
    }
}
