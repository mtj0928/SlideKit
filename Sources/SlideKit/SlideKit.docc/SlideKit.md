# ``SlideKit``

Make presentation slides by SwiftUI.

## Overview

SlideKit provides views, structures, and utilities for making presentation slides with SwiftUI.
You can create your presentation slides using a ``Slide`` protocol.


![Three example slides](SlideKit_Essentials.png)

You can make presentation slides like this.
```swift
@Slide
struct IntroductionSlide: View {
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
And this is the result of the example.
![A screen shot of the result above sample code](IntroductionSlide.png)

## Topics

### Essentials

- <doc:/tutorials/Meet-SlideKit>
- ``Slide``
- ``HeaderSlide``

### Slide View Components

- ``Item``
- ``Code``

### Slide Index

- ``SlideIndexController``
- ``PhasedState``

### Customize Slide Templates

- ``HeaderSlideStyle``
- ``ItemStyle`` 
- ``SlideTheme``

