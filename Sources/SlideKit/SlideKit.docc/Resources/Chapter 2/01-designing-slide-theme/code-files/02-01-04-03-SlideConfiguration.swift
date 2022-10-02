//
//  SlideConfiguration.swift
//
//  This file is automatically generates by SlideGen
//

import SwiftUI
import SlideKit

struct SlideConfiguration {

    /// Edit the slide size.
    let size = SlideSize.standard16_9

    ///  Add your slides into the trailing closure.
    let slideIndexController = SlideIndexController {
        TitleSlide()
        IntroductionSlide()
        PhasedSlide()
        CodeSlide()
    }

    let theme = CustomTheme()
}

struct CustomTheme: SlideTheme {
    let headerSlideStyle = CustomHeaderSlideStyle()
    let itemStyle = CustomItemStyle()
    let indexStyle = CustomIndexStyle()
}
