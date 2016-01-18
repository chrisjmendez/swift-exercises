//
//  Button.swift
//  BubbleTransitions
//
//  Created by Chris on 1/18/16.
//  Copyright © 2016 Chris Mendez. All rights reserved.
//

import UIKit

@IBDesignable class Button: UIButton {
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