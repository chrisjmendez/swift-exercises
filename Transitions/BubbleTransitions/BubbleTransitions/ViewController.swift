//
//  ViewController.swift
//  BubbleTransitions
//
//  Created by Chris on 1/18/16.
//  Copyright © 2016 Chris Mendez. All rights reserved.
//

import UIKit
import BubbleTransition

class ViewController: UIViewController {

    let SEGUE_START = "toMainSegue"
    
    let transition = BubbleTransition()
    
    @IBOutlet weak var starButton: UIButton!
    @IBAction func onStart(sender: AnyObject) {
        self.performSegueWithIdentifier(SEGUE_START, sender: sender)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        //This triggers the delegate to animate
        let controller = segue.destinationViewController
            controller.transitioningDelegate = self
            controller.modalPresentationStyle = .Custom
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

extension ViewController:UIViewControllerTransitioningDelegate{
    // MARK: UIViewControllerTransitioningDelegate
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {

        //.Pop, .Present, .Dismiss
        transition.transitionMode = .Present
        transition.startingPoint = starButton.center
        transition.bubbleColor = starButton.backgroundColor!
        
        return transition
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        transition.transitionMode = .Dismiss
        transition.startingPoint = starButton.center
        transition.bubbleColor = starButton.backgroundColor!
        
        return transition
    }
}