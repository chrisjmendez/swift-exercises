//
//  MainViewController.swift
//  FBAuth
//
//  Created by Tommy Trojan on 12/10/15.
//  Copyright © 2015 Chris Mendez. All rights reserved.
//

import UIKit
import Firebase

class MainViewController: UIViewController {

    var user:FAuthData!
    var ref:Firebase!
    var sender:String = ""

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
