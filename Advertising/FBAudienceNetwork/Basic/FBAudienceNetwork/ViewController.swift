//
//  ViewController.swift
//  FBAudienceNetwork
//
//  Created by Chris Mendez on 11/21/15.
//  Copyright © 2015 Chris Mendez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBAction func triggerEvent(_ sender: AnyObject) {
        switch( segmentedControl.selectedSegmentIndex ){
        //Send Event
        case 0:
            FBSDKAppEvents.logEvent("customEvent", parameters: ["case": 0])
            break
        //Unlock Acheivement
        //https://developers.facebook.com/docs/app-events/ios
        case 1:
            FBSDKAppEvents.logEvent(FBSDKAppEventNameUnlockedAchievement, parameters: ["Description": "Tapped Unlock"])
            break
        default:
            break;
        }
    }
    
    func isLoggedIn() -> Bool {
        if FBSDKAccessToken.current() != nil {
            return true
        } else {
            return false
        }
    }
    
    func initFacebook(){
        print("Facebook User is logged in: \(isLoggedIn())")
        let login = FBSDKLoginButton()
            login.center = self.view.center
            login.readPermissions = [Config.permissions.publicProfile, Config.permissions.email, Config.permissions.userFriends]
        
        self.view.addSubview(login)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        initFacebook()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
