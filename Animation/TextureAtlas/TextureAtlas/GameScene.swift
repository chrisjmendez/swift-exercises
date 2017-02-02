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
        
        let flap = SKAction.animate(with: sheet.Wings(), timePerFrame: flappingSpeed)
        let flapping = SKAction.repeat(flap, count: 5)

        
        //Actions
        let moveRight = SKAction.moveTo(x: 500, duration: flap.duration)
        let moveLeft  = SKAction.moveTo(x: 100, duration: flap.duration)
        
        let mirrorDirection = SKAction.scaleX(to: -1, duration: 0.0)
        let resetDirection  = SKAction.scaleX(to: 1, duration: 0.0)

        
        //Group of animations
        let walkAndMoveRight = SKAction.group([resetDirection, flapping, moveRight])
        let walkAndMoveLeft  = SKAction.group([mirrorDirection, flapping, moveLeft])
        
        let sequence = SKAction.repeatForever(SKAction.sequence([walkAndMoveRight, walkAndMoveLeft]))
        
        let sprite = SKSpriteNode(texture: sheet.Wings01())
            sprite.position = CGPoint(x: 100.0, y: CGFloat(arc4random() % 100) + 200.0)
            sprite.run(sequence)
        
        self.addChild(sprite)
    }
    
    override func didMove(to view: SKView) {
        initAnimation()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

    }
   
    override func update(_ currentTime: TimeInterval) {
        /* Called before each frame is rendered */
    }
}
