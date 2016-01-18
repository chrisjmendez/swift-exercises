//
//  MainViewController.swift
//  BubbleTransitions
//
//  Created by Chris on 1/18/16.
//  Copyright © 2016 Chris Mendez. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var closeButton: UIButton!
    
    @IBAction func onClose(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        closeButton.transform =  CGAffineTransformMakeRotation(CGFloat(M_PI_4))

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
