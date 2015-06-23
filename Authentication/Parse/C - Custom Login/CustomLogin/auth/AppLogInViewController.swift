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
    
    override func viewDidLoad() {
        let image:UIImage = UIImage(named: "logo_1500x1500.jpg")!
        let logo:UIImageView = UIImageView(image: image)
        logo.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        
        self.logInView?.backgroundColor = UIColor.whiteColor()
        self.logInView?.logo = logo
        
        //self.logInView?.logInButton?.setBackgroundImage("buttonLoginBackground", forState: UIControlState.Normal)
        //self.logInView?.logInButton?.setBackgroundImage("buttonLoginBackground", forState: UIControlState.Highlighted)
        
        
        //TextFields
        self.logInView?.usernameField?.textColor = UIColor.orangeColor()
        self.logInView?.passwordField?.textColor = UIColor.orangeColor()
        
        //Placeholder Text
        self.logInView?.usernameField?.placeholder = "My Primary E-mail"
        
        //Changebackground of TextFields
        let bgLogIn:UIImage = UIImage(named: "btn_email.png" )!
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        var screenHeight:Float = Float(UIScreen.mainScreen().bounds.size.height)
//        var newSize = 480.0 ? 115.0 : 200.0
//        var inputFieldY = screenHeight <= newSize
    }
}
