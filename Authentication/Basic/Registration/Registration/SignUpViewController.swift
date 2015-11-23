//
//  SignUpViewController.swift
//  Registration
//
//  Created by Tommy Trojan on 11/23/15.
//  Copyright © 2015 Chris Mendez. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var password2TextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var zipCodeTextField: UITextField!
    
    @IBAction func signUp(sender: AnyObject) {
        var array = [
            "email": emailTextField.text!,
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
        let myURL = NSURL(string: "http://localhost:8080/users/add/")
        let request = NSMutableURLRequest(URL: myURL!)
            request.HTTPMethod = "POST"
            request.HTTPBody = postData.dataUsingEncoding(NSUTF8StringEncoding)

        //Send the POST request and handle the response
        NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: { data, response, error in
            //We're calling this from the background thread
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                if error != nil{
                    //If something goes wrong, announce it to the user
                    self.displayAlertMessage(error!.localizedDescription)
                    return
                }
                
                var err:NSError?
                
                var json:NSDictionary?
                do{
                    json = try! NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as? NSDictionary
                    
                }catch{
                    print("JSON err:")
                }
                
                if let parseJSON = json {
                    var userId = parseJSON["userId"] as! String
                    //If user doesn't exist
                    if(userId != ""){
                        var myAlert = UIAlertController(title: "Alert", message: "Registration Successful", preferredStyle: UIAlertControllerStyle.Alert)
                        
                        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
                            self.dismissViewControllerAnimated(true, completion: nil)
                        })
                    }
                    //If user exists
                    else{
                        let errorMessage = parseJSON["message"] as? String
                        if( errorMessage ) != nil{
                            self.displayAlertMessage(errorMessage!)
                        }
                    }
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
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
        let myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.Alert)
            myAlert.addAction(okAction)
        
        self.presentViewController(myAlert, animated: true, completion: nil)
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
