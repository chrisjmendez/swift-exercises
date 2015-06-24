//
//  AppLogInViewController.swift
//  CustomLogin
//
//  Created by tommy trojan on 6/23/15.
//  Copyright (c) 2015 Chris Mendez. All rights reserved.
//

import UIKit
import Parse

class AppLogInViewController: PFLogInViewController {

    var textFieldBackground:UIImageView?

    func modifyLogin(){
        //Changebackground of TextFields
        let bgLogIn:UIImage = UIImage(named: "btn_email.png" )!

        //Background
        self.logInView?.backgroundColor = UIColor.whiteColor()
        
        //Login Button
        let loginBtn = UIImage(named: "btn_login.png")
        self.logInView?.logInButton?.setBackgroundImage(loginBtn, forState: UIControlState.Normal)
        
        let loginHighlightBtn = UIImage(named: "btn_login_highlight.png")
        self.logInView?.logInButton?.setBackgroundImage(loginHighlightBtn, forState: UIControlState.Highlighted)
        
        //Login Title
        self.logInView?.logInButton?.setTitle("Custom Login", forState: UIControlState.Normal)
        self.logInView?.logInButton?.titleLabel?.shadowOffset = CGSizeMake(0, 0)
        
        //TextFields
        self.logInView?.usernameField?.textColor = UIColor.orangeColor()
        self.logInView?.usernameField?.placeholder = "My Custom E-mail"
        self.logInView?.usernameField?.layer.shadowOpacity = 0
        
        self.logInView?.passwordField?.textColor = UIColor.orangeColor()
        self.logInView?.passwordField?.placeholder = "My Custom Password"
        self.logInView?.passwordField?.layer.shadowOpacity = 0

        //TextField background
        let bgUserName = UIImage(named: "bg_email.png")
        textFieldBackground = UIImageView(image: bgUserName)
        self.logInView?.addSubview(textFieldBackground!)
        self.logInView?.sendSubviewToBack(textFieldBackground!)
    }
    
    func positionTextFields(){
        var screenHeight = UIScreen.mainScreen().bounds.size.height
        var newSize:Int = (screenHeight <= 480) ? 615 : 270
        textFieldBackground?.frame = CGRect(x: 0, y: newSize, width: 400, height: 48)
    }
    
    
    func modifySignup(){
        self.logInView?.signUpButton?.setTitle("Custom Signup", forState: UIControlState.Normal)
        self.logInView?.signUpButton?.titleLabel?.shadowOffset = CGSizeMake(0, 0)
    }
    
    
    func modifyLogo(){
        let image:UIImage = UIImage(named: "logo_76x76.png")!
        let logo:UIImageView = UIImageView(image: image)
        logo.frame = CGRect(x: 0, y: 0, width: 76, height: 76)
        
        self.logInView?.logo = logo
    }

    
    override func viewDidLoad() {
        modifyLogin()
        modifySignup()
        modifyLogo()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //Position the BG of the text fields
//        positionTextFields()
    }
}
