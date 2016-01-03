//
//  View.swift
//  Beacons
//
//  Created by Tommy Trojan on 1/2/16.
//  Copyright © 2016 Chris Mendez. All rights reserved.
//

import UIKit

@IBDesignable class View: UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
    // Drawing code
    }
    */
    
}
