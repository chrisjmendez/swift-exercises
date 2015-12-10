//
//  AppSignUpViewController.swift
//  CustomLogin
//
//  Created by tommy trojan on 6/23/15.
//  Copyright (c) 2015 Chris Mendez. All rights reserved.
//

import UIKit
import Parse

class AppSignUpViewController: PFSignUpViewController {
   
    func modifyView(){
        let image:UIImage = UIImage(named: "logo_256x256.png")!
        let logo:UIImageView = UIImageView(image: image)
        //logo.frame = CGRect(x: 0, y: 0, width: 256, height: 256)
        self.signUpView?.logo = logo
    }

    func modifyTextFields(){
        self.signUpView?.emailAsUsername = true
        self.signUpView?.usernameField?.placeholder   = "My Email"
        self.signUpView?.passwordField?.placeholder   = "My Password"
        self.signUpView?.additionalField?.placeholder = "My Confirm Password"
        self.signUpView?.additionalField?.secureTextEntry = true
    }
    
    override func viewDidLoad() {
        modifyView()
        modifyTextFields()
        
        self.signUpView?.signUpButton?.enabled = true
        self.signUpView?.dismissButton?.enabled = true
    }
    
    override func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        if textField == self.signUpView?.usernameField{
            self.signUpView?.emailField?.text = textField.text
        }
        return true
    }
}

