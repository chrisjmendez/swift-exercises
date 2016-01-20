//
//  ViewController.swift
//  HorizontalVerticalMenu
//
//  Created by Chris on 1/18/16.
//  Copyright © 2016 Chris Mendez. All rights reserved.
//

import UIKit

class ViewController:UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.performSegueWithIdentifier("onTableSegue", sender: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}