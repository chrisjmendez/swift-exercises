//
//  ViewController.swift
//  Presentation
//
//  Created by Chris on 2/19/16.
//  Copyright © 2016 Chris Mendez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.performSegueWithIdentifier("onLoadSegue", sender: self)
    }
}

