//
//  ViewController.swift
//  FirebaseSimple
//
//  Created by Tommy Trojan on 9/21/15.
//  Copyright (c) 2015 Chris Mendez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var ref = Firebase(url: Config.db.firebase)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newClient = "USC Radio Network"
        let subsidary = ["Classical KUSC", "Classical KDFC"]
        
        ref.childByAppendingPath(newClient).setValue(newClient)
        ref.childByAppendingPath(newClient).childByAppendingPath(subsidary[0]).setValue("Los Angeles")
        ref.childByAppendingPath(newClient).childByAppendingPath(subsidary[1]).setValue("San Francisco")
        
        //Pull the value from Firebase using the Observer Pattern
        ref.observeEventType(.Value, withBlock: {
            //Get the Snapshot of the code and print a value
            snapshot in
            let value = snapshot.value.objectForKey(newClient)
            print("Change:",value)
        })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

