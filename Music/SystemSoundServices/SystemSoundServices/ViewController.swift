//
//  ViewController.swift
//  SystemSoundServices
//
//  Created by Tommy Trojan on 1/29/17.
//  Copyright © 2017 Chris Mendez. All rights reserved.
//

import UIKit

import AudioToolbox

class ViewController: UIViewController {

    func main(){
        setup()
    }
    
    func setup(){
        let soundPathURL = Bundle.main.path(forResource: "main/Drums_DrumsMix2_WeGotMoney_72_A", ofType: "wav")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        main()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

