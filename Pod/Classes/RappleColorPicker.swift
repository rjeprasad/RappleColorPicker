/* **
RappleColorPicker.swift
Custom Activity Indicator with swift 2.0

Created by Rajeev Prasad on 28/11/15.

The MIT License (MIT)

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
** */

import UIKit

/**
 RappleColorPickerDelegate - colorSelected selected color from color pallet
 */
public protocol RappleColorPickerDelegate {
    func colorSelected(color:UIColor)
}

/**
 RappleColorPicker - Easy to use color pricker for iOS apps
 */
public class RappleColorPicker: NSObject {
    
    private var colorVC : RappleColorPickerViewController?
    private var background : UIView?
    private var closeButton : UIButton?
    
    private var delegate : RappleColorPickerDelegate?
    
    private static let sharedInstance = RappleColorPicker()
    
    /**
     Open color pallet
     Color picker size - CGSize(218, 352)
     @param     onViewController progress UI attributes
     @param     origin origin point of the color pallet
     @param     delegate RappleColorPickerDelegate
     @param     title color pallet name default "Color Picker"
     */
    public class func openColorPallet(onViewController vc: UIViewController, origin: CGPoint, delegate:RappleColorPickerDelegate, title:String?) {
        
        let this = RappleColorPicker.sharedInstance
        
        this.delegate = delegate
        
        this.background = UIView(frame: vc.view.bounds)
        this.background?.backgroundColor = UIColor.clearColor()
        vc.view.addSubview(this.background!)
        
        this.closeButton = UIButton(frame: this.background!.bounds)
        this.closeButton?.addTarget(this, action: "closeTapped:", forControlEvents: .TouchUpInside)
        this.background?.addSubview(this.closeButton!)
        
        var point = CGPointMake(origin.x, origin.y)
        if origin.x < 0 { point.x = 0 }
        if origin.y < 0 { point.y = 0 }
        if origin.x + 220 > vc.view.bounds.width { point.x = vc.view.bounds.width - 220 }
        if origin.y + 354 > vc.view.bounds.height { point.y = vc.view.bounds.height - 354 }
        
        this.colorVC = RappleColorPickerViewController()
        this.colorVC?.delegate = this.delegate
        this.colorVC?.title = title != nil ? title : "Color Picker"
        this.colorVC!.view.frame = CGRectMake(point.x, point.y, 218, 352)
        this.background!.addSubview(this.colorVC!.view)
        
    }
    
    /**
     Close color pallet
     */
    public class func close(){
        let this = RappleColorPicker.sharedInstance
        this.background?.removeFromSuperview()
        this.colorVC = nil
        this.closeButton = nil
        this.background = nil
    }
    
    internal func closeTapped(sender : AnyObject?) {
        RappleColorPicker.close()
    }
}
