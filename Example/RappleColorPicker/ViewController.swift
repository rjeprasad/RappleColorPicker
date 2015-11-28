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
        RappleColorPicker.openColorPallet(onViewController: self, origin: CGPointMake(10, 100), delegate: self, title: "Colors")
    }
    
    func colorSelected(color: UIColor) {
        self.view.backgroundColor = color
        RappleColorPicker.close()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

