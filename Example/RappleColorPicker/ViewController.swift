//
//  ViewController.swift
//  RappleColorPicker
//
//  Created by Rajeev Prasad on 11/28/2015.
//  Copyright (c) 2015 Rajeev Prasad. All rights reserved.
//

import UIKit
import RappleColorPicker

class ViewController: UIViewController, RappleColorPickerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func openColorPallet(sender:AnyObject?) {
        let attributes : [RappleCPAttributeKey : AnyObject] = [.Title : "Pick a Color",
            .BGColor : UIColor.blackColor(), .TintColor : UIColor.whiteColor(), .Style : RappleCPStyleCircle]
        RappleColorPicker.openColorPallet(onViewController: self, origin: CGPointMake(50, 100), delegate: self, attributes: attributes)
    }
    
    func colorSelected(color: UIColor) {
        self.view.backgroundColor = color
        RappleColorPicker.close()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

