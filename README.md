# SlideKit

SlideKit helps you make presentation slides on SwiftUI.

## Set Up Project
1. Please make a Xcode project by Mint.  
(SlideGen is a command line tool which generates a template project for SlideKit.)
```
$ mint run mtj0928/SlideGen SamplePresentations -p macOS
```

2. Open the generated Xcode project.
```
$ open SamplePresentations/SamplePresentations.xcodeproj
```

3. Build and run the project.  
If an error like `Couldn’t get revision ‘0.0.10^{commit}’:` occurs, do `File > Packages > Reset Package Caches` on Xcode.


## Usage
### Add Simple Slide
1. Add a new file like this.
```swift
import SlideKit
import SwiftUI

struct SimpleSlide: Slide {
    var body: some View {
        HeaderSlide("This is Simple Slide") {
            Item("You can use Item!!")
            Item("Nested item is supported.") {
                Item("Enumerated item is also supported.", accessory: 1)
                Item("2nd Item.", accessory: 2)
            }
        }
    }
}
```

2. Preview your slide with `SlidePreview`.
```swift
struct SimpleSlide_Previews: PreviewProvider {
    static var previews: some View {
        SlidePreview {
            SimpleSlide()
        }
    }
}
```
<img width="616" alt="SimpleSlidePreview" src="https://user-images.githubusercontent.com/12427733/189527211-eafae837-d5a6-4ee7-b277-645d2b982e25.png">


3. Finally, add the slide to `SlideIndexController` in `SamplePresentations.swift`. Run the project and you can see SimpleSlide!!
```diff
    /// Please add your slide into the trailing closure
    let slideIndexController = SlideIndexController {
        SampleSlide()
+       SimpleSlide()        
    }
```
