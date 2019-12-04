# Spotlight

[![CI Status](https://img.shields.io/travis/boraseoksoon/Spotlight.svg?style=flat)](https://travis-ci.org/boraseoksoon/Spotlight)
[![Version](https://img.shields.io/cocoapods/v/Spotlight.svg?style=flat)](https://cocoapods.org/pods/Spotlight)
[![License](https://img.shields.io/cocoapods/l/Spotlight.svg?style=flat)](https://cocoapods.org/pods/Spotlight)
[![Platform](https://img.shields.io/cocoapods/p/Spotlight.svg?style=flat)](https://cocoapods.org/pods/Spotlight)

Spotlight Search in SwiftUI<br>

Screenshots
-----------

![Alt Text](https://media.giphy.com/media/jS7ZYuYXRtPk6lHp5F/giphy.gif)

![Spotlight Screenshot](https://firebasestorage.googleapis.com/v0/b/boraseoksoon-ff7d3.appspot.com/o/Spotlight%2Fs4.png?alt=media&token=111d96f0-317c-49f0-b115-fb1592ab6299)

Youtube video URL Link for how it works: <br>
[link0](https://youtu.be/QTB7GqZL-L8)

At a Glance
-----------

```swift

var body: some View {
    /// 😊 That's it.
    Spotlight(imagesToZoom: imagesToZoom,
                         powerOfZoomBounce: .regular,
                         numberOfColumns: 200,
                         numberOfRows: 10,
                         didLongPressItem: { selectedImage in
                            print("on long press : ", selectedImage)
                            /// Grab an image user end up choosing.
                            self.selectedImage = selectedImage
                            
                            /// Present!
                            self.showSelectedImageView.toggle()
                         },
                         didFinishDraggingOnItem: { selectedImage in
                            print("on drag finish : ", selectedImage)
    })
    .edgesIgnoringSafeArea(.all)
    .sheet(isPresented:self.$showSelectedImageView) {
        /// The example view showing a picked up image.
        ShowingSelectedImageView(selectedImage: self.selectedImage)
    }
}
```

## Features

- [x] Designed for SwiftUI, SwiftUI 100% is supported.
- [x] Complex grid ScrollView UI is provided out of box.
- [x] Tracking user touch area on the grid scrollview, Zooming items is done out of box.
- [x] Spotlight will return an image selected by a user, detected by the internal long press and pan gesture inside out of box. 
- [x] Grid UI can be styled for number of columns, rows, zoom effect and images you would like to input to show in the grid.

<br>

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.
It includes examples for UIKit as well as SwiftUI.

## Requirements

- iOS 13.0 or later
- Swift 5.0 or later
- Xcode 11.0 or later


Getting Started
--------------- 

* SwiftUI

```Swift
import SwiftUI

/// 🥳 # Step1: let's import!
import Spotlight

struct ContentView: View {
    var itemsToZoom: [UIImage] = {
        var images = [UIImage]()
        for i in 0...29 {
            images.append(UIImage(named: "yourImage\(i)") ?? UIImage())
        }
        return images
    }()
    
    var body: some View {
        /// 😊 # Step2. That's it. completed!
        Spotlight(itemsToZoom: itemsToZoom,
                             powerOfZoomBounce: .regular,
                             isBeingDraggingOnItem:{ selectedImage in
                                ///
                             },
                             didLongPressItem: { selectedImage in
                                /// Grab an image user end up choosing.
                             },
                             didFinishDraggingOnItem: { selectedImage in
                                /// Grab an image user end up choosing.
        })
        .edgesIgnoringSafeArea(.all)
    }
}
```

* UIKit
```Swift
///
/// To use Spotlight,
/// Please, Follow steps written in the comments with icon like 😀.
///

import SwiftUI
import UIKit

///
// 😚 #Step1: import Spotlight!
///
import Spotlight

class ViewController: UIViewController {
    
    ///
    // 😋 #Step2: declare Spotlight
    ///
    private lazy var zoomGridScrollViewController: SpotlightController = { [unowned self] in
        ///
        /// It can be used on both SwiftUI and UIKit.
        /// To see how it works on SwiftUI,
        /// please refer to comments in SwiftUI directory -> ContentView.swift
        ///
        return SpotlightController(itemsToZoom: self.itemsToZoom,
                                              powerOfZoomBounce: .regular,
                                              scrollEnableButtonTintColor: .black,
                                              scrollEnableButtonBackgroundColor: .white,
                                              isBeingDraggingOnItem:{ [unowned self] selectedImage in
                                                 ///
                                              },
                                              didLongPressItem: { [unowned self] selectedImage in
                                                /// Grab an image user end up choosing.
                                              },
                                              didFinishDraggingOnItem: { [unowned self] selectedImage in
                                                /// on drag finished
                                              })
    }()
    
    ///
    // prepare any item array to feed to SpotlightController.
    ///
    private var itemsToZoom: [Any] = {
        var images = [UIImage]()
        for i in 0...29 {
            images.append(UIImage(named: "s\(i)") ?? UIImage())
        }
        return images
    }()
    
    ///
    // 😁 #Step3: Present it!
    ///
    @IBAction func goToSpotlight(_ sender: Any) {
        ///
        // 😎 That's all. well done.
        ///
        self.present(zoomGridScrollViewController,
                     animated: true,
                     completion: nil)
    }
    
    ///
    // MARK: - ViewController LifeCycle Methods
    ///
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

```

## Installation

There are four ways to use Spotlight in your project:
- using CocoaPods
- using Swift Package Manager
- manual install (build frameworks or embed Xcode Project)

### Installation with CocoaPods

[CocoaPods](http://cocoapods.org/) is a dependency manager for Objective-C, which automates and simplifies the process of using 3rd-party libraries in your projects. See the [Get Started](http://cocoapods.org/#get_started) section for more details.

#### Podfile

First, 
```ruby
pod 'Spotlight'
```
then in your root project,
```ruby
pod install
```

### Installation with Swift Package Manager (Xcode 11+)

[Swift Package Manager](https://swift.org/package-manager/) (SwiftPM) is a tool for managing the distribution of Swift code as well as C-family dependency. From Xcode 11, SwiftPM got natively integrated with Xcode.

Spotlight support SwiftPM from version 5.1.0. To use SwiftPM, you should use Xcode 11 to open your project. Click `File` -> `Swift Packages` -> `Add Package Dependency`, enter [Spotlight repo's URL](https://github.com/boraseoksoon/Spotlight). Or you can login Xcode with your GitHub account and just type `Spotlight` to search.

After select the package, you can choose the dependency type (tagged version, branch or commit). Then Xcode will setup all the stuff for you.

If you're a framework author and use Spotlight as a dependency, update your `Package.swift` file:

```swift
let package = Package(
    dependencies: [
        .package(url: "https://github.com/boraseoksoon/Spotlight", from: "0.1.1")
    ],
    // ...
)
```

## Author

boraseoksoon@gmail.com

## License

Spotlight is available under the MIT license. See the LICENSE file for more info.


## References 

[PhotoCell](https://apps.apple.com/us/app/observable/id1488022000?ls=1) : 
Photos browsing iOS app where you can download the photos for free as you like.

<img align="left" width="240" height="428" src="https://firebasestorage.googleapis.com/v0/b/boraseoksoon-ff7d3.appspot.com/o/Spotlight%2Fo1.png?alt=media&token=f5003b58-f10f-4858-bb27-f4b0e06f6f70">
<img align="left" width="240" height="428" src="https://firebasestorage.googleapis.com/v0/b/boraseoksoon-ff7d3.appspot.com/o/Spotlight%2Fo2.png?alt=media&token=6374ba2c-0e58-478f-81a8-11eb5a5662e2">
<img align="left" width="240" height="428" src="https://firebasestorage.googleapis.com/v0/b/boraseoksoon-ff7d3.appspot.com/o/Spotlight%2Fo4.png?alt=media&token=11e22574-b854-45bf-a0a3-4b0c596db3f9">
