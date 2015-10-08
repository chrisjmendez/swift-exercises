//
//  GameScene.swift
//  Positioning
//
//  Created by Tommy Trojan on 10/8/15.
//  Copyright (c) 2015 Chris Mendez. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    //SKNode holds no position information at all. It's a simple wrapper
    var movingGameObjects = SKNode()
    
    var bg = SKSpriteNode()
    
    enum objectsZPositions: CGFloat{
        case background = 0
        case label      = 1
        case logo       = 2
    }

    let logoPath = "logo.png"
    
    let fire1 = Theme.backgrounds.fire1
    let fire2 = Theme.backgrounds.fire2
    let fire3 = Theme.backgrounds.fire3
    
    func prepareTexture( arr:Array<String> ) -> Array<SKTexture> {
        //Create an array of textures
        var sprites = [SKTexture]()
        //PNG => Texture => Array
        for sprite in arr {
            //Add each image into the sprites
            let thisTexture = SKTexture(imageNamed: sprite)
            sprites.append(thisTexture)
        }
        return sprites
    }
    
    func createAnimation( nodeName:String, arr:Array<String> ) -> SKSpriteNode{
        //Animate the textures
        let sprites = prepareTexture( arr )
        let interval:NSTimeInterval = 0.1
        let animation       = SKAction.animateWithTextures(sprites, timePerFrame: interval)
        //Loop the animation forever
        let repeatAnimation = SKAction.repeatActionForever(animation)
        //Wrap the texture in a Sprite Node
        let spriteNode      = SKSpriteNode(texture: sprites[0])
        //Position the Sprite Node near the bottom left corner
        spriteNode.runAction(repeatAnimation, withKey: nodeName)
        
        return spriteNode
    }
    
    func initBackground(){
        let background = createAnimation("background", arr: fire1  )
        //Scale the animation
        let scaleFactor = (self.frame.height / background.size.height )
        background.xScale = scaleFactor
        background.yScale = scaleFactor
        background.anchorPoint = CGPointMake(0,0)
        background.position = CGPointMake(0,0)
        background.zPosition = CGFloat(objectsZPositions.background.rawValue)
        
        //THis is a really cool effect
        /*
        spriteNode.xScale = 5//scaleFactor
        spriteNode.yScale = scaleFactor * spriteNode.size.height
        */

        let backgroundSpeed:Double = 20
        //B. The action that will move the background from point A to B
        let moveBG     = SKAction.moveByX( -background.size.width, y: 0, duration: backgroundSpeed )
        //C. The action that will plop a new background instance at point A
        let replaceBG  = SKAction.moveByX( background.size.width, y: 0, duration: 0 )
        //D. Assign the two actions to an array
        let actions    = [moveBG, replaceBG]
        //E. Create a sequence of the items within the array
        let sequenceBG = SKAction.sequence(actions)
        //F. Repeat the sequence forver
        let loopBG     = SKAction.repeatActionForever(sequenceBG)
        //G. Run the Animation
        
        //TODO: Need to figure out how to paste a second animatino
        for var i:CGFloat = 0; i < 2; i++ {
            /*
            bg.position = CGPoint(
                x: bgTexture.size().width/2 + i * bgTexture.size().width,
                y: CGRectGetMidY(self.frame)
            )
*/
//            background.size.height = self.frame.height
            //Run the background loop forver
            //Keep all the objects contained within a single location
        }
        background.runAction(loopBG)
        movingGameObjects.addChild(background)
    }

    func initLabel(){
        let myLabel = SKLabelNode(fontNamed:"Chalkduster")
        myLabel.text = "Positioning";
        myLabel.fontSize = 45;
        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame));
        myLabel.zPosition = objectsZPositions.label.rawValue

        movingGameObjects.addChild(myLabel)
    }
    
    func initLogo(){
        let logo = SKSpriteNode(texture: SKTexture(imageNamed: logoPath), size: CGSize(width: 128, height: 128) )
        logo.anchorPoint = CGPointMake(0, 1)
        logo.position = CGPointMake(0, self.frame.height)
        logo.zPosition = objectsZPositions.logo.rawValue
        movingGameObjects.addChild(logo)
    }
    
    func checkDimensions(){
        let frameW = self.frame.width
        let frameH = self.frame.height
        print( "frame width:", frameW, "frame height:", frameH )
    }
    
    override func didMoveToView(view: SKView) {
        self.addChild(movingGameObjects)
        checkDimensions()

        initBackground()
        initLabel()
        initLogo()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        
        for touch in touches {
            let location = touch.locationInNode(self)
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
