# imagePreview-Swift
[![ghit.me](https://ghit.me/badge.svg?repo=caydyn-skd/imagePreview-Swift)](https://ghit.me/repo/caydyn-skd/imagePreview-Swift)
[![Language](http://img.shields.io/badge/language-swift-orange.svg?style=flat)](https://developer.apple.com/swift)
[![Platform](https://img.shields.io/badge/platform-ios-lightgrey.svg?style=flat)](https://developer.apple.com/resources/)
[![Issues](https://img.shields.io/github/issues/caydyn-skd/imagePreview-Swift.svg?style=flat)](https://github.com/caydyn-skd/imagePreview-Swift/issues)

图片放大预览<br>
[the image preview library]<br><br>
功能: 单击图片关闭，两指捏合可缩放<br>
[Features: Click on the picture to close, two fingers kneading Scalable]

##编译环境[Compiler Environment]
- iOS 8.0+
- Xcode 7.0 beta 5+

##使用说明
初始化 (可自定义起始位置)<br>
[Initialization Operating (Customizable starting position)]<br>
```swift
let ImageViewer: imagePreview = imagePreview(imageURLs: allImageURLs,
  index: selectedImageIndex)
```
显示<br>
[Show Operating]<br>
```swift
ImageViewer.show()
```
<br><br>
更多信息请看Demo<br>
[For more information, see Demo]<br>
