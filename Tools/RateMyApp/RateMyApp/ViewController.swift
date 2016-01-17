//
//  ViewController.swift
//  RateMyApp
//
//  Created by Chris on 1/17/16.
//  Copyright © 2016 Chris Mendez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    func onLoad(){
        
        let rate = RateMyApp.sharedInstance
        rate.appID = "857846130"
        
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            rate.trackAppUsage()
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        onLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

