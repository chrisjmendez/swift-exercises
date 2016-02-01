//
//  DetailViewController.swift
//  ParseDelta
//
//  Created by tommy trojan on 6/25/15.
//  Copyright (c) 2015 Chris Mendez. All rights reserved.
//

import UIKit
import Parse

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
    
    @IBAction func save(sender: AnyObject) {
        
        //If an object already exists, use it
        if let updateObject = currentObj as PFObject?{
            updateObject["nameEnglish"]  = name.text
            updateObject["nameLocal"]    = nameLocal.text
            updateObject["capital"]      = capital.text
            updateObject["currencyCode"] = currencyCode.text
            
            updateObject.saveEventually()
            
        }
        //Create a new Parse object
        else{
            let updateObject = PFObject(className: "Countries")

            updateObject["nameEnglish"]  = name.text
            updateObject["nameLocal"]    = nameLocal.text
            updateObject["capital"]      = capital.text
            updateObject["currencyCode"] = currencyCode.text
            //only the current user can view and edit this record
            updateObject.ACL = PFACL(user: PFUser.currentUser()!)
            
            updateObject.saveEventually()
        }
        //Return to Table View
        self.navigationController?.popViewControllerAnimated(true)
    }
}

