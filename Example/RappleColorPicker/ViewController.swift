//
//  ViewController.swift
//  RappleColorPicker
//
//  Created by Rajeev Prasad on 11/28/2015.
//  Copyright (c) 2018 Rajeev Prasad. All rights reserved.
//

import UIKit
import RappleColorPicker

class ViewController: UIViewController, RappleColorPickerDelegate {
    
    @IBOutlet var box1: UIButton!
    @IBOutlet var box2: UIButton!
    @IBOutlet var box3: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func openColorPallet(_ sender:UIButton?) {
        /* picker without title */
        let attributes : [RappleCPAttributeKey : AnyObject] = [
            .BGColor : UIColor.yellow.withAlphaComponent(0.6),
            .TintColor : UIColor.red.withAlphaComponent(0.6),
            .Style : RappleCPStyleCircle as AnyObject,
            .BorderColor : UIColor.red.withAlphaComponent(0.6),
            .ScreenBGColor : UIColor.orange.withAlphaComponent(0.4)
        ]
        
        RappleColorPicker.openColorPallet(onViewController: self, origin: CGPoint(x: sender!.frame.midX - 115, y: sender!.frame.minY - 50), attributes: attributes) { (color, tag) in
            self.view.backgroundColor = color
            RappleColorPicker.close()
        }
    }
    
    
    @IBAction func openColorPalletForBox(_ sender:UIButton?){
        let tag = sender?.tag ?? 0
        RappleColorPicker.openColorPallet(title: "Color Picker", tag: tag) { (color, tag) in
            switch tag {
            case 1:
                self.box1.backgroundColor = color
            case 2:
                self.box2.backgroundColor = color
            case 3:
                self.box3.backgroundColor = color
            default: ()
            }
            RappleColorPicker.close()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

