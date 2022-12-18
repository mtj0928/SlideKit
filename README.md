# SlideKit

SlideKit helps you make presentation slides on SwiftUI.  
You can easily make presentation slides and customize the design perfectly because the all components are just SwiftUI's View.  

![Slides](https://user-images.githubusercontent.com/12427733/190956930-ea9ce4d0-0a19-4bb3-b43b-28dd2d73374a.png)


## Document
First, see the [Tutorial for SlideKit](https://mtj0928.github.io/SlideKit/tutorials/meet-slidekit).  
You can learn how to use SlideKit and make presentation slides through making the sample presentation slides.

If you want to know more details, refer the [DocC Style Document](https://mtj0928.github.io/SlideKit/documentation/slidekit/)

## Features
- [x] Support all SwiftUI Views🔥
- [x] Provide `HeaderSlide`, it is a template slide which has a title.
- [x] Support `HeaderSlideStyle`, so you can customize the design of the `HeaderSlide`.
- [x] Provide some utility view components
    - `Code`: Syntax Highlighted view (Only Swift is supported now.)
    - `Item`: Itemization view. `Item` supports nested structures.
- [x] Show the current slide index at bottom right on slide.
- [x] Support two windows, presentation window and presenter window.
- [x] Show scripts on only presenter window (only macOS)
- [x] Provide `PhasedState`, so you can divide a one slide step by step.
- [x] Export PDF file (only macOS 13+)

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
And then, this is the result of the code.  
<img width="1096" alt="IntroductionSlide" src="https://user-images.githubusercontent.com/12427733/190955403-ed64a5fd-eed0-4a4c-8684-75f39623a563.png">

## Presentations made with SlideKit
If you make presentations slide with SlideKit, add it to the following litst!!
- [After iOSDC](https://github.com/mtj0928/AfteriOSDC): A presentation which shares the hard points to make presentations slides by SwiftUI. (Japanese)
