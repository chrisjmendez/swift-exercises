//
//  GameScene.swift
//  SKVideoNode
//
//  Created by Tommy Trojan on 10/2/15.
//  Copyright (c) 2015 Chris Mendez. All rights reserved.
//

import SpriteKit
import AVFoundation
import AVKit
import Device

class GameScene: SKScene {
    
    var videoSprite:SKVideoNode?
    var videoPlayback:AVPlayer?
    let videoFile = ["path": "videos/fire_848x480", "type": "mp4", "fullPath": "videos/fire_848x480.mp4"]
    
    func delay(delay:Double, closure:()->()){
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
    
    func loadVideo(FileToPlay:String)
    {
        videoSprite = SKVideoNode(fileNamed: videoFile["fullPath"]!)
        videoSprite!.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        videoSprite!.name = "videoSprite"
        videoSprite!.zPosition = 1
        videoSprite!.play()

        addChild(videoSprite!)
    }
    
    func replayVideo(node: SKNode){
    }
    
    override func didMoveToView(view: SKView) {
        loadVideo(videoFile["path"]!)
        videoSprite!.pause()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        
        for touch in (touches as! Set<UITouch>)
        {
            let touch: UITouch = touches.first as UITouch!
            let location = touch.locationInNode(self)
            let node = self.nodeAtPoint(location)

            print(node.name)
            
            if (node.name == "videoSprite")
            {
                /// load another video ontop
                loadVideo( videoFile["fullPath"]! )
                //name it temp so user cant click to add more videonodes
                videoSprite!.name = "temp"
                // wait for time
                delay(1.8 ){
                    self.videoSprite!.removeFromParent()// then remove
                }
            }
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
