//
//  ViewController.swift
//  SaveMyMIDI
//
//  Created by Tommy Trojan on 9/5/16.
//  Copyright © 2016 Chris Mendez. All rights reserved.
//

import UIKit
import MIKMIDI

class ViewController: UIViewController {

    var sequence:MIKMIDISequence?
    
    func onLoad(){
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        onLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
