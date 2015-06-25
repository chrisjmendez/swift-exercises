//
//  DetailViewController.swift
//  ParseDelta
//
//  Created by tommy trojan on 6/25/15.
//  Copyright (c) 2015 Chris Mendez. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var nameLocal: UITextField!
    @IBOutlet weak var capital: UITextField!
    @IBOutlet weak var currencyCode: UITextField!
    
    //The Parse Object sent from TableView
    var currentObj:PFObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let object = currentObj {
            name.text         = object["nameEnglish"] as! String
            nameLocal.text    = object["nameLocal"] as! String
            capital.text      = object["capital"] as! String
            currencyCode.text = object["currencyCode"] as! String
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
