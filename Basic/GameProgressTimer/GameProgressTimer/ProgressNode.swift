//
//  ProgressNode.swift
//  SpriteKit extension
//
//  Created by Tibor Bodecs on 06/02/15.
//  Copyright (c) 2015 Tibor Bodecs. All rights reserved.
//

import SpriteKit



public class ProgressNode : SKShapeNode
{
    ///////////////////////////////////////////////////////////////////////////////////////////////////
    //  MARK: constants
    ///////////////////////////////////////////////////////////////////////////////////////////////////

    struct Constants {
        static let radius : CGFloat          = 32
        static let color : SKColor           = SKColor.darkGrayColor()
        static let backgroundColor : SKColor = SKColor.lightGrayColor()
        static let width : CGFloat           = 2.0
        static let progress : CGFloat        = 0.0
        static let startAngle : CGFloat      = CGFloat(M_PI_2)
        static private let actionKey         = "_progressNodeCountdownActionKey"
    }
    
    ///////////////////////////////////////////////////////////////////////////////////////////////////
    //  MARK: properties
    ///////////////////////////////////////////////////////////////////////////////////////////////////

    /// the radius of the progress node
    public var radius: CGFloat = ProgressNode.Constants.radius {
        didSet {
            self.updateProgress(node: self.timeNode, progress: self.progress)
            self.updateProgress(node: self)
        }
    }
    
    //the active time color
    public var color: SKColor = ProgressNode.Constants.color {
        didSet {
            self.timeNode.strokeColor = self.color
        }
    }

    //the background color of the timer (to hide: use clear color)
    public var backgroundColor: SKColor = ProgressNode.Constants.backgroundColor {
        didSet {
            self.strokeColor = self.backgroundColor
        }
    }
    
    ///the line width of the progress node
    public var width: CGFloat = ProgressNode.Constants.width {
        didSet {
            self.timeNode.lineWidth = self.width
            self.lineWidth          = self.width
        }
    }
    
    //the current progress of the progress node end progress is 1.0 and start is 0.0
    public var progress: CGFloat = ProgressNode.Constants.progress {
        didSet {
            self.updateProgress(node: self.timeNode, progress: self.progress)
        }
    }

    // the start angle of the progress node
    public var startAngle: CGFloat = ProgressNode.Constants.startAngle {
        didSet {
            self.updateProgress(node: self.timeNode, progress: self.progress)
        }
    }
    
    private let timeNode = SKShapeNode()

    ///////////////////////////////////////////////////////////////////////////////////////////////////
    //  MARK: init
    ///////////////////////////////////////////////////////////////////////////////////////////////////

    public init(radius: CGFloat,
        color: SKColor = ProgressNode.Constants.color,
        backgroundColor: SKColor = ProgressNode.Constants.backgroundColor,
        width: CGFloat = ProgressNode.Constants.width,
        progress: CGFloat = ProgressNode.Constants.progress) {
            
            self.radius          = radius
            self.color           = color
            self.backgroundColor = backgroundColor
            self.width           = width
            self.progress        = progress

            super.init()

            self._init()
    }

    override init() {
        super.init()

        self._init()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self._init()
    }
    

    ///////////////////////////////////////////////////////////////////////////////////////////////////
    //  MARK: helpers
    ///////////////////////////////////////////////////////////////////////////////////////////////////

    private func _init() {
        self.timeNode.lineWidth   = self.width
        self.timeNode.strokeColor = self.color
        self.timeNode.zPosition   = 10
        self.timeNode.position    = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
        
        self.addChild(self.timeNode)
        self.updateProgress(node: self.timeNode, progress: self.progress)
        
        self.lineWidth   = self.width
        self.strokeColor = self.backgroundColor
        self.zPosition   = self.timeNode.zPosition
        
        self.updateProgress(node: self)
    }
 
    private func updateProgress(node node: SKShapeNode, progress: CGFloat = 0.0) {
        let progress   = 1.0 - progress
        let startAngle = CGFloat(M_PI / 2.0)
        let endAngle   = self.startAngle + progress*CGFloat(2.0*M_PI)
        node.path      = UIBezierPath(arcCenter: CGPointZero,
            radius: self.radius,
            startAngle: self.startAngle,
            endAngle: endAngle,
            clockwise: true).CGPath
    }
    
    ///////////////////////////////////////////////////////////////////////////////////////////////////
    //  MARK: API
    ///////////////////////////////////////////////////////////////////////////////////////////////////

    /*!
    The countdown method counts down from a time interval to zero, 
    and it calls a callback on the main thread if its finished
    
    :param: time     The time interval to count
    :param: progressHandler   An optional callback method (always called on main thread)
    :param: callback An optional callback method (always called on main thread)
    */
    public func countdown(time: NSTimeInterval = 1.0, completionHandler: ((Void) -> Void)?) {
        self.countdown(time, progressHandler: nil, completionHandler: completionHandler)
    }
    
    public func countdown(time: NSTimeInterval = 1.0, progressHandler: ((Void) -> Void)?, completionHandler: ((Void) -> Void)?) {
        self.stopCountdown()
        
        self.runAction(SKAction.customActionWithDuration(time, actionBlock: {(node: SKNode!, elapsedTime: CGFloat) -> Void in
            self.progress = elapsedTime / CGFloat(time)
            
            if let cb = progressHandler {
                dispatch_async(dispatch_get_main_queue(), {
                    cb()
                })
            }
            
            if self.progress == 1.0 {
                if let cb = completionHandler {
                    dispatch_async(dispatch_get_main_queue(), {
                        cb()
                    })
                }
            }
        }), withKey:ProgressNode.Constants.actionKey)
    }
    
    public func stopCountdown() {
        self.removeActionForKey(ProgressNode.Constants.actionKey)
    }
}