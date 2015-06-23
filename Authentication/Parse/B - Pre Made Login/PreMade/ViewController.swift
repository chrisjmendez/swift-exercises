//
//  ViewController.swift
//  PreMade
//
//  Created by tommy trojan on 6/22/15.
//  Copyright (c) 2015 Chris Mendez. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController {

    @IBOutlet weak var statusLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: PFSignUpViewControllerDelegate {
    override func viewDidAppear(animated: Bool) {
        loadBoilerplate()
    }
    
    func loadBoilerplate(){
        
        let currentUser = PFUser.currentUser()
        
        if currentUser == nil {
            //Create Sign Up View Controller
            var signupViewController = PFSignUpViewController()
            signupViewController.delegate = self
            
            //Create Log In View Controller
            var loginViewController = PFLogInViewController()
            loginViewController.delegate = self

            //The Sign Up Controller will be displayed in the Log in View Controller
            loginViewController.signUpController = signupViewController
            
            //If the user is not logged in, they can sign up first
            self.presentViewController(loginViewController, animated: true, completion: nil)
        } else {
           statusLbl.text = "Welcome \(PFUser.currentUser()?.username)"
        }
    }
    
    func signUpViewController(signUpController: PFSignUpViewController, shouldBeginSignUp info: [NSObject : AnyObject]) -> Bool {
        var informationComplete = true

        println(info)
        /*
        for key in info {
            var field:NSString = info[key]
            if( !field || !field.length){
                informationComplete = false
                break
            }
        }
        */
        return true
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