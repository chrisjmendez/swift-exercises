//
//  ViewController.swift
//  Razzle
//
//  Created by Chris on 1/20/16.
//  Copyright © 2016 Chris Mendez. All rights reserved.
//

import UIKit
import RazzleDazzle

class ViewController:AnimatedPagingScrollViewController {

    let NUMBER_OF_PAGES = 4

    let shapeBlue   = UIImageView(image: UIImage(named: "Intro-shape-blue"))
    let shapeOrange = UIImageView(image: UIImage(named: "Intro-shape-orange"))
    let shapeYellow = UIImageView(image: UIImage(named: "Intro-shape-yellow"))
    let shapeStar   = UIImageView(image: UIImage(named: "Intro-shape-star"))
    let shapeSun    = UIImageView(image: UIImage(named: "Intro-shape-sun"))
    
    let objectPathView = UIView()
    
    var objectPlaneLayer = CAShapeLayer()
    var objectFlyingAnimation:PathPositionAnimation?

    override func viewDidLoad() {
        super.viewDidLoad()

        //Hide the status bar
        UIApplication.sharedApplication().setStatusBarHidden(true, withAnimation: .Fade)
        self.view.backgroundColor = UIColor.redColor()
        
        configureViews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ViewController {
    func configureViews(){
        configureShapeBlue()
        configureShapeYellow()
    }
    
    func configureShapeBlue(){
        let item = shapeBlue
            item.translatesAutoresizingMaskIntoConstraints = false
        let toItem = scrollView//.layoutMarginsGuide
        
        contentView.addSubview(item)

        let leading = NSLayoutConstraint(item: item, attribute: .Leading, relatedBy: .Equal, toItem: toItem, attribute: .Leading, multiplier: 1, constant: (item.frame.width * -0.5))
        let width   = item.widthAnchor.constraintEqualToAnchor(nil, constant: item.frame.width)
        let height  = item.heightAnchor.constraintLessThanOrEqualToAnchor(nil, constant: item.frame.height)
        let centerY = item.centerYAnchor.constraintEqualToAnchor(toItem.centerYAnchor)
        
        NSLayoutConstraint.activateConstraints([leading, width, height, centerY])
    }
    
    func configureShapeYellow(){
        let item   = shapeYellow
            item.translatesAutoresizingMaskIntoConstraints = false
        let toItem = scrollView

        contentView.addSubview(item)
        
        let leading = item.leadingAnchor.constraintEqualToAnchor(toItem.leadingAnchor, constant: (view.frame.width + (item.frame.width * -0.5)))
        let trail   = item.trailingAnchor.constraintEqualToAnchor(toItem.trailingAnchor, constant: 0)
        let width   = item.widthAnchor.constraintEqualToAnchor(nil, constant: item.frame.width)
        let height  = item.heightAnchor.constraintLessThanOrEqualToAnchor(nil, constant: item.frame.height)
        let centerY = item.centerYAnchor.constraintEqualToAnchor(item.centerYAnchor)
        
        NSLayoutConstraint.activateConstraints([leading, width, height, centerY])
    }
    
    func configureStar(){
        let thisObject = shapeStar
        let destination = scrollView
        
        //Scroll View
        let w = NSLayoutConstraint(item: thisObject, attribute: .Width, relatedBy: .LessThanOrEqual, toItem: destination, attribute: .Width, multiplier: 1.3, constant: 0)
        //scrollView.addConstraint(w)
        let h = NSLayoutConstraint(item: thisObject, attribute: .Height, relatedBy: .LessThanOrEqual, toItem: destination, attribute: .Height, multiplier: 1, constant: 0)
        //scrollView.addConstraint(h)
        let t = NSLayoutConstraint(item: thisObject, attribute: .Top, relatedBy: .GreaterThanOrEqual, toItem: destination, attribute: .Top, multiplier: 1, constant: 30)
        //scrollView.addConstraint(t)
        let c = NSLayoutConstraint(item: thisObject, attribute: .CenterY, relatedBy: .Equal, toItem: destination, attribute: .CenterY, multiplier: 1, constant: 0)
        //scrollView.addConstraint(c)
        
        //Star
        let s = NSLayoutConstraint(item: thisObject, attribute: .Height, relatedBy: NSLayoutRelation.Equal, toItem: thisObject, attribute: .Width, multiplier: 1, constant: 0)
        
//        scrollView.addConstraint(s)
        
        /*
        v.addConstraints([
        NSLayoutConstraint(item: backgroundViewForImage, attribute: .Width, relatedBy: .Equal, toItem: v, attribute: .Width, multiplier: 1.0, constant: -60),
        NSLayoutConstraint(item: backgroundViewForImage, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 130),
        NSLayoutConstraint(item: backgroundViewForImage, attribute: .Left, relatedBy: .Equal, toItem: v, attribute: .Left, multiplier: 1.0, constant: 40),
        NSLayoutConstraint(item: backgroundViewForImage, attribute: .Top, relatedBy: .Equal, toItem: v, attribute: .Top, multiplier: 1.0, constant: 0)
        ])

        */
        
        
        keepView(shapeStar, onPages: [0,1])
        
        // Scale up the star to 7 times its original size between pages 0 and 1, with a quadratic Ease In easing function
        let starScaleAnimation = ScaleAnimation(view: thisObject)
            starScaleAnimation.addKeyframe(0, value: 1, easing: EasingFunctionEaseInQuad)
            starScaleAnimation[1] = 10

        animator.addAnimation(starScaleAnimation)
        
        // Hide the star when we get to page 1
        let starHideAnimation = HideAnimation(view: thisObject, hideAt: 1)
        animator.addAnimation(starHideAnimation)

    }
    
    func scaleObjectPathToSize(){
        
    }
    
    override func numberOfPages() -> Int {
        return NUMBER_OF_PAGES
    }
}