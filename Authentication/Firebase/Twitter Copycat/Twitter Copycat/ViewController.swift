//
//  ViewController.swift
//  Twitter Copycat
//
//  Created by Chris Mendez 9/23/15.
//  Copyright (c) 2015 Chris Mendez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var SEGUE_LOGIN_REGISTER_COMPLETE = "onLoginAndRegisterSegue"
    
    var db = Firebase(url: Config.db.uri)
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func onLogin(sender: AnyObject) {
        if formIsValid(){
            db.authUser(emailTextField.text, password: passwordTextField.text, withCompletionBlock: { (error, authData) -> Void in
                if error != nil{
                    print(error)
                    print("Please fill in all the input fields")
                } else {
                    print("Login success")
                    
                    //Create an object for a user
                    let userId = authData.uid

                    self.goToView()
                }
            })
        }
    }
    
    @IBAction func onRegister(sender: AnyObject) {
        //A. Validate the form
        if formIsValid() {
            //B. Create a new user in firebase
            db.createUser(emailTextField.text, password: passwordTextField.text, withValueCompletionBlock: { (error, result) -> Void in
                //Validate the user
                if error != nil{
                    let myError = error
                    print( myError )
                } else {
                    print("Success sign up")
                    //C. Once you register a user, you must log them in
                    self.db.authUser(self.emailTextField.text, password: self.passwordTextField.text) { (error, authData) -> Void in
                        //D. Validate the user
                        if error != nil{
                            let myError = error
                            print(myError)
                            print("There is an error with your given information")
                        } else {
                            //E. Prep data for Firebase
                            let usersNode = "users"
                            let userId = authData.uid
                            let newUser = [
                                "provider": authData.provider,
                                //Convert AnyObject -> NSString -> String
                                "email":  authData.providerData["email"] as? NSString as? String
                            ]
                            let fakePost = [
                                "\(NSDate())": "this is my first fake post"
                            ]
                            
                            //F. Create a new User
                            self.db.childByAppendingPath(usersNode).childByAppendingPath(userId).setValue(newUser)
                            //G. Create a post for that User
                            self.db.childByAppendingPath("users/\(userId)/post").setValue(fakePost)
                            
                            //H. Go to Next View
                            self.goToView()
                        }
                    }
                    
                }
            })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(animated: Bool) {
        //A. Check to see if the user is already logged in
        userIsLoggedIn()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func goToView(){
        self.performSegueWithIdentifier(SEGUE_LOGIN_REGISTER_COMPLETE, sender: self)
    }
    
    func userIsLoggedIn(){
        if db.authData != nil{
            print("User already logged in")
            self.goToView()
        } else {
            print("Please log in or register.")
        }
    }

    func formIsValid() -> Bool{
        if emailTextField.text == "" || passwordTextField.text == "" {
            print("Please include email and password")
            return false
        }else{
            
            return true
        }
    }
}

