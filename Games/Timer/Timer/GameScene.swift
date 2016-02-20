//
//  GameScene.swift
//  Timer
//
//  Created by Chris on 2/17/16.
//  Copyright (c) 2016 Chris Mendez. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var timer:CountdownTimer?
    
    override func didMoveToView(view: SKView) {

        /*
        let demoURL = NSBundle.mainBundle().URLForResource("demo", withExtension: "rtf")!
        let attrStr = try? NSAttributedString(fileURL: demoURL, options: [NSDocumentTypeDocumentAttribute: NSRTFTextDocumentType], documentAttributes: nil)
        
        let myLabel = ASAttributedLabelNode(size: self.size)
        myLabel.attributedString = attrStr
        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame));
        self.addChild(myLabel)
        */
        
        timer = ASAttributedLabelNode(size: self.frame.size) as! CountdownTimer
        timer?.createAttributedString("chris")
        timer?.startWithDuration(3)
        timer?.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        
        /*
        let myLabel = SKLabelNode(fontNamed:"Chalkduster")
        myLabel.text = "Hello, World!"
        myLabel.fontSize = 45
        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        
        self.addChild(myLabel)
        */
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        
        for touch in touches {
            let location = touch.locationInNode(self)
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        //print(timer?.hasFinished())
        timer?.update()
    }
}
