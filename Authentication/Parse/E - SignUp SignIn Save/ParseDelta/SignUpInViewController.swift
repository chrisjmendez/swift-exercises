//
//  SignUpInViewController.swift
//  ParseDelta
//
//  Created by tommy trojan on 6/25/15.
//  Copyright (c) 2015 Chris Mendez. All rights reserved.
//

import UIKit
import Parse

class SignUpInViewController: UIViewController {

    @IBOutlet weak var activityMonitor: UIActivityIndicatorView!
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var userEmail: UITextField!
    @IBOutlet weak var userPassword: UITextField!
    
    @IBAction func signUp(sender: AnyObject) {
        let alertController = UIAlertController(title: "Agree to terms and conditions", message: "Click I AGREE to signal that you agree to the End User Licence Agreement.", preferredStyle: UIAlertControllerStyle.Alert)
        
        alertController.addAction(UIAlertAction(title: "I AGREE", style: UIAlertActionStyle.Default, handler: { alertController in self.processSignUp() }))
        
        alertController.addAction(UIAlertAction(title: "I do NOT agree", style: UIAlertActionStyle.Default, handler: nil))
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    @IBAction func logIn(sender: AnyObject) {
        showActivityMonitor()
        
        let userEmail = self.userEmail.text
        var userPass  = self.userPassword.text
            userPass = userPass!.lowercaseString
        
        loginUser(userEmail!, userPass: userPass!)
    }
    
    func processSignUp(){
        showActivityMonitor()
        
        let userEmail = self.userEmail.text
        var userPass  = self.userPassword.text
            userPass = userPass!.lowercaseString
        

        createUser(userEmail!, userPass: userPass!)
    }
    
    func hideActivityMonitor(){
        activityMonitor.hidden = true
        activityMonitor.hidesWhenStopped = true
    }
    
    func showActivityMonitor(){
        activityMonitor.hidden = false
        activityMonitor.startAnimating()
    }

    func loginUser(userEmail:String, userPass:String){
        PFUser.logInWithUsernameInBackground(userEmail, password: userPass){
            (user:PFUser?, error:NSError?) -> Void in
            if user != nil{
                dispatch_async(dispatch_get_main_queue()){
                    self.performSegueWithIdentifier("signInToNavigation", sender: self)
                }
            }else{
                self.hideActivityMonitor()
                
                if let message:AnyObject = error!.userInfo["error"]{
                    self.message.text = "\(message)"
                }
            }
        }
    }
    
    func createUser(userEmail:String, userPass:String){
        var user = PFUser()
        user.username = userEmail
        user.password = userPass
        user.email    = userEmail
        
        user.signUpInBackgroundWithBlock({(succeed:Bool, error:NSError?) -> Void in
            if error == nil {
                dispatch_async(dispatch_get_main_queue(), {
                    self.performSegueWithIdentifier("signInToNavigation", sender: self)
                })
            }else{
                self.hideActivityMonitor()
                
                if let message:AnyObject = error!.userInfo["error"]{
                    self.message.text = "\(message)"
                }
            }
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        hideActivityMonitor()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
