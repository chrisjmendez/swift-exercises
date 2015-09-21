//
//  ViewController.swift
//  FirebaseSimple
//
//  Created by Tommy Trojan on 9/21/15.
//  Copyright (c) 2015 Chris Mendez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var db = Firebase(url: "https://swift-example.firebaseio.com/")
    var message = "WE JUST CHANGED THE VALUE"
    
    @IBOutlet weak var dataLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Pull the value from Firebase using the Observer Pattern
        db.observeEventType(.Value, withBlock: {
            //Get the Snapshot of the code and print a value
            snapshot in
            self.dataLabel.text = snapshot.value as? String
        })
        
        //Write to Firebase
//        db.setValue(message)
        
        // ////////////////////////////////
        //Example 2
        // ////////////////////////////////
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

