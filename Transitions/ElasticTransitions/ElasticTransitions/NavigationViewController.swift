//
//  NavigationViewController.swift
//  ElasticTransitions
//
//  Created by Chris on 2/14/16.
//  Copyright © 2016 Chris Mendez. All rights reserved.
//

import UIKit

class NavigationViewController: UIViewController {

    
    @IBAction func onClose(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func onButton(sender: AnyObject) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("navigationExample") as! NavigationViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
