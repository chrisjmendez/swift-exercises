//
//  Lap.swift
//  StopWatch
//
//  Created by Tommy Trojan on 9/27/15.
//  Copyright (c) 2015 Chris Mendez. All rights reserved.
//

import UIKit

class Lap: UIView {
    
    override func drawRect(rect: CGRect) {
        AppButtons.drawLap()
    }
}
