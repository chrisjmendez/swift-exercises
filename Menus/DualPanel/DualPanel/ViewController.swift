//
//  ViewController.swift
//  DualPanel
//
//  Created by Tommy Trojan on 12/19/15.
//  Copyright © 2015 Chris Mendez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    func onLoad(){
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        Simulator().runSimulatorWithMinTime(1, maxTime: 2)
            appDelegate.initNavigationDrawer()
    }
    
    override func viewDidAppear(animated: Bool) {
        onLoad()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("Welcome to the Sign In Page")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

