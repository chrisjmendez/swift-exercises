//
//  GameViewController.swift
//  SKVideoNode
//
//  Created by Tommy Trojan on 10/2/15.
//  Copyright (c) 2015 Chris Mendez. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {

    var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let scene = GameScene(fileNamed:"GameScene") {
            // Configure the view.
            let skView = self.view as! SKView
            skView.showsFPS = true
            skView.showsNodeCount = true
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .AspectFill
            
            skView.presentScene(scene)
        }
        
        checkDevice()
    }
    
    func message(){
        textView = UITextView(frame: self.view.frame)
        textView.font = UIFont(name: "Arial", size: 40)
        textView.center = CGPointMake(CGRectGetMidX(self.view.frame), CGRectGetMidY(self.view.frame))
        textView.textAlignment = NSTextAlignment.Center
        textView.text = "Video will not appear while in Simulator mode. Please use an actual device"
        self.view.addSubview(textView)
    }
    
    func checkDevice(){
        let deviceType = UIDevice.currentDevice().deviceType
        if( String(deviceType) == "Simulator" ){
            message()
        }
    }

    override func shouldAutorotate() -> Bool {
        return true
    }

    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return .AllButUpsideDown
        } else {
            return .All
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
