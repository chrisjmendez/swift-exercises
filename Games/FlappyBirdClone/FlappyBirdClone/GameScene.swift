//
//  GameScene.swift
//  FlappyBirdClone
//
//  Created by tommy trojan on 6/17/15.
//  Copyright (c) 2015 Chris Mendez. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var textures = [
        "bird1.png", "bird2.png", "bird3.png", "bird4.png",
        "bird5.png", "bird6.png", "bird7.png", "bird8.png"
    ]
    var pipeTextures = [
        "pipe1.png", "pipe2.png"
    ]
    
    //Detect whether two objects are colliding
    let birdGroup: UInt32 = 0x1 << 0
    //The types and the ground
    let enemyObjectsGroup:UInt32 = 0x1 << 1
    //Opening between the two pipes represents a positive score
    let openingGroup:UInt32 = 0x1 << 2
    
    //Give objects a position
    enum objectsZPositions: CGFloat{
        case background = 0
        case ground     = 1
        case pipes      = 2
        case bird       = 3
        case score      = 4
        case gameOver   = 5
        case lightbox   = 6
    }
    //Store all the objects within here so that you can start/stop things at once
    var movingGameObjects = SKNode()
    
    var bg = SKSpriteNode()
    var lightbox = SKSpriteNode()
    
    //Objects
    var bird = SKSpriteNode()
    var ground = SKSpriteNode()
    
    var pipeSpeed:NSTimeInterval = 7
    var pipesSpawned:Int = 0
    
    //Keep track if the game is over
    var gameOver:Bool = false

    var scoreLabelNode = SKLabelNode()
    var score:Int = 0
    
    var gameOverLabelNode = SKLabelNode()
    var gameOverStatusNode = SKLabelNode()
    
    func createBackground(){
        //A. Assign the background image to a texture
        var bgTexture = SKTexture(imageNamed: "background")
        //B. The action that will move the background from point A to B
        var moveBG     = SKAction.moveByX(-bgTexture.size().width, y: 0, duration: 12)
        //C. The action that will plop a new background instance at point A
        var replaceBG  = SKAction.moveByX(bgTexture.size().width, y: 0, duration: 0)
        //D. Assign the two actions to an array
        var actions  = [moveBG, replaceBG]
        //E. Create a sequence of the items within the array
        var sequenceBG = SKAction.sequence(actions)
        //F. Repeat the sequence forver
        var loopBG     = SKAction.repeatActionForever(sequenceBG)
       
        //G. Create a loop so that the background doesn't go off the screen
        for var i:CGFloat = 0; i < 2; i++ {
            bg = SKSpriteNode(texture: bgTexture)
            bg.position = CGPoint(
                x: bgTexture.size().width/2 + i * bgTexture.size().width,
                y: CGRectGetMidY(self.frame)
            )
            bg.size.height = self.frame.height
            bg.zPosition = -1//objectsZPositions.background.rawValue
            //Run the background loop forver
            bg.runAction(loopBG)
            //Keep all the objects contained within a single location
            movingGameObjects.addChild(bg)
        }
    }
    
    func modifyGravity(){
        self.physicsWorld.contactDelegate = self
        //Basic gravity is 9.8m/s but we're going to change ours
        self.physicsWorld.gravity = CGVectorMake(0, -15)
    }
    
    func initProtagonist(){
        //Create an animation from the bird sprites
        var sprites = [SKTexture]()
        for texture in self.textures{
            var birdTexture = SKTexture(imageNamed: texture )
            sprites.append(birdTexture)
        }
        let flyAnimation = SKAction.animateWithTextures(sprites, timePerFrame: 0.1)
        let flyForever = SKAction.repeatActionForever(flyAnimation)

        //Initialize the bird
        bird = SKSpriteNode(texture: sprites[0])
        bird.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
        bird.zPosition = objectsZPositions.bird.rawValue
        //Track the bird using a key
        bird.runAction(flyForever, withKey: "birdFly")
        
        bird.physicsBody = SKPhysicsBody(circleOfRadius: bird.size.height/2)
        bird.physicsBody?.categoryBitMask = birdGroup
        //If two objects collide, they CAN pass through
        bird.physicsBody?.contactTestBitMask = openingGroup | enemyObjectsGroup
        //if two objects collide, they CAN NOT pass through
        bird.physicsBody?.collisionBitMask = enemyObjectsGroup
        //The bird CAN NOT rotate if it collides with the object
        bird.physicsBody?.allowsRotation = false
        
        self.addChild(bird)
    }
    
    func initGround(){
        var ground = SKNode()
            ground.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(self.frame.width, 1))
            //Ground will be independent of gravity so it will stick
            ground.physicsBody?.dynamic = false
            //Position ground right at the bottom of the screen
            ground.position = CGPoint(x: CGRectGetMidX(self.frame), y: 0)
            //Z position
            ground.zPosition = objectsZPositions.ground.rawValue
            //Hit testing
            ground.physicsBody?.categoryBitMask = enemyObjectsGroup
            ground.physicsBody?.collisionBitMask = birdGroup
            ground.physicsBody?.contactTestBitMask = birdGroup
        self.addChild(ground)
    }
    
    func loadPipes(){
        //A. Spawn the pipes
        pipesSpawned += 2
        if pipesSpawned % 10 == 0{
            pipeSpeed -= 0.5
        }
        //B. Measure the distance of the bird and give it some margin
        let margin:CGFloat = 3.5
        let gap:CGFloat = bird.size.height * margin
        //C. Create a random Y for the pipe positions
        let randomY:CGFloat = CGFloat(arc4random_uniform(UInt32(self.frame.height * 0.7)))
        //D. Create Pipe 1
        var pipe1 = SKSpriteNode(texture: SKTexture(imageNamed: pipeTextures[0]) )
            pipe1.position = CGPoint(
                x: self.frame.width + pipe1.size.width,
                y: pipe1.size.height/2 + 150 + randomY + gap/2
            )
            pipe1.physicsBody = SKPhysicsBody(rectangleOfSize: pipe1.size)
            pipe1.physicsBody?.dynamic = false;
            pipe1.physicsBody?.categoryBitMask = enemyObjectsGroup
            pipe1.physicsBody?.collisionBitMask = birdGroup
            pipe1.physicsBody?.contactTestBitMask = birdGroup
        
            pipe1.zPosition = objectsZPositions.pipes.rawValue

        movingGameObjects.addChild(pipe1)
        
        //E. Describe how the pipes will move
        let movePipe = SKAction.moveToX(-pipe1.size.width, duration: pipeSpeed)
        let removePipe = SKAction.removeFromParent()
        
        pipe1.runAction(SKAction.sequence([movePipe, removePipe]))
        
        var pipe2 = SKSpriteNode(texture: SKTexture(imageNamed: pipeTextures[1]))
            pipe2.position = CGPoint(
                x: self.frame.width + pipe2.size.width,
                y: -pipe2.size.height/2 + 150 + randomY - gap/2
            )
            pipe2.physicsBody = SKPhysicsBody(rectangleOfSize: pipe2.size)
            pipe2.physicsBody?.dynamic = false
            pipe2.physicsBody?.categoryBitMask = enemyObjectsGroup
            pipe2.physicsBody?.collisionBitMask = birdGroup
            pipe2.physicsBody?.contactTestBitMask = birdGroup
            pipe2.zPosition = objectsZPositions.pipes.rawValue
        
        movingGameObjects.addChild(pipe2)
        
        pipe2.runAction(SKAction.sequence([movePipe, removePipe]))
        
        let crossing = SKNode()
        crossing.position = CGPoint(x: pipe1.position.x + pipe1.size.width/2, y: CGRectGetMidY(self.frame))
        crossing.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake((1), self.frame.height))
        crossing.physicsBody?.dynamic = false
        crossing.physicsBody?.categoryBitMask = openingGroup
        crossing.physicsBody?.contactTestBitMask = birdGroup

        movingGameObjects.addChild(crossing)
        crossing.runAction(SKAction.sequence([movePipe, removePipe]))
    }
    
    func initPipesTimer(){
        var pipesTimer = NSTimer.scheduledTimerWithTimeInterval(2.5, target: self, selector: "loadPipes", userInfo: nil, repeats: true)
    }
    
    func initGame(){
        println("initGame")
        if let scene = GameScene.unarchiveFromFile("GameScene") as? GameScene {
            // Configure the view.
            let skView = self.view as SKView!
            skView.showsFPS = false
            skView.showsNodeCount = false
            skView.showsPhysics = false
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .AspectFill
            
            skView.presentScene(scene)
        }
    }
    
    func initScoreLabel(){
        scoreLabelNode = SKLabelNode(fontNamed: "ChalkboardSE-Bold")
        scoreLabelNode.fontSize = 50
        scoreLabelNode.fontColor = SKColor.whiteColor()
        scoreLabelNode.position = CGPoint(x: CGRectGetMidX(self.frame), y: self.frame.height - 50)
        scoreLabelNode.text = "0"
        scoreLabelNode.zPosition = objectsZPositions.score.rawValue
        
        self.addChild(scoreLabelNode)
    }
    
    func kill(){
        //Remove bird
        bird.removeActionForKey("birdFly")
        self.removeActionForKey("flash")

        //Spin bird out of control
        var radians = CGFloat(M_PI) * bird.position.y * 0.01
        var duration = NSTimeInterval(bird.position.y * 0.003)
        var action  = SKAction.rotateByAngle(radians, duration: duration)
        bird.runAction(action, completion: { () -> Void in
            self.bird.speed = 0
        })
        
        
        //Flash the background Red
        let showFire = SKAction.runBlock({ self.lightbox.color = SKColor.redColor() })
        let showSky  = SKAction.runBlock({ self.lightbox.color = SKColor(red: 113.0/255.0, green: 197.0/255.0, blue: 207.0/255.0, alpha: 1.0) })
        let wait     = SKAction.waitForDuration(0.05)
        let sequence = SKAction.sequence([showFire, wait, showSky, wait])
        
        
        lightbox.actionForKey("flash")
        lightbox.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
        lightbox.size.width = self.frame.width
        lightbox.size.height = self.frame.height
        lightbox.zPosition = objectsZPositions.lightbox.rawValue
        lightbox.alpha = 0.6
        lightbox.runAction(SKAction.repeatAction(sequence, count: 4), completion: { () -> Void in
                self.lightbox.removeFromParent()
        })
        self.addChild(lightbox)
    }
    
    func stopGame(){
        //Stop the Game
        self.physicsWorld.contactDelegate = nil
        
        movingGameObjects.speed = 0
        
        gameOver = true
    }
    
    func addPoint(){
        score += 1
        scoreLabelNode.text = "\(score)"
    }
    
    func announcements(status:String){
        switch(status){
            case "quit":
                //Accounce "Game Over"
                gameOverLabelNode           = SKLabelNode(fontNamed: "Copperplate-Bold")
                gameOverLabelNode.fontSize  = 50
                gameOverLabelNode.fontColor = SKColor.whiteColor()
                gameOverLabelNode.zPosition = objectsZPositions.gameOver.rawValue
                gameOverLabelNode.text      = "Game Over"
                gameOverLabelNode.position  = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
                self.addChild(gameOverLabelNode)
                
                //Animate
                let scaleUp       = SKAction.scaleTo(1.5, duration: 2)
                let scale         = SKAction.scaleTo(1, duration: 0.25)
                let scaleSequence = SKAction.sequence([scaleUp, scale])
                
                //Announce "Tap to Restart"
                gameOverLabelNode.runAction(scaleSequence, completion: { () -> Void in
                    self.gameOverStatusNode           = SKLabelNode(fontNamed: "Copperplate")
                    self.gameOverStatusNode.fontSize  = 30
                    self.gameOverStatusNode.fontColor = SKColor.whiteColor()
                    self.gameOverStatusNode.zPosition = objectsZPositions.gameOver.rawValue
                    self.gameOverStatusNode.text      = "Tap to restart"
                    self.gameOverStatusNode.position  = CGPoint(
                        x: CGRectGetMidX(self.frame),
                        y: CGRectGetMidY(self.frame) - self.gameOverStatusNode.frame.height - 20
                    )
                    
                    self.addChild(self.gameOverStatusNode)
                    //Animate
                    let scaleUp   = SKAction.scaleTo(1.25, duration: 0.5)
                    let scaleBack = SKAction.scaleTo(1, duration: 0.25)
                    let wait      = SKAction.waitForDuration(1.0)
                    let sequence  = SKAction.sequence([wait, scaleUp, scaleBack, wait])
                    let repeat    = SKAction.repeatActionForever(sequence)
                    
                    self.gameOverStatusNode.runAction(repeat)
                })
                break
        default:
            break
        }
    }
    
    /* ** ** ** ** ** ** ** ** ** ** ** **
    
    * ** ** ** ** ** ** ** ** ** ** ** **/
    override func didMoveToView(view: SKView) {
        //Physics World (create a custom gravity)
        modifyGravity()
        
        //A. Add the moving objects
        self.addChild(movingGameObjects)
        //B. Initialize the background animation
        createBackground()
        //C. Create a protagonist
        initProtagonist()
        //D. If the bird falls, the ground will stop it from falling off the screen
        initGround()
        //E. Fire off the first pipe
        loadPipes()
        //F. Set off the pipes timer
        initPipesTimer()
        //G. Score label
        initScoreLabel()
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        if gameOver == false{
            bird.physicsBody?.velocity = CGVectorMake(0, 0)
            bird.physicsBody?.applyImpulse(CGVectorMake(0, 60))
            
            let rotateUp = SKAction.rotateToAngle(0.2, duration: 0)
            bird.runAction(rotateUp)
        }else{
            initGame()
        }
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        //If the bird flies through the gap
        if contact.bodyA.categoryBitMask == openingGroup || contact.bodyB.categoryBitMask == openingGroup{
            addPoint()
        } else if contact.bodyA.categoryBitMask == enemyObjectsGroup || contact.bodyB.categoryBitMask == enemyObjectsGroup{
            kill()
            stopGame()
            announcements("quit")
        }
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        if gameOver == false{
            let rotateDown = SKAction.rotateToAngle(-0.1, duration: 0)
            bird.runAction(rotateDown)
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
    }
}

