//
//  ButtonView.swift
//  Concurrency
//
//  Created by tommy trojan on 4/18/15.
//  Copyright (c) 2015 Skyground Media Inc. All rights reserved.
//

import UIKit

@IBDesignable class ButtonView: UIButton {

    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    @IBInspectable var fillColor: UIColor = UIColor.blueColor()
    @IBInspectable var isAddButton: Bool = true
    
    override func drawRect(rect: CGRect) {
        //// Color Declarations
        let fillColor2 = UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 1.000)
        
        //// Group 2
        //// Bezier Drawing
        var bezierPath = UIBezierPath()
        bezierPath.moveToPoint(CGPointMake(53.72, 84.61))
        bezierPath.addCurveToPoint(CGPointMake(55.44, 90.43), controlPoint1: CGPointMake(54.8, 86.3), controlPoint2: CGPointMake(55.44, 88.29))
        bezierPath.addCurveToPoint(CGPointMake(55.41, 91.12), controlPoint1: CGPointMake(55.44, 90.66), controlPoint2: CGPointMake(55.42, 90.89))
        bezierPath.addLineToPoint(CGPointMake(64.96, 91.12))
        bezierPath.addCurveToPoint(CGPointMake(64.92, 90.43), controlPoint1: CGPointMake(64.95, 90.89), controlPoint2: CGPointMake(64.92, 90.66))
        bezierPath.addCurveToPoint(CGPointMake(66.64, 84.61), controlPoint1: CGPointMake(64.92, 88.29), controlPoint2: CGPointMake(65.56, 86.3))
        bezierPath.addLineToPoint(CGPointMake(53.72, 84.61))
        bezierPath.closePath()
        fillColor2.setFill()
        bezierPath.fill()
        
        
        //// Bezier 2 Drawing
        var bezier2Path = UIBezierPath()
        bezier2Path.moveToPoint(CGPointMake(73.99, 38.31))
        bezier2Path.addCurveToPoint(CGPointMake(74.01, 37.95), controlPoint1: CGPointMake(73.99, 38.19), controlPoint2: CGPointMake(74.01, 38.07))
        bezier2Path.addLineToPoint(CGPointMake(32.5, 34.07))
        bezier2Path.addLineToPoint(CGPointMake(30.07, 23.96))
        bezier2Path.addCurveToPoint(CGPointMake(27, 20.64), controlPoint1: CGPointMake(29.7, 22.39), controlPoint2: CGPointMake(28.54, 21.13))
        bezier2Path.addLineToPoint(CGPointMake(9.03, 14.85))
        bezier2Path.addCurveToPoint(CGPointMake(6.38, 14.23), controlPoint1: CGPointMake(8.23, 14.46), controlPoint2: CGPointMake(7.34, 14.23))
        bezier2Path.addCurveToPoint(CGPointMake(0.23, 20.35), controlPoint1: CGPointMake(2.99, 14.23), controlPoint2: CGPointMake(0.23, 16.96))
        bezier2Path.addCurveToPoint(CGPointMake(6.38, 26.46), controlPoint1: CGPointMake(0.23, 23.72), controlPoint2: CGPointMake(2.99, 26.46))
        bezier2Path.addCurveToPoint(CGPointMake(10.4, 24.95), controlPoint1: CGPointMake(7.93, 26.46), controlPoint2: CGPointMake(9.31, 25.87))
        bezier2Path.addLineToPoint(CGPointMake(21.69, 28.58))
        bezier2Path.addCurveToPoint(CGPointMake(32.08, 71.94), controlPoint1: CGPointMake(21.69, 28.58), controlPoint2: CGPointMake(30.52, 66.16))
        bezier2Path.addCurveToPoint(CGPointMake(36.46, 83.18), controlPoint1: CGPointMake(32.87, 74.92), controlPoint2: CGPointMake(34.35, 79.34))
        bezier2Path.addCurveToPoint(CGPointMake(42.24, 79.83), controlPoint1: CGPointMake(37.96, 81.52), controlPoint2: CGPointMake(39.96, 80.32))
        bezier2Path.addCurveToPoint(CGPointMake(40.38, 75.48), controlPoint1: CGPointMake(41.38, 78.36), controlPoint2: CGPointMake(40.69, 76.79))
        bezier2Path.addLineToPoint(CGPointMake(85.63, 75.48))
        bezier2Path.addCurveToPoint(CGPointMake(90.07, 72.11), controlPoint1: CGPointMake(87.7, 75.48), controlPoint2: CGPointMake(89.52, 74.11))
        bezier2Path.addLineToPoint(CGPointMake(92.56, 60.05))
        bezier2Path.addCurveToPoint(CGPointMake(73.99, 38.31), controlPoint1: CGPointMake(82.05, 58.33), controlPoint2: CGPointMake(73.99, 49.25))
        bezier2Path.closePath()
        fillColor2.setFill()
        bezier2Path.fill()
        
        
        //// Oval Drawing
        var ovalPath = UIBezierPath(ovalInRect: CGRectMake(38.45, 83.55, 12.4, 13.4))
        fillColor2.setFill()
        ovalPath.fill()
        
        
        //// Oval 2 Drawing
        var oval2Path = UIBezierPath(ovalInRect: CGRectMake(69, 83.6, 13.4, 13.3))
        fillColor2.setFill()
        oval2Path.fill()
        
        
        //// Bezier 3 Drawing
        var bezier3Path = UIBezierPath()
        bezier3Path.moveToPoint(CGPointMake(96.16, 20.18))
        bezier3Path.addCurveToPoint(CGPointMake(77.93, 38.31), controlPoint1: CGPointMake(86.11, 20.18), controlPoint2: CGPointMake(77.93, 28.32))
        bezier3Path.addCurveToPoint(CGPointMake(93.36, 56.16), controlPoint1: CGPointMake(77.93, 47.36), controlPoint2: CGPointMake(84.64, 54.81))
        bezier3Path.addCurveToPoint(CGPointMake(96.16, 56.45), controlPoint1: CGPointMake(94.28, 56.31), controlPoint2: CGPointMake(95.2, 56.45))
        bezier3Path.addCurveToPoint(CGPointMake(114.39, 38.31), controlPoint1: CGPointMake(106.21, 56.45), controlPoint2: CGPointMake(114.39, 48.31))
        bezier3Path.addCurveToPoint(CGPointMake(96.16, 20.18), controlPoint1: CGPointMake(114.39, 28.32), controlPoint2: CGPointMake(106.21, 20.18))
        bezier3Path.closePath()
        bezier3Path.moveToPoint(CGPointMake(108.61, 41.54))
        bezier3Path.addLineToPoint(CGPointMake(99.5, 41.54))
        bezier3Path.addLineToPoint(CGPointMake(99.5, 50.55))
        bezier3Path.addCurveToPoint(CGPointMake(96.51, 52.33), controlPoint1: CGPointMake(99.5, 51.74), controlPoint2: CGPointMake(98.5, 52.33))
        bezier3Path.addLineToPoint(CGPointMake(95.68, 52.33))
        bezier3Path.addCurveToPoint(CGPointMake(94.18, 52.15), controlPoint1: CGPointMake(95.08, 52.33), controlPoint2: CGPointMake(94.6, 52.26))
        bezier3Path.addCurveToPoint(CGPointMake(92.7, 50.55), controlPoint1: CGPointMake(93.22, 51.9), controlPoint2: CGPointMake(92.7, 51.38))
        bezier3Path.addLineToPoint(CGPointMake(92.7, 41.54))
        bezier3Path.addLineToPoint(CGPointMake(83.71, 41.54))
        bezier3Path.addCurveToPoint(CGPointMake(81.93, 38.69), controlPoint1: CGPointMake(82.54, 41.54), controlPoint2: CGPointMake(81.96, 40.58))
        bezier3Path.addCurveToPoint(CGPointMake(81.92, 38.58), controlPoint1: CGPointMake(81.93, 38.65), controlPoint2: CGPointMake(81.92, 38.62))
        bezier3Path.addLineToPoint(CGPointMake(81.92, 38.17))
        bezier3Path.addCurveToPoint(CGPointMake(83.71, 35.2), controlPoint1: CGPointMake(81.92, 36.19), controlPoint2: CGPointMake(82.52, 35.2))
        bezier3Path.addLineToPoint(CGPointMake(92.7, 35.2))
        bezier3Path.addLineToPoint(CGPointMake(92.7, 26.07))
        bezier3Path.addCurveToPoint(CGPointMake(95.68, 24.29), controlPoint1: CGPointMake(92.7, 24.89), controlPoint2: CGPointMake(93.69, 24.29))
        bezier3Path.addLineToPoint(CGPointMake(96.51, 24.29))
        bezier3Path.addCurveToPoint(CGPointMake(99.5, 26.07), controlPoint1: CGPointMake(98.49, 24.29), controlPoint2: CGPointMake(99.5, 24.89))
        bezier3Path.addLineToPoint(CGPointMake(99.5, 35.2))
        bezier3Path.addLineToPoint(CGPointMake(108.61, 35.2))
        bezier3Path.addCurveToPoint(CGPointMake(110.39, 38.17), controlPoint1: CGPointMake(109.8, 35.2), controlPoint2: CGPointMake(110.39, 36.19))
        bezier3Path.addLineToPoint(CGPointMake(110.39, 38.58))
        bezier3Path.addCurveToPoint(CGPointMake(108.61, 41.54), controlPoint1: CGPointMake(110.4, 40.56), controlPoint2: CGPointMake(109.8, 41.54))
        bezier3Path.closePath()
        fillColor2.setFill()
        bezier3Path.fill()

    }
    
}
