//
//  ViewController.swift
//  NSLayoutAnchor
//
//  Created by Chris on 1/22/16.
//  Copyright © 2016 Chris Mendez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    func onLoad(){
        let thisView = UIView()
        thisView.backgroundColor = UIColor.redColor()
        thisView.translatesAutoresizingMaskIntoConstraints = false
        
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

