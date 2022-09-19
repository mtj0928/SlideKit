# SlideKit

SlideKit helps you make presentation slides on SwiftUI.

![Slides](https://user-images.githubusercontent.com/12427733/190956930-ea9ce4d0-0a19-4bb3-b43b-28dd2d73374a.png)

## Simple Example
You can create a presentation by SwiftUI like this.
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
<img width="1096" alt="IntroductionSlide" src="https://user-images.githubusercontent.com/12427733/190955403-ed64a5fd-eed0-4a4c-8684-75f39623a563.png">

## Target
**Language:** Swift5.7+   
**OS:** iOS15+ / iPadOS15+ / macOS12+

## Features
- [x] Provide `HeaderSlide`, it is a template slide which has a title.
- [x] Support `HeaderSlideStyle`, so you can customize the design.
- [x] Show slide index at bottom right on slide.
