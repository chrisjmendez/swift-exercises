//
//  ViewController.swift
//  DynamicViewControllers
//
//  Created by Chris on 1/18/16.
//  Copyright © 2016 Chris Mendez. All rights reserved.
//
// Note:
// This example shows two things: 
// 1. How to create view controllers dynamically
// 2. How to override the basic animation and create a custom fade in animator

import UIKit

class ViewController: UIViewController {

    let STORYBOARD = "Main"
    let VIEW_CONTROLLER_IDENTIFIER = "viewController"

    @IBAction func onButton(sender: AnyObject) {
        let recursiveCount = navigationController?.viewControllers.count

        let nextViewController = UIStoryboard(name: STORYBOARD, bundle: nil).instantiateViewControllerWithIdentifier(VIEW_CONTROLLER_IDENTIFIER) as! ViewController
        nextViewController.title = "View # \(recursiveCount!)"

        navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


class FadeInAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.35
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView()
        
        //Animations
        let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)
        let toVC   = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)
        
        //
        containerView?.addSubview((toVC?.view)!)
        
        //Initial state of alpha is 0
        toVC?.view.alpha = 0.0
        
        let duration = transitionDuration(transitionContext)
        UIView.animateWithDuration(duration, animations: { () -> Void in
            toVC?.view.alpha = 1.0
            }) { (finished) -> Void in
                let cancelled = transitionContext.transitionWasCancelled()
                transitionContext.completeTransition(!cancelled)
        }
    }
}

class NavigationControllerDelegate:NSObject, UINavigationControllerDelegate {
    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return FadeInAnimator()
        
    }
    
}
