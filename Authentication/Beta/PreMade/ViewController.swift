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

extension ViewController: PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate {
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
}