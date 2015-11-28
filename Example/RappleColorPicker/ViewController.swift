//
//  ViewController.swift
//  RappleColorPicker
//
//  Created by Rajeev Prasad on 11/28/2015.
//  Copyright (c) 2015 Rajeev Prasad. All rights reserved.
//

import UIKit
import RappleColorPicker

class ViewController: UIViewController, RappleColorPickerViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func openColorPallet(sender:AnyObject?) {
        RappleColorPicker.setPickerDelegate(delegate: self, tintColor: UIColor.darkGrayColor(), bgColor: UIColor.whiteColor())
        RappleColorPicker.openColorPallet(title: nil, onViewController: self, origin: CGPointMake(100, 100))
    }
    
    func colorSelected(color: UIColor) {
        self.view.backgroundColor = color
        RappleColorPicker.close()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

