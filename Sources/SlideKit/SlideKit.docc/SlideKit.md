# ``SlideKit``

Make presentation slides by SwiftUI.

## Overview

SlideKit provides views, structures, and utilities for making presentations slide with SwiftUI.
You can create your presentation slide using a ``Slide`` protocol and index them using ``SlideIndexController``.

You can make presentation slides like this.
```swift
struct IntroductionSlide: Slide {
    var body: some View {
        HeaderSlide("SlideKit") {
            Item("SlideKit helps you make presentation slides by SwiftUI")
            Item("The followings are provided") {
                Item("Views")
                Item("Structures")
                Item("Utilities")
            }
        }
    }
}
```
And this it the result of the example.
![A screen shot of the result above sample code](IntroductionSlide.png)

## Topics
### Essentials
- <doc:/tutorials/Meet-SlideKit>

### Group



