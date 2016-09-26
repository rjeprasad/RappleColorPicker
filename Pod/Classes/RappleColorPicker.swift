/* **
 RappleColorPicker.swift
 Custom Activity Indicator with swift 2.0
 
 Created by Rajeev Prasad on 28/11/15.
 
 The MIT License (MIT)
 
 Copyright (c) 2016 Rajeev Prasad <rjeprasad@gmail.com>
 
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
 ** */

import UIKit

/**
 RappleColorPickerDelegate public delegate
 - Note: Only implement one mehod
 - Remark: If both methods are implemented `colorSelected(_:, tag:)` will be used as the delegate method and `colorSelected(_:)` will not be called
 */
@objc
public protocol RappleColorPickerDelegate: NSObjectProtocol {
    /** Retrieve selected color from color picker */
    @objc optional func colorSelected(_ color:UIColor)
    /** Retrieve selected color from color picker with indentification tag */
    @objc optional func colorSelected(_ color:UIColor, tag: Int)
}

/** RappleColorPicker attribute keys */
public enum RappleCPAttributeKey : String {
    /** Title text - attributes without Title will hide/remove title bar from UI */
    case Title = "Title"
    /** Background color */
    case BGColor = "BGColor"
    /** Cell style (Square, Circle) */
    case Style = "Style"
    /** TintColor Tint Color (Text color, cell border color) */
    case TintColor = "TintColor"
    /** Color pallet border Color (Complete pallet border) */
    case BorderColor = "BorderColor"
}

/** Squre shaped color picker cells */
public let RappleCPStyleSquare = "Square"
/** Circular shaped color picker cells */
public let RappleCPStyleCircle = "Circle"

/** RappleColorPicker - Easy to use color pricker for iOS apps
 - Remark: Use one of the `openColorPallet(.....)` to open the color pallate
 - Remark: And use `close()` method to close color pallate
 - Note: default picker size - 230x358 (without title) or 230x384 (with title)
 */
open class RappleColorPicker: NSObject {
    
    fileprivate var colorVC : RappleColorPickerViewController?
    fileprivate var background : UIView?
    fileprivate var closeButton : UIButton?
    
    fileprivate static let sharedInstance = RappleColorPicker()
    
    /**
     Open color picker with default look & feel
     - Note: default picker size - 230x358 (without title) or 230x384 (with title)
     - parameter onViewController: opening viewController
     - parameter origin: origin point of the color pallet
     - parameter delegate: RappleColorPickerDelegate
     - parameter title: color pallet name default "Color Picker", send nil for hide title bar
     */
    open class func openColorPallet(onViewController vc: UIViewController, origin: CGPoint, delegate:RappleColorPickerDelegate, title:String?) {
        RappleColorPicker.openColorPallet(onViewController: vc, origin: origin, delegate: delegate, title: title, tag: 0)
    }
    
    /**
     Open color picker with a tag and default look & feel
     - Note: default picker size - 230x358 (without title) or 230x384 (with title)
     - parameter onViewController: opening viewController
     - parameter origin: origin point of the color pallet
     - parameter delegate: RappleColorPickerDelegate
     - parameter title: color pallet name default "Color Picker", send nil for hide title bar
     - parameter tag: identification tag
     */
    open class func openColorPallet(onViewController vc: UIViewController, origin: CGPoint, delegate:RappleColorPickerDelegate, title:String?, tag: Int) {
        var attributes : [RappleCPAttributeKey : AnyObject]?
        if title != nil {
            attributes = [.Title : title! as AnyObject]
        }
        
        RappleColorPicker.openColorPallet(onViewController: vc, origin: origin, delegate: delegate, attributes: attributes, tag: tag)
    }
    
    /**
     Open color picker with custom look & feel (optional).
     - Note: default picker size - 230x358 (without title) or 230x384 (with title)
     - parameter onViewController: opening viewController
     - parameter origin: origin point of the color pallet
     - parameter delegate: RappleColorPickerDelegate
     - parameter attributes: look and feel attribute (Title, BGColor, TintColor, Style, BorderColor)
     */
    open class func openColorPallet(onViewController vc: UIViewController, origin: CGPoint, delegate:RappleColorPickerDelegate, attributes:[RappleCPAttributeKey:AnyObject]?) {
        RappleColorPicker.openColorPallet(onViewController: vc, origin: origin, delegate: delegate, attributes: attributes, tag: 0)
    }
    
    /**
     Open color picker with with a tag and custom look & feel (optional)
     - Note: default picker size - 230x358 (without title) or 230x384 (with title)
     - parameter onViewController: opening viewController
     - parameter origin: origin point of the color pallet
     - parameter delegate: RappleColorPickerDelegate
     - parameter attributes: look and feel attribute (Title, BGColor, TintColor, Style, BorderColor)
     - parameter tag: identification tag
     */
    open class func openColorPallet(onViewController vc: UIViewController, origin: CGPoint, delegate:RappleColorPickerDelegate, attributes:[RappleCPAttributeKey:AnyObject]?, tag: Int) {
        
        let this = RappleColorPicker.sharedInstance
        
        let title = attributes?[.Title] as? String
        let bgColor = attributes?[.BGColor] as? UIColor ?? UIColor.darkGray
        let tintColor = attributes?[.TintColor] as? UIColor ?? UIColor.white
        let style = attributes?[.Style] as? String ?? RappleCPStyleCircle
        let border = attributes?[.BorderColor] as? UIColor ?? UIColor.darkGray
        
        var attrib = [RappleCPAttributeKey:AnyObject]()
        var height: CGFloat = 358
        if let title = title {
            height += 26
            attrib[.Title] = title as AnyObject
        }
        attrib[.BGColor] = bgColor
        attrib[.TintColor] = tintColor
        attrib[.Style] = style as AnyObject
        attrib[.BorderColor] = border
        
        this.background = UIView(frame: vc.view.bounds)
        this.background?.backgroundColor = UIColor.clear
        vc.view.addSubview(this.background!)
        
        this.closeButton = UIButton(frame: this.background!.bounds)
        this.closeButton?.addTarget(this, action: #selector(RappleColorPicker.closeTapped), for: .touchUpInside)
        this.background?.addSubview(this.closeButton!)
        
        var point = CGPoint(x: origin.x, y: origin.y)
        if origin.x < 0 { point.x = 0 }
        if origin.y < 0 { point.y = 0 }
        if origin.x + 230 > vc.view.bounds.width { point.x = vc.view.bounds.width - 230 }
        if origin.y + height > vc.view.bounds.height { point.y = vc.view.bounds.height - height }
        
        let colVCSize = CGSize(width: 230, height: height)
        
        this.colorVC = RappleColorPickerViewController()
        this.colorVC?.delegate = delegate
        this.colorVC?.attributes = attrib
        this.colorVC?.tag = tag
        this.colorVC?.size = colVCSize
        this.colorVC!.view.frame = CGRect(origin: point, size: colVCSize)
        this.background!.addSubview(this.colorVC!.view)
        
    }
    
    /** Close color picker Class func */
    open class func close(){
        let this = RappleColorPicker.sharedInstance
        this.closeTapped()
    }
    
    /** Close color picker */
    internal func closeTapped(){
        self.background?.removeFromSuperview()
        self.colorVC = nil
        self.closeButton = nil
        self.background = nil
    }
}
