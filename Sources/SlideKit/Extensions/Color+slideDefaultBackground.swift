import SwiftUI

extension Color {
    /// A default background color of a slide.
    /// In visionOS, the color is `clear` to enable glass effects for the background.
    /// In other platforms, the color is `black`.
    public static var slideDefaultBackground: Color {
#if os(visionOS)
        Color.clear
#else
        Color.black
#endif
    }
}
