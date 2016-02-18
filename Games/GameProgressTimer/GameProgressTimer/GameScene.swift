//
//  GameScene.swift
//  Positioning
//
//  Created by Tommy Trojan on 10/8/15.
//  Copyright (c) 2015 Chris Mendez. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {

    let countDown = 3.0
    var progress:ProgressNode?
    
    func checkDimensions(){
        let frameW = self.frame.width
        let frameH = self.frame.height
        print( "frame width:", frameW, "frame height:", frameH )
    }
    
    override func didMoveToView(view: SKView) {
        progress = ProgressNode()
        progress?.name = "progress"
        progress?.radius = CGRectGetWidth(self.frame) * 0.25
        progress?.width  = 15.0
        progress?.color  = SKColor.blueColor()
        progress?.backgroundColor = SKColor(red: 120, green: 153, blue: 185, alpha: 1)
        progress?.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
        progress?.countdown(countDown, progressHandler: onProgress, completionHandler: onProgressComplete)
        
        self.addChild(progress!)
        
        checkDimensions()
    }
    
    func onProgress(){
        //print("onProgress")
    }
    
    func onProgressComplete(){
        //print("onProgressComplete")
        progress?.removeFromParent()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        for touch in touches {
            let location = touch.locationInNode(self)
            print(location)
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
