//
//  AddTableViewController.swift
//  Twitter Copycat
//
//  Created by Tommy Trojan on 9/25/15.
//  Copyright (c) 2015 Chris Mendez. All rights reserved.
//

import UIKit

class AddTableViewController: UITableViewController {
    
    let SEGUE_POST_COMPLETE = "onPostCompleteSegue"
    
    var db = Firebase(url: Config.db.uri)
    
    //Firebase Nodes
    let TOP_LEVEL_NODE  = "Posts"
    let USERS_NODE      = "users"
    let USERS_POST_NODE = "posts"

    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    @IBOutlet weak var messageTextField: UITextField!

    @IBAction func onDone(sender: AnyObject) {
        //A. Create a reliable post by asking Firebase to create an auto id
        db.childByAppendingPath(TOP_LEVEL_NODE).childByAutoId().setValue(messageTextField.text)
        
        //B. Post the text to the "posts" subclass of the user database
        db.childByAppendingPath(USERS_NODE + "/\(db.authData.uid)/" + USERS_POST_NODE).childByAutoId().setValue(messageTextField.text)
        //C. Return to previous view
        self.performSegueWithIdentifier(SEGUE_POST_COMPLETE, sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideBackButton()
        
        loadValidator()
    }
    
    func loadValidator(){
        NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: Selector("validateForm"), userInfo: nil, repeats: true)
    }
    
    func validateForm(){
        if messageTextField.text == "" {
            doneButton.enabled = false
        } else if messageTextField.text != nil{
            doneButton.enabled = true
        }
    }
    
    //Remove back button
    func hideBackButton(){
        self.navigationItem.hidesBackButton = true;
    }
    
}
