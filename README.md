# OERadarView
[![Swift 2.2](https://img.shields.io/badge/Swift-2.2-orange.svg?style=flat)](https://developer.apple.com/swift/)
[![Twitter](https://img.shields.io/badge/Twitter-@orelm-blue.svg?style=flat)](http://twitter.com/OrElm)

Simple custom UIView subclass that adds a Radar view to your application. A radar view consisting of a big circle in the middle and a rotating radius line inside.

## Installation
### CocoaPods (Soon)

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

### Manually
Just drag OERadarView.swift file to your xcode project and you are good to go.

## Usage
Just add a UIView to your Storyboard/Xib and set its custom class to OERadarView. If you are using IB you will see the view rendered automatically.
Ofcourse, you can always add it in code with two lines of code:
```swift
let radarView = OERadarView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
self.view.addSubview(radarView)
````

## Properties
```swift
/// The circle's fill color
public var circleFillColor: UIColor
    
/// The circle's border (stroke) color
public var circleBorderColor: UIColor
    
/// The center point color
public var centerPointColor: UIColor
    
/// The radius line color
public var radiusLineColor: UIColor
```

##Author
OERadarView is owned and maintained by Or Elmaliah. You can follow me on Twitter [@OrElm](https://twitter.com/orelm).

## TO-DO
- [ ] Add some ripple animation to circle
- [ ] Add assets to the readme
- [ ] Support dependency managers


## MIT License

Copyright (c) 2016 Or Elmaliah

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.