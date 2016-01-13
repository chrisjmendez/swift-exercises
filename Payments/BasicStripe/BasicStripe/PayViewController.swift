//
//  PayViewController.swift
//  Stripe
//
//  Created by Tommy Trojan on 1/13/16.
//  Copyright © 2016 Chris Mendez. All rights reserved.
//

import UIKit

class PayViewController: UIViewController {

    var mainTitle:String = ""
    
    @IBOutlet weak var name: TextField!
    @IBOutlet weak var number: TextField!
    @IBOutlet weak var expiration: TextField!
    @IBOutlet weak var cvv: TextField!
    
    @IBAction func onPay(sender: AnyObject) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        title = mainTitle
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
