//
//  ViewController.swift
//  ElasticTransitions
//
//  Created by Chris on 1/18/16.
//  Copyright © 2016 Chris Mendez. All rights reserved.
//

import UIKit
import ElasticTransition

class ViewController: UIViewController {
    
    struct SEGUE {
        static let about    = "aboutSegue"
        static let settings = "settingSegue"
        static let main     = "mainSegue"
        static let navigation = "navigationSegue"
    }
    
    var transition = ElasticTransition()
    
    let lgr = UIScreenEdgePanGestureRecognizer()
    let rgr = UIScreenEdgePanGestureRecognizer()

    @IBAction func onAbout(sender: AnyObject) {
        performSegueWithIdentifier(SEGUE.about, sender: self)
    }
    
    func initGestures(){
        // customization
        transition.sticky = true
        transition.showShadow = true
        transition.panThreshold = 0.3
        transition.transformType = .TranslateMid
        
        //    transition.overlayColor = UIColor(white: 0, alpha: 0.5)
        //    transition.shadowColor = UIColor(white: 0, alpha: 0.5)
        
        // gesture recognizer
        lgr.addTarget(self, action: "handlePan:")
        lgr.edges = .Left
        view.addGestureRecognizer(lgr)

        rgr.addTarget(self, action: "handleRightPan:")
        rgr.edges = .Right
        view.addGestureRecognizer(rgr)
    }
    
    func handlePan(pan:UIPanGestureRecognizer){
        if pan.state == .Began{
            transition.edge = .Left
            transition.startInteractiveTransition(self, segueIdentifier: SEGUE.main, gestureRecognizer: pan)
        }else{
            transition.updateInteractiveTransition(gestureRecognizer: pan)
        }
    }
    
    func handleRightPan(pan:UIPanGestureRecognizer){
        if pan.state == .Began{
            transition.edge = .Right
            transition.startInteractiveTransition(self, segueIdentifier: SEGUE.about, gestureRecognizer: pan)
        }else{
            transition.updateInteractiveTransition(gestureRecognizer: pan)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initGestures()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let vc = segue.destinationViewController
            vc.transitioningDelegate = transition
            vc.modalPresentationStyle = .Custom
        
        if segue.identifier == SEGUE.navigation {
            if let vc = vc as? UINavigationController{
                vc.delegate = transition
            }
        } else {
            if let vc = vc as? AboutViewController{
                vc.transition = transition
            }
        }
    }
}
