//
//  ViewController.swift
//  Twitter
//
//  Created by Tommy Trojan on 12/17/15.
//  Copyright © 2015 Chris Mendez. All rights reserved.
//

import UIKit
import TwitterKit


class ViewController: UIViewController {

    let userDefaults = NSUserDefaults.standardUserDefaults()
    
    func initTwitter(){
        let logInButton = TWTRLogInButton { (session, error) in
            if let unwrappedSession = session {
                
                var userName:String!
                var userID:String!
                
                if(unwrappedSession.userID != ""){
                    self.userDefaults.setValue(unwrappedSession.userID, forKey: "twitter.id")
                    userID = self.userDefaults.objectForKey("twitter.id") as! String
                }
                if(unwrappedSession.userName != ""){
                    self.userDefaults.setValue(unwrappedSession.userName, forKey: "twitter.userName")
                    userName = self.userDefaults.objectForKey("twitter.userName") as! String
                }
                
                //Threaded Task: Go and collect the user's data
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), { ()-> Void in
                    //self.requestData("Twitter", userName: userName, userID: userID )
                })
                
                //Log users in
                //self.goToView(self.SEGUE_LOGIN_COMPLETE)
                
            } else {
                print("Login error: %@", error!.localizedDescription)
            }
        }
        //You'll have to pass this throught the Delegate
        let centerFrame = (self.view.frame.width / 2)
        logInButton.center = CGPoint(x: centerFrame, y: 100)
        self.view.addSubview(logInButton)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        initTwitter()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

