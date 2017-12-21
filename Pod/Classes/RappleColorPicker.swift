/* **
 RappleColorPicker.swift
 Custom Activity Indicator with swift
 
 Created by Rajeev Prasad on 28/11/15.
 
 The MIT License (MIT)
 
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
 ** */

import UIKit

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
    /** Background color for entire screen below the color picker */
    case ScreenBGColor = "ScreenBGColor"
}

/** RappleColorPicker attribute keys */
public enum RappleCPCellSize : String {
    /** Cell size 30 x 30 */
    case small
    /** Cell size 35 x 35 */
    case medium
    /** Cell size 40 x 40 */
    case large
    /** Cell size 50 x 50 */
    case vlarge
    
    var size: CGFloat {
        switch self {
        case .small: return 30
        case .medium: return 35
        case .large: return 40
        case .vlarge: return 50
        }
    }
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
     Open color picker with with a tag and custom look & feel (optional)
     - parameter onViewController: Optional Default top most view controller
     - parameter title: Default empty Optional
     - parameter origin: Default nil - center on the `onViewController` Optional
     - parameter cellSize: Default RappleCPCellSize.medium (35 x 35) Optional
     - parameter attributes: Look and feel attribute (Title, BGColor, TintColor, Style, BorderColor) Optional
     - parameter tag: Identification tag Optional
     */
    open class func openColorPallet(onViewController viewController: UIViewController? = nil, title: String? = nil, origin: CGPoint? = nil,
                                    cellSize: RappleCPCellSize = .medium, attributes:[RappleCPAttributeKey:AnyObject]? = nil, tag: Int = 0, completion: (( _ color: UIColor, _ tag: Int) -> Void)?) {
        
        let this = RappleColorPicker.sharedInstance
        
        let vc: UIViewController = viewController ?? UIApplication.rappleTopViewController()
        
        var attrib : [RappleCPAttributeKey : AnyObject] = attributes ?? [:]
        if title != nil {
            attrib[.Title] = title! as AnyObject
        } else {
            attrib[.Title] = attributes?[.Title]
        }
        attrib[.BGColor] = attributes?[.BGColor] as? UIColor ?? UIColor.darkGray
        attrib[.TintColor] = attributes?[.TintColor] as? UIColor ?? UIColor.white
        attrib[.Style] = (attributes?[.Style] as? String ?? RappleCPStyleCircle) as AnyObject
        attrib[.BorderColor] = attributes?[.BorderColor] as? UIColor
        attrib[.ScreenBGColor] = attributes?[.ScreenBGColor] as? UIColor
        
        this.background = UIView(frame: vc.view.bounds)
        this.background?.backgroundColor = UIColor.clear
        
        if let bg = attrib[.ScreenBGColor] as? UIColor {
            this.background?.backgroundColor = bg
        }
        
        vc.view.addSubview(this.background!)
        
        this.closeButton = UIButton(frame: this.background!.bounds)
        this.closeButton?.addTarget(this, action: #selector(RappleColorPicker.closeTapped), for: .touchUpInside)
        this.background?.addSubview(this.closeButton!)
        
        let totalWidth = (cellSize.size * 7) + 20
        var totalHeight = (cellSize.size * 11) + 28
        
        if attrib[.Title] != nil {
            totalHeight += 35
        }
        let xsize = CGSize(width: totalWidth, height: totalHeight)
        
        var xorigin: CGPoint!
        if let origin = origin {
            let fullSize = vc.view.frame.size
            var x: CGFloat = origin.x
            var y: CGFloat = origin.y
            if origin.x + totalWidth > fullSize.width {
                x = fullSize.width - totalWidth - 5
            }
            if origin.y + totalHeight > fullSize.height {
                y = fullSize.height - totalHeight - 5
            }
            if x < 0 { x = 0 }
            if y < 0 { y = 0 }
            xorigin = CGPoint(x: x, y: y)
        } else {
            let fullSize = vc.view.frame.size
            let x = (fullSize.width - totalWidth) / 2
            let y = (fullSize.height - totalHeight) / 2
            xorigin = CGPoint(x: x, y: y)
        }
        
        this.colorVC = RappleColorPickerViewController()
        this.colorVC?.completion = completion
        this.colorVC?.tag = tag
        this.colorVC?.attributes = attrib
        this.colorVC?.size = xsize
        this.colorVC?.cellSize = CGSize(width: cellSize.size, height: cellSize.size)
        this.colorVC!.view.frame = CGRect(origin: xorigin, size: xsize)
        this.background!.addSubview(this.colorVC!.view)
    }
    
    /** Close color picker Class func */
    open class func close(){
        defer {
            let this = RappleColorPicker.sharedInstance
            this.closeTapped()
        }
    }
    
    /** Close color picker */
    @objc  internal func closeTapped(){
        self.background?.removeFromSuperview()
        self.colorVC = nil
        self.closeButton = nil
        self.background = nil
    }
}

/**
 RappleColorPickerDelegate public delegate
 - Note: Only implement one mehod
 - Remark: If both methods are implemented `colorSelected(_:, tag:)` will be used as the delegate method and `colorSelected(_:)` will not be called
 */
@objc
public protocol RappleColorPickerDelegate: NSObjectProtocol {
    /** Retrieve selected color from color picker */
    @available(*, unavailable, message: "Use RappleColorPicker's `completion` of openColorPallet(onViewController:title:origin:size:attributes:completion) instead")
    @objc optional func colorSelected(_ color:UIColor)
    /** Retrieve selected color from color picker with indentification tag */
    @available(*, unavailable, message: "Use RappleColorPicker's `completion` of openColorPallet(onViewController:title:origin:size:attributes:completion) instead")
    @objc optional func colorSelected(_ color:UIColor, tag: Int)
}

/**
 Depricated starter methods
 */
extension RappleColorPicker {
    
    /** Deprecated and unavailabel method */
    @available(*, unavailable, message: "Use RappleColorPicker's openColorPallet(onViewController:title:origin:size:attributes:completion) instead")
    open class func openColorPallet(onViewController vc: UIViewController, origin: CGPoint, delegate:RappleColorPickerDelegate, title:String?) {
        
    }
    
    /** Deprecated and unavailabel method */
    @available(*, unavailable, message: "Use RappleColorPicker's openColorPallet(onViewController:title:origin:size:attributes:completion) instead")
    open class func openColorPallet(onViewController vc: UIViewController, origin: CGPoint, delegate:RappleColorPickerDelegate, title:String?, tag: Int) {
        
    }
    
    /** Deprecated and unavailabel method */
    @available(*, unavailable, message: "Use RappleColorPicker's openColorPallet(onViewController:title:origin:size:attributes:completion) instead")
    open class func openColorPallet(onViewController vc: UIViewController, origin: CGPoint, delegate:RappleColorPickerDelegate, attributes:[RappleCPAttributeKey:AnyObject]?) {
    }
    
    /** Deprecated and unavailabel method */
    @available(*, unavailable, message: "Use RappleColorPicker's openColorPallet(onViewController:title:origin:size:attributes:completion) instead")
    open class func openColorPallet(onViewController vc: UIViewController, origin: CGPoint, delegate:RappleColorPickerDelegate, attributes:[RappleCPAttributeKey:AnyObject]?, tag: Int) {
        
    }
}

/**
 UIApplication extension to get top most view controller
 */
extension UIApplication {
    
    /** Find top most presented view controller */
    class func rappleTopViewController() -> UIViewController {
        return UIApplication.rappleTopViewController(base: nil)
    }
    
    /** Find top most presented view controller */
    class func rappleTopViewController(base: UIViewController?) -> UIViewController {
        var baseView = base
        if baseView == nil {
            baseView = UIApplication.shared.delegate?.window??.rootViewController
        }
        if let vc = baseView?.presentedViewController {
            return UIApplication.rappleTopViewController(base: vc)
        } else {
            return baseView!
        }
    }
}
