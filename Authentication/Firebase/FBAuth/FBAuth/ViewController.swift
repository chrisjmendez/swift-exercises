//
//  ViewController.swift
//  FBAuth
//
//  Created by Tommy Trojan on 12/10/15.
//  Copyright © 2015 Chris Mendez. All rights reserved.
//

import UIKit
import Firebase
import Accounts
import FBSDKLoginKit

class ViewController: UIViewController {
    
    let SEGUE_LOGIN_COMPLETE = "onLoginComplete"
    let ref = Firebase(url: Config.db.firebase)
    var activityIndicator:UIActivityIndicatorView!

    @IBOutlet weak var buttonFB: UIButton!
    
    @IBAction func onFacebookLogin(sender: AnyObject) {
            let permissions = ["email"]
            let facebookLogin = FBSDKLoginManager()
            
            facebookLogin.logInWithReadPermissions(permissions, fromViewController: self) { (facebookResult, facebookError) -> Void in
                if (facebookError != nil) {
                    print("Facebook login failed. Error \(facebookError)")
                } else if facebookResult.isCancelled {
                    print("Facebook login was cancelled.")
                } else {
                    let accessToken = FBSDKAccessToken.currentAccessToken().tokenString
                    self.ref.authWithOAuthProvider("facebook", token: accessToken, withCompletionBlock: { error, authData in
                        if (error != nil) {
                            self.showAlert("Login failed. \(error)")
                        } else {
                            print("Logged in! \(authData)")
                            
                            //Collect User Data
                            let provider = self.ref.authData.provider
                            
                            self.performSegueWithIdentifier(self.SEGUE_LOGIN_COMPLETE, sender: authData)
                        }
                    })
                }
            }
    }
    
    // //////////////////////////////////////
    //  Transitions
    // //////////////////////////////////////
    //Pack a few extra variables into the transition
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let messagesVc = segue.destinationViewController as! MainViewController
        if let authData = sender as? FAuthData {
            print(authData.providerData["username"])
            messagesVc.user = authData
            messagesVc.ref = ref
            messagesVc.sender = authData.providerData["displayName"] as! String
        }
    }
    
    // //////////////////////////////////////
    //  Alerts and Action Sheets
    // //////////////////////////////////////
    func showAlert(message: String){
        activityIndicator.stopAnimating()
        
        enableButtons()
        
        //Create the AlertController
        let actionSheetController: UIAlertController = UIAlertController(title: "Alert", message: message, preferredStyle: .Alert)
        
        //Create and an option action
        let nextAction: UIAlertAction = UIAlertAction(title: "OK", style: .Default) { action -> Void in
            //Do some other stuff
        }
        actionSheetController.addAction(nextAction)
        
        //Present the AlertController
        self.presentViewController(actionSheetController, animated: true, completion: nil)
    }
    
    func disableButtons(){
        buttonFB.enabled = false
    }
    
    func enableButtons(){
        buttonFB.enabled = true
    }

    
    // //////////////////////////////////////
    //  OnLoad
    // //////////////////////////////////////

    func initLoader(){
        activityIndicator = UIActivityIndicatorView(frame: CGRect(x: view.frame.midX, y: view.frame.midY, width: 20, height: 20))
        activityIndicator.activityIndicatorViewStyle = .Gray
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        initLoader()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

