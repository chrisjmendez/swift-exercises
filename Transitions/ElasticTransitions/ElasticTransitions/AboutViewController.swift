//
//  AboutViewController.swift
//  ElasticTransitions
//
//  Created by Chris on 2/14/16.
//  Copyright © 2016 Chris Mendez. All rights reserved.
//

import UIKit
import ElasticTransition

class AboutViewController: UIViewController {

    struct IDENTIFIERS {
        static let about    = "about"
    }
    
    var transition:ElasticTransition!
    
    var nextViewController:AboutViewController!
    
    let lgr = UIScreenEdgePanGestureRecognizer()
    let rgr = UIScreenEdgePanGestureRecognizer()
    
    @IBAction func onButton(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    func initGestures(){
        view.backgroundColor = getRandomColor()
        
        // gesture recognizer
        //lgr.addTarget(self, action: Selector("handleLeftPan:"))
        lgr.addTarget(self, action: "handleLeftPan:")
        lgr.edges = .Left
        view.addGestureRecognizer(lgr)

        rgr.addTarget(self, action: "handleRightPan:")
        rgr.edges = .Right
        view.addGestureRecognizer(rgr)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initGestures()
    }
    
    func handleLeftPan(pan:UIPanGestureRecognizer){
        if pan.state == .Began{
            transition.dissmissInteractiveTransition(self, gestureRecognizer: pan, completion: nil)
        }else{
            transition.updateInteractiveTransition(gestureRecognizer: pan)
        }
    }
    
    func handleRightPan(pan:UIPanGestureRecognizer){
        if pan.state == .Began{
            nextViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("about") as! AboutViewController
            nextViewController.transition = transition
            nextViewController.transitioningDelegate = transition
            nextViewController.modalPresentationStyle = .Custom
            transition.edge = .Right
            transition.startInteractiveTransition(self, toViewController: nextViewController, gestureRecognizer: pan)
        }else{
            transition.updateInteractiveTransition(gestureRecognizer: pan)
        }
    }
}

func getRandomColor() -> UIColor{
    let randomRed:CGFloat = CGFloat(drand48())
    let randomGreen:CGFloat = CGFloat(drand48())
    let randomBlue:CGFloat = CGFloat(drand48())
    return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
}
