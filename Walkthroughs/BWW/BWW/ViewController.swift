//
//  ViewController.swift
//  BWW
//
//  Created by Chris Mendez on 2/23/16.
//  Copyright © 2016 Chris Mendez. All rights reserved.
//

import UIKit
import BWWalkthrough

class ViewController: UIViewController {

    @IBAction func onWalkthrough(sender: AnyObject) {
        showWalkthrough()
    }
    
    func showWalkthrough(){

        let stb = UIStoryboard(name: "Main", bundle: nil)
        
        let p0 = stb.instantiateViewControllerWithIdentifier("walk00") as UIViewController
        let p1 = stb.instantiateViewControllerWithIdentifier("walk01") as UIViewController
        let p2 = stb.instantiateViewControllerWithIdentifier("walk02") as UIViewController
        
        let walkthrough = stb.instantiateViewControllerWithIdentifier("walkthrough") as! BWWalkthroughViewController
        
        walkthrough.delegate = self
        walkthrough.addViewController(p0)
        walkthrough.addViewController(p1)
        walkthrough.addViewController(p2)
        
        presentViewController(walkthrough, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension ViewController:BWWalkthroughViewControllerDelegate {
    
}

