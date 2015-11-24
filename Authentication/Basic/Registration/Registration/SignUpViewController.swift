//
//  SignUpViewController.swift
//  Registration
//
//  Created by Tommy Trojan on 11/23/15.
//  Copyright © 2015 Chris Mendez. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    let BASE_URL = "http://localhost:8080"
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var password2TextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var zipCodeTextField: UITextField!
    
    @IBAction func signUp(sender: AnyObject) {
        var array = [
            "email":     emailTextField.text!,
            "password":  passwordTextField.text!,
            "password2": password2TextField.text!,
            "firstName": firstNameTextField.text!,
            "lastName":  lastNameTextField.text!,
            "zipCode":   zipCodeTextField.text!
        ]
        
        //Validate Password
        if(array["password"] != array["password2"]){
            displayAlertMessage("Passwords do not match")
            return
        }
        //Validate data
        var postData = ""
        for (key, value) in array{
            if(value == ""){
                displayAlertMessage("Please fill out all the required fields.")
                print("Missing Data: key: \(key)")
                return
            }
            //Be efficient and construct a POST String
            postData += "\(key)=\(value)&"
        }
        
        //Create HTTP Post request
        let url = NSURL(string: "/users/create", relativeToURL: NSURL(string: BASE_URL))
        let request = NSMutableURLRequest(URL: url!)
            request.HTTPMethod = "POST"
            request.HTTPBody = postData.dataUsingEncoding(NSUTF8StringEncoding)

        //Send the POST request and handle the response
        NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: { data, response, error in
            //We're calling this from the background thread
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                //Error
                if error != nil{
                    self.displayAlertMessage(error!.localizedDescription)
                    return
                }
                
                //JSON Response
                //print("response:", response)
                var success:String?
                var message:String?
                do{
                    let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as? NSDictionary
                    success = json!["success"] as? String
                    message = json!["message"] as? String
                } catch {
                    let err = NSError(domain: self.BASE_URL, code: 1, userInfo: nil)
                    print("error:", err)
                }
                
                if( success == "true" ) {
                    //Dismiss the view after a successful login
                    let action = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
                        self.dismissViewControllerAnimated(true, completion: nil)
                    })
                    let alert = UIAlertController(title: "Success", message: "Registration Successful", preferredStyle: UIAlertControllerStyle.Alert)
                        alert.addAction(action)
                }else{
                    self.displayAlertMessage(message!)
                }
            })
        }).resume()
        
    }
    
    @IBAction func cancel(sender: AnyObject) {
        //There's nothing you want to do once things are cancelled
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // ///////////////////////////////////////
    // Alert
    // ///////////////////////////////////////
    func displayAlertMessage(userMessage:String){
        let action = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
        let alert = UIAlertController(title: "Error", message: userMessage, preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(action)
        
        self.presentViewController(alert, animated: true, completion: nil)
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
