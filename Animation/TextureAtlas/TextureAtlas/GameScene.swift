//
//  GameScene.swift
//  TextureAtlas
//
//  Created by Tommy Trojan on 10/15/15.
//  Copyright (c) 2015 Chris Mendez. All rights reserved.
//
//  Resources
//  https://www.codeandweb.com/blog/2014/12/18/spritekit-textureatlases-with-swift

import SpriteKit

class GameScene: SKScene {

    let sheet = Hero()
    
    func initAnimation(){
        let flappingSpeed = 0.06
        
        let flap = SKAction.animateWithTextures(sheet.Wings(), timePerFrame: flappingSpeed)
        let flapping = SKAction.repeatAction(flap, count: 5)

        
        //Actions
        let moveRight = SKAction.moveToX(500, duration: flap.duration)
        let moveLeft  = SKAction.moveToX(100, duration: flap.duration)
        
        let mirrorDirection = SKAction.scaleXTo(-1, duration: 0.0)
        let resetDirection  = SKAction.scaleXTo(1, duration: 0.0)

        
        //Group of animations
        let walkAndMoveRight = SKAction.group([resetDirection, flapping, moveRight])
        let walkAndMoveLeft  = SKAction.group([mirrorDirection, flapping, moveLeft])
        
        let sequence = SKAction.repeatActionForever(SKAction.sequence([walkAndMoveRight, walkAndMoveLeft]))
        
        let sprite = SKSpriteNode(texture: sheet.Wings01())
            sprite.position = CGPointMake(100.0, CGFloat(rand() % 100) + 200.0)
            sprite.runAction(sequence)
        
        self.addChild(sprite)
    }
    
    override func didMoveToView(view: SKView) {
        initAnimation()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {

    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
