//
//  ViewController.swift
//  CustomLogin
//
//  Created by tommy trojan on 6/23/15.
//  Copyright (c) 2015 Chris Mendez. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController {
    
    @IBOutlet weak var statusLbl: UILabel!

    func initViewControllers(){
        let currentUser = PFUser.currentUser()
        
        if currentUser == nil {
            //Create Sign Up View Controller
            var signupViewController = AppSignUpViewController()
            signupViewController.delegate = self
            signupViewController.fields = PFSignUpFields.UsernameAndPassword|PFSignUpFields.SignUpButton|PFSignUpFields.Email|PFSignUpFields.Additional|PFSignUpFields.DismissButton
            
            //Create Log In View Controller
            var loginViewController = PFLogInViewController()
            loginViewController.delegate = self
            
            loginViewController.fields = PFLogInFields.UsernameAndPassword|PFLogInFields.SignUpButton|PFLogInFields.PasswordForgotten|PFLogInFields.LogInButton|PFLogInFields.DismissButton|PFLogInFields.Facebook
            
            //The Sign Up Controller will be displayed in the Log in View Controller
            loginViewController.signUpController = signupViewController
            
            //If the user is not logged in, they can sign up first
            self.presentViewController(loginViewController, animated: true, completion: nil)
        } else {
            statusLbl.text = "Welcome \(PFUser.currentUser()?.username)"
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(animated: Bool) {
        initViewControllers()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

/* ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** **
Sign Up
* ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** **/
extension ViewController: PFSignUpViewControllerDelegate {
    
    func signUpViewController(signUpController: PFSignUpViewController, shouldBeginSignUp info: [NSObject : AnyObject]) -> Bool {
        
        var informationComplete = true
        
        if let p1:String = info["password"] as? String{
           println(p1)
        }
        if let p2:String = info["additional"] as? String{
            println(p2)
        }
        
        return true
        
        for value in info{
            var field: AnyObject? = value.1 as AnyObject
            
            if (field == nil || field?.length == 0) {
                informationComplete = false
                break
            }
        }
        
        if(!informationComplete){
            print("Information is missing")
        }else{
//            info.updateValue("", forKey: "additional")
        }
        
        return informationComplete
    }
    
    
    func signUpViewController(signUpController: PFSignUpViewController, didSignUpUser user: PFUser) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func signUpViewController(signUpController: PFSignUpViewController, didFailToSignUpWithError error: NSError?) {
        println("Failed to sign up ")
    }
    
    func signUpViewControllerDidCancelSignUp(signUpController: PFSignUpViewController) {
        println("User dismissed the signupViewController")
    }
}

/* ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** **
Log In
* ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** **/
extension ViewController: PFLogInViewControllerDelegate{
    
    func logInViewController(logInController: PFLogInViewController, shouldBeginLogInWithUsername username: String, password: String) -> Bool {
        if String(username) != nil && String(password) != nil && count(username) > 0  && count(password) > 0 {
            return true
        }
        println("Missing information")
        return false
    }
    
    func logInViewController(logInController: PFLogInViewController, didLogInUser user: PFUser) {
        self.dismissViewControllerAnimated(true, completion: nil)
        print("User has logged in")
    }
    
    func logInViewController(logInController: PFLogInViewController, didFailToLogInWithError error: NSError?) {
        println("Failed to Log in")
    }
    
    func logInViewControllerDidCancelLogIn(logInController: PFLogInViewController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}