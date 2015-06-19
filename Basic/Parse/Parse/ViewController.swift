//
//  ViewController.swift
//  Parse
//
//  Created by tommy trojan on 6/18/15.
//  Copyright (c) 2015 Chris Mendez. All rights reserved.
//

import UIKit
import Parse

class AppUser{
    var user: String!
    var pass: String!
    var email: String!
    var phone: String?
    
    init(user:String, pass:String, email:String, phone:String){
        self.user = user
        self.pass = pass
        self.email = email
        self.phone = phone
    }
}


class ViewController: UIViewController {

    @IBOutlet weak var messageTxt: UILabel!
    
    @IBOutlet weak var usernameTxt: UITextField!
    
    @IBOutlet weak var passwordTxt: UITextField!
    
    @IBOutlet weak var emailTxt: UITextField!
    
    @IBOutlet weak var registerBtn: UIButton!
    
    @IBOutlet weak var phoneTxt: UITextField!
    
    @IBAction func onLoginVerify(sender: AnyObject) {
        
        var user  = usernameTxt.text
        var pass  = passwordTxt.text
        var email = emailTxt.text
        var phone = phoneTxt.text
        
        if(user != "" && pass != "" && email != ""){
            var obj:AppUser = AppUser(user: user, pass: pass, email: email, phone: phone)
            
            userSignup( obj )
        }else{
            messageTxt.text = "Please Fill Out All Fields"
        }
    }

    func userSignup( obj:AppUser ){
        
        println("userSignup")
        
        var user:PFUser = PFUser()
        user.username = obj.user
        user.password = obj.pass
        user.email    = obj.email
        
        user.signUpInBackgroundWithBlock({ (succeeded, error) -> Void in
            if !(error != nil) {
                //A. Success
                self.messageTxt.text = "Welcome \(user.username!)!"
            } else {
                //B. Error
                if let errorMsg = error!.userInfo?["error"] as? NSString{
                    self.messageTxt.text = errorMsg.description
                }
            }
        })
    }
    
    
    func userLogin(){
        
        PFUser.logInWithUsernameInBackground("user001", password: "password", block: { (user, error) -> Void in
            if user != nil {
                dispatch_async(dispatch_get_main_queue()) {
                    //self.performSegueWithIdentifier("signInToNavigation", sender: self)
                    println("Success")
                }
            } else {
                //                self.activityIndicator.stopAnimating()
                if let message: AnyObject = error!.userInfo!["error"]{
                    self.messageTxt.text = "\(message)"
                }
            }
        })
    }
    
    func simpleSave(){
        var object = PFObject(className: "Category")
        object.addObject("kotton", forKey: "clothes")
        object.addObject("reebok", forKey: "shoes")
        object.saveInBackground()
    }
    
    /* ** ** ** ** ** ** ** ** ** ** ** ** ** **
    
    * ** ** ** ** ** ** ** ** ** ** ** ** ** **/
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
