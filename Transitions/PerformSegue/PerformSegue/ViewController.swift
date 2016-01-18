//
//  ViewController.swift
//  PerformSegue
//
//  Created by Chris on 1/18/16.
//  Copyright © 2016 Chris Mendez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //I do this to keep a record of all my Segues
    let SEGUE_TO_NEXT_VIEW = "toNextViewSegue"
    
    @IBAction func onButton(sender: AnyObject) {
        self.performSegueWithIdentifier(SEGUE_TO_NEXT_VIEW, sender: sender)
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

