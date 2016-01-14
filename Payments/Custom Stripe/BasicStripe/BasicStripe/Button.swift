//
//  Button.swift
//  CustomForm
//
//  Created by Tommy Trojan on 12/21/15.
//  Copyright © 2015 Chris Mendez. All rights reserved.
//
// http://www.splinter.com.au/2014/09/04/subclass-uibutton/

import UIKit

@IBDesignable class Button:UIButton {
    
    @IBInspectable var borderColor: UIColor = UIColor.clearColor() {
        didSet {
            layer.borderColor = borderColor.CGColor
        }
    }
    
    @IBInspectable var borderWidth:CGFloat = 0 {
        didSet{
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var cornerRadius:CGFloat = 0 {
        didSet{
            layer.cornerRadius = cornerRadius
        }
    }
}
