//
//  ViewController.swift
//  Registration
//
//  Created by Tommy Trojan on 11/23/15.
//  Copyright © 2015 Chris Mendez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let HOST_URL = Config.host.url
    let URL      = "/users/login"
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func signIn(sender: AnyObject) {
        let array = [
            "email":     emailTextField.text!,
            "password":  passwordTextField.text!
        ]
        
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
        print(postData)
        //Create HTTP Post request
        let url = NSURL(string: URL, relativeToURL: NSURL(string: HOST_URL))
        let request = NSMutableURLRequest(URL: url!)
            request.HTTPMethod = "POST"
            request.HTTPBody = postData.dataUsingEncoding(NSUTF8StringEncoding)
        
        //Send the POST request and handle the response
        NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: { data, response, error in
            //We're calling this from the background thread
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                //Error
                if(error != nil){
                    self.displayAlertMessage(error!.localizedDescription)
                    return
                }
                
                //JSON Response
                var success:String?
                var message:String?
                do{
                    let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as? NSDictionary
                    success = json!["success"] as? String
                    message = json!["message"] as? String
                    
                } catch {
                    let err = NSError(domain: self.HOST_URL, code: 1, userInfo: nil)
                    message = "error: \(err)"
                }
                
                if( success! == "true" ) {
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
    
    
    // ///////////////////////////////////////
    // Alert
    // ///////////////////////////////////////
    func displayAlertMessage(userMessage:String){
        let action = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
        let alert = UIAlertController(title: "Error", message: userMessage, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(action)
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

