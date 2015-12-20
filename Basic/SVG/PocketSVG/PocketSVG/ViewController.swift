//
//  ViewController.swift
//  SVG
//
//  Created by Tommy Trojan on 12/17/15.
//  Copyright © 2015 Chris Mendez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    func onLoad(){
        //1: Turn your SVG into a CGPath:
        let myPath = PocketSVG.pathFromSVGFileNamed("AD").takeUnretainedValue()
        
        //2: To display it on screen, you can create a CAShapeLayer
        //and set myPath as its path property:
        let myShapeLayer = CAShapeLayer()
        myShapeLayer.path = myPath
        
        
        //3: Fiddle with it using CAShapeLayer's properties:
        myShapeLayer.strokeColor = UIColor.redColor().CGColor
        myShapeLayer.lineWidth = 3
        myShapeLayer.fillColor = UIColor.clearColor().CGColor
        
        
        //4: Display it!
        self.view.layer.addSublayer(myShapeLayer)
        
        
        //Make it smaller if we're on an iPhone:
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            myShapeLayer.transform = CATransform3DMakeScale(0.3, 0.3, 0.3)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        onLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

