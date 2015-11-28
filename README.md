# RappleColorPicker

[![CI Status](http://img.shields.io/travis/Rajeev Prasad/RappleColorPicker.svg?style=flat)](https://travis-ci.org/Rajeev Prasad/RappleColorPicker)
[![Version](https://img.shields.io/cocoapods/v/RappleColorPicker.svg?style=flat)](http://cocoapods.org/pods/RappleColorPicker)
[![License](https://img.shields.io/cocoapods/l/RappleColorPicker.svg?style=flat)](http://cocoapods.org/pods/RappleColorPicker)
[![Platform](https://img.shields.io/cocoapods/p/RappleColorPicker.svg?style=flat)](http://cocoapods.org/pods/RappleColorPicker)

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

RappleColorPicker is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "RappleColorPicker"
```

##Usage
import progress library

```ruby
import RappleColorPicker
```

</BR>
To open color picker
</BR>Color picker size - CGSize(218, 352)
</BR>@param     onViewController progress UI attributes
</BR>@param     origin origin point of the color pallet
</BR>@param     delegate RappleColorPickerDelegate
</BR>@param     title color pallet name default "Color Picker"
*/
```ruby
RappleColorPicker.openColorPallet(onViewController: self, origin: CGPointMake(10, 100), delegate: self, title: "Colors")
```

</BR>
To receive selected color implement 'RappleColorPickerDelegate' delegate
```ruby
func colorSelected(color: UIColor) {

}
```

</BR>
To close color picker
```ruby
RappleColorPicker.close()
```

###Demo
![demo](Example/Demo/Picker.gif)

## Example Project

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Author

Rajeev Prasad, rjeprasad@gmail.com

## License

Copyright (c) 2015 Rajeev Prasad <rjeprasad@gmail.com>

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