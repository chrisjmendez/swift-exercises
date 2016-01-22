//
//  ViewController.swift
//  BasicLayoutConstraint
//
//  Created by Chris on 1/22/16.
//  Copyright © 2016 Chris Mendez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    func onLoad(){
        let subView = UIView()
        subView.translatesAutoresizingMaskIntoConstraints = false
        subView.backgroundColor = UIColor.greenColor()
        self.view.addSubview(subView)

        let leading = NSLayoutConstraint(item: subView, attribute: .Leading, relatedBy: .Equal, toItem: view, attribute: .Leading, multiplier: 1, constant: 0)
        
        let trailing = NSLayoutConstraint(item: subView, attribute: .Trailing, relatedBy: .Equal, toItem: view, attribute: .TrailingMargin, multiplier: 1, constant: 0)

        let top = NSLayoutConstraint(item: subView, attribute: .Top, relatedBy: .Equal, toItem: topLayoutGuide, attribute: .Bottom, multiplier: 1, constant: 0)

        let bottom = NSLayoutConstraint(item: subView, attribute: .Bottom, relatedBy: .Equal, toItem: bottomLayoutGuide, attribute: .BottomMargin, multiplier: 1, constant: 0)
        
        NSLayoutConstraint.activateConstraints([leading, trailing, top, bottom])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        onLoad()
        
        self.view.backgroundColor = UIColor.redColor()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

