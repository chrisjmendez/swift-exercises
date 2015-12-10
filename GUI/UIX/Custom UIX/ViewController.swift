//
//  ViewController.swift
//  Custom UIX
//
//  Created by tommy trojan on 4/18/15.
//  Copyright (c) 2015 Chris Mendez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var loaderView: LoaderView!
    
    @IBOutlet weak var loaderLabel: UILabel!
    
    @IBOutlet weak var buyBtn: CustomButtonView!
    @IBAction func onBuyClicked(button: CustomButtonView) {
        
        if button.isAddButton {
            if loaderView.counter < 8 {
                loaderView.counter++
            }
        } else {
            if loaderView.counter > 0 {
                loaderView.counter--
            }
        }
        loaderLabel.text = String(loaderView.counter)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        loaderLabel.text = String(loaderView.counter)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

