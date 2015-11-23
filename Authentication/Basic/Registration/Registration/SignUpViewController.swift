//
//  SignUpViewController.swift
//  Registration
//
//  Created by Tommy Trojan on 11/23/15.
//  Copyright © 2015 Chris Mendez. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    
    @IBAction func cancel(sender: AnyObject) {
        //There's nothing you want to do once things are cancelled
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
