//
//  ViewController.swift
//  Speedometer
//
//  Created by Tommy Trojan on 1/2/16.
//  Copyright © 2016 Chris Mendez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var gague: Gague!
    
    @IBOutlet weak var countLabel: UILabel!
    
    @IBAction func onButtonTapped(sender: AnyObject) {
        let button = sender as? UIButton
        
        if button.isAddButton {
            if gague.counter < 8 {
                gague.counter++
            }
        } else {
            if gague.counter > 0 {
                gague.counter--
            }
        }
        countLabel.text = String(gague.counter)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

