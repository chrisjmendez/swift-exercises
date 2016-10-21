//
//  ViewController.swift
//  SoundFont
//
//  Created by Tommy Trojan on 10/19/16.
//  Copyright © 2016 USC Radio Group. All rights reserved.
//

import UIKit
import AudioKit

class ViewController: UIViewController {

    var conductor = Conductor()

    func onLoad(){
        conductor.play(note: 60, velocity: 127, duration: 0)
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
