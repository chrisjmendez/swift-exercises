//
//  ViewController.swift
//  Singleton
//
//  Created by Chris on 1/22/16.
//  Copyright © 2016 Chris Mendez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        MySingleton.sharedInstance.addPoint(1)
        MySingleton.sharedInstance.addPoint(10)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

