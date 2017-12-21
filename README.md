# RappleColorPicker

[![Version](https://img.shields.io/cocoapods/v/RappleColorPicker.svg?style=flat)](http://cocoapods.org/pods/RappleColorPicker)
[![License](https://img.shields.io/cocoapods/l/RappleColorPicker.svg?style=flat)](http://cocoapods.org/pods/RappleColorPicker)
[![Platform](https://img.shields.io/cocoapods/p/RappleColorPicker.svg?style=flat)](http://cocoapods.org/pods/RappleColorPicker)

## Requirements
- Xcode 9
- Swift 4
- iOS 9+


### Demo
![demo](Example/Demo/picker.gif)

## Example App

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

RappleColorPicker is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'RappleColorPicker'
```

### Please use version 2.0.3 for Swift 3 builds

First import color picker into your Swift class

```ruby
import RappleColorPicker
```

### Required parameters

- `onViewController` : ViewController to open color picker (Optional) : Default nil (will be open on top of all teh views)
- `title` : Text Title (Optinal) : Default nil (title will be hidden)
- `origin` : Origin of the color picker (Optional) Default nil (center on the `onViewController`  or top most ViewController)
- `cellSize` : Individual cell size (enum RappleCPCellSize) (Optional) Default `RappleCPCellSize.medium` (35 x 35)
- `attributes` : Custom look and feel values (Title, BGColor, TintColor, Style, BorderColor) (Optional)
- `tag` : Identification tag (Optional)


`attribute` dictionary can have all or some of the following key values located in `RappleCPAttributeKey` enum.
```ruby
enum RappleCPAttributeKey {
    case Title          `Title text - attributes without Title will hide title bar from UI`
    case BGColor        `Background color`
    case Style          `Cell style (Square, Circle)`
    case TintColor      `TintColor Tint Color (Text color, cell border color)`
    case BorderColor    `Color pallet border Color (Complete pallet border)`
    case ScreenBGColor  `Background color for entire screen below the color picker`
}
```
`Style` key must have one of the these styles
- `RappleCPStyleSquare` // Squre shaped color picker cells
- `RappleCPStyleCircle` // Circular shaped color picker cells

Color picker total size will be calculated dynamically based of `cellSize` parameter.

### open color picker
```ruby
RappleColorPicker.openColorPallet(onViewController: self, title: "Color Picker",
                                            origin: point, cellSize: .medium,
                                        attributes: attributes, tag: tag) { (color, tag) in
    // your code here
    RappleColorPicker.close()
}
```
- All the parameter of above method defined with default values to create the default look and feel. So you can just simply call;
```ruby
RappleColorPicker.openColorPallet(tag: tag) { (color, tag) in
    // your code here
    RappleColorPicker.close()
}
```
or

```ruby
RappleColorPicker.openColorPallet() { (color, _) in
    // your code here
    RappleColorPicker.close()
}
```

### close color picker
```ruby
RappleColorPicker.close()
```

## Example Project

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Author

Rajeev Prasad, rjeprasad@gmail.com

## License

Copyright (c) 2018 Rajeev Prasad <rjeprasad@gmail.com>

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

