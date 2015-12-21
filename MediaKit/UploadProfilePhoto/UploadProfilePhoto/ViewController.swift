//
//  ViewController.swift
//  UploadProfilePhoto
//
//  Created by Tommy Trojan on 12/21/15.
//  Copyright © 2015 Chris Mendez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let SEGUE_ON_LOAD = "onLoadSegue"
    
    func goToView(){
        self.performSegueWithIdentifier(SEGUE_ON_LOAD, sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Programatically trigger a function call after x seconds
        self.performSelector("goToView", withObject: nil, afterDelay: 1.0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

