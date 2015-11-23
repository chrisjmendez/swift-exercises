//
//  SignUpViewController.swift
//  Registration
//
//  Created by Tommy Trojan on 11/23/15.
//  Copyright © 2015 Chris Mendez. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var password2TextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var zipCodeTextField: UITextField!
    
    @IBAction func signUp(sender: AnyObject) {
        let userEmail = emailTextField.text
        let password  = passwordTextField.text
        let password2 = password2TextField.text
        let firstName = firstNameTextField.text
        let lastName  = lastNameTextField.text
        let zipCode   = zipCodeTextField.text
        
        if(password != password2){
            displayAlertMessage("Passwords do not match")
            return
        }
        
        if(userEmail != nil || password != nil || firstName != nil || lastName != nil || zipCode != nil){
            displayAlertMessage("All fields are required.")
            return
        }
    }
    
    @IBAction func cancel(sender: AnyObject) {
        //There's nothing you want to do once things are cancelled
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // ///////////////////////////////////////
    // Alert
    // ///////////////////////////////////////
    func displayAlertMessage(userMessage:String){
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
        let myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.Alert)
            myAlert.addAction(okAction)
        
        self.presentViewController(myAlert, animated: true, completion: nil)
    }
    
    // ///////////////////////////////////////
    // On Load
    // ///////////////////////////////////////
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
