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
    
    override func viewWillAppear(animated: Bool) {

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        onLoad()
        configureViews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ViewController {
    func onLoad(){
        //Hide the status bar
        UIApplication.sharedApplication().setStatusBarHidden(true, withAnimation: .Fade)
    }
    
    func configureViews(){
        //contentView.addSubview(shapeBlue)
        //contentView.addSubview(shapeOrange)
        //contentView.addSubview(shapeYellow)
        
        contentView.addSubview(shapeStar)
        configureStar()
        
        //contentView.addSubview(shapeSun)
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
        
        scrollView.addConstraint(s)
        
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