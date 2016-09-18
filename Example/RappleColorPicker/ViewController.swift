//
//  ViewController.swift
//  RappleColorPicker
//
//  Created by Rajeev Prasad on 11/28/2015.
//  Copyright (c) 2016 Rajeev Prasad. All rights reserved.
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
    
    @IBAction func openColorPallet(sender:UIButton?) {
        /* picker without title */
        let attributes : [RappleCPAttributeKey : AnyObject] = [
            .BGColor : UIColor.yellow.withAlphaComponent(0.6),
            .TintColor : UIColor.red.withAlphaComponent(0.6),
            .Style : RappleCPStyleCircle as AnyObject,
            .BorderColor : UIColor.red.withAlphaComponent(0.6)
        ]
        
        RappleColorPicker.openColorPallet(onViewController: self, origin: CGPoint(x: sender!.frame.midX - 115, y: sender!.frame.minY - 50), delegate: self, attributes: attributes)
    }
    
    
    @IBAction func openColorPalletForBox(sender:UIButton?){
        let tag = sender?.tag ?? 0
        RappleColorPicker.openColorPallet(onViewController: self, origin: CGPoint(x: sender!.frame.midX - 115, y: sender!.frame.minY - 50), delegate: self, title: "Color Picker", tag: tag)
    }
    
    func colorSelected(_ color: UIColor) {
        // this method wont be called because `colorSelected(_ color: UIColor, tag: Int)` method will have the priority
        self.view.backgroundColor = color
        RappleColorPicker.close()
    }
    
    func colorSelected(_ color: UIColor, tag: Int) {
        switch tag {
        case 1:
            box1.backgroundColor = color
        case 2:
            box2.backgroundColor = color
        case 3:
            box3.backgroundColor = color
        default:
            self.view.backgroundColor = color
        }
        RappleColorPicker.close()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

