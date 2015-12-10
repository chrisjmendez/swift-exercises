//
//  Theme.swift
//  Twitter Copycat
//
//  Created by Tommy Trojan on 9/26/15.
//  Copyright (c) 2015 Chris Mendez. All rights reserved.
//

// Example: A theme file used to share common styles across obejcts

import UIKit

struct Theme {
    static let debugBackground = UIColor.purpleColor()
    
    // Buttons
    static let buttonDisabled = UIColor(red:0.2431, green:0.5216, blue:0.6196, alpha:0.25)
    static let buttonNormal   = UIColor(red:0.2431, green:0.5216, blue:0.6196, alpha:1.0)
    static let buttonSelected = UIColor(red:0.2431, green:0.5216, blue:0.6196, alpha:0.75)
    
    static let backgroundPattern = UIColor(patternImage: UIImage(named: "pattern")!)
    
    // Typeface
    static let defaultFont = UIFont(name: "ProximaNova-Regular", size:18.0)
    static let navBarFont  = UIFont(name: "ProximaNova-Regular", size:16.0)
}