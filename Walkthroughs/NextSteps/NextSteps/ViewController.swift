//
//  ViewController.swift
//  NextSteps
//
//  Created by Chris Mendez on 2/23/16.
//  Copyright © 2016 Chris Mendez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let SEGUE_TUTORIAL = "tutorialSegue"
    
    @IBAction func onTutorial(sender: AnyObject) {
//        self.performSegueWithIdentifier(SEGUE_TUTORIAL, sender: self)
        
        /*
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        let viewController = mainStoryboard.instantiateViewControllerWithIdentifier("tutorialViewController") as! UIViewController
        UIApplication.sharedApplication().keyWindow?.rootViewController = viewController;
        */
        
        
        self.storyboard?.instantiateViewControllerWithIdentifier("tutorialViewController") as! UIViewController
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

