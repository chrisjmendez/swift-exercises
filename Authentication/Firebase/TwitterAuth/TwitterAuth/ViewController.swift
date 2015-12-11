//
//  ViewController.swift
//  TwitterAuth
//
//  Created by Tommy Trojan on 12/9/15.
//  Copyright © 2015 Chris Mendez. All rights reserved.
//
// Inspiration: https://proxy.piratenpartij.nl/raw.githubusercontent.com/firebase/ios-swift-chat-example/master/FireChat-Swift/LoginViewController.swift
// https://www.firebase.com/docs/ios/guide/login/twitter.html


import UIKit
import Firebase

class ViewController: UIViewController {
    
    var SEGUE_LOGIN_COMPLETE = "onLoginComplete"
    
    var ref:Firebase!
    var twitterAuthHelper:TwitterAuthHelper!
    var accounts = [ACAccount]()
    var activityIndicator:UIActivityIndicatorView!
    
    @IBOutlet weak var buttonTwitter: UIButton!
    
    @IBAction func onTwitterLogin(sender: AnyObject) {
        print("onTwitterLogin")
        //let button = sender as? UIButton
        
        disableButtons()
        
        twitterAuthHelper.selectTwitterAccountWithCallback { error, accounts in
            
            if error != nil {
                // Error retrieving Twitter accounts
                self.showAlert("Please Set Up your Twitter Accounts")
            }
                //Check if you have any Twitter accounts at all
            else if accounts.count > 0 {
                //If you have more than one account, store them
                self.accounts = accounts as! [ACAccount]
                //Handle the setup
                self.handleMultipleTwitterAccounts(self.accounts)
            }
            else {
                print("No accounts availble \(accounts.count)")
                self.showAlert("No available accounts.")
            }
        }
    }
    
    func disableButtons(){
        buttonTwitter.enabled = false
    }
    
    func enableButtons(){
        buttonTwitter.enabled = true
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
    
    
    func showActionSheet(accounts: [ACAccount]){
        //Present the Options in an Alert Controller
        let actionSheetController: UIAlertController = UIAlertController(title: "Select Twitter Account", message: nil, preferredStyle: .ActionSheet)
        
        //Cancel
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel) { action -> Void in
            //Just dismiss the action sheet
        }
        actionSheetController.addAction(cancelAction)
        
        for account in accounts {
            let action: UIAlertAction = UIAlertAction(title: account.username, style: .Default) { action -> Void in
                let selectedTwitterHandle = action.title
                for account in accounts {
                    if account.username == selectedTwitterHandle {
                        self.authAccount(account)
                    }
                }
            }
            actionSheetController.addAction(action)
        }
        
        //We need to provide a popover sourceView when using it on iPad
        //actionSheetController.popoverPresentationController?.sourceView = sender as? UIView;
        
        //Present the AlertController
        self.presentViewController(actionSheetController, animated: true, completion: nil)
        
    }
    
    // //////////////////////////////////////
    //  Twitter Auth
    // //////////////////////////////////////
    func handleMultipleTwitterAccounts(accounts: [ACAccount]) {
        print("accounts: \(accounts)")
        switch accounts.count {
        case 0:
            UIApplication.sharedApplication().openURL(NSURL(string: "https://twitter.com/signup")!)
        case 1:
            self.authAccount(accounts[0])
        default:
            self.selectTwitterAccount(accounts)
        }
    }
    
    func authAccount(account: ACAccount) {
        //print("authAccount: \(account)")
        activityIndicator.startAnimating()
        
        twitterAuthHelper.authenticateAccount(account, withCallback: { (error, authData) -> Void in
            if error != nil {
                // There was an error authenticating
                self.showAlert("Uh Oh. Authentication error.")
            } else {
                // We have an authenticated Twitter user
                print("authAccount: ", authData.providerData[])
                // segue to chat
                self.performSegueWithIdentifier(self.SEGUE_LOGIN_COMPLETE, sender: authData)
            }
        })
    }
    
    func selectTwitterAccount(accounts: [ACAccount]) {
        showActionSheet(accounts)
    }
    
    // //////////////////////////////////////
    //  Transitions
    // //////////////////////////////////////
    //Pack a few extra variables into the transition
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let messagesVc = segue.destinationViewController as! MainViewController
        if let authData = sender as? FAuthData {
            messagesVc.user = authData
            messagesVc.ref = ref
            messagesVc.sender = authData.providerData["username"] as! String
        }
    }
    
    
    // //////////////////////////////////////
    //  On Load
    // //////////////////////////////////////
    func initLoader(){
        activityIndicator = UIActivityIndicatorView(frame: CGRect(x: view.frame.midX, y: view.frame.midY, width: 20, height: 20))
        activityIndicator.activityIndicatorViewStyle = .Gray
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
    }
    
    func onLoad(){
        ref        = Firebase(url: Config.db.firebase)
        twitterAuthHelper = TwitterAuthHelper(firebaseRef: ref, apiKey: Config.social.twitter)
        initLoader()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        title = "TwitterAuth through Firebase"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        onLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

