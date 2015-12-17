//
//  MainViewController.swift
//  TwitterAuth
//
//  Created by Tommy Trojan on 12/9/15.
//  Copyright © 2015 Chris Mendez. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    var user:FAuthData!
    var ref:Firebase!
    var sender:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
