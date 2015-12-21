//
//  MainPageViewController.swift
//  DualPanel
//
//  Created by Tommy Trojan on 12/19/15.
//  Copyright © 2015 Chris Mendez. All rights reserved.
//

import UIKit

class MainPageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print("Welcome to the MainPage")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension MainPageViewController {
    
    @IBAction func rightSideButtonTapped(sender: AnyObject) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.drawerContainer?.toggleDrawerSide(MMDrawerSide.Right, animated: true, completion: nil)
    }
    
    @IBAction func leftSideButtonTapped(sender: AnyObject) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.drawerContainer?.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
    }
    
    
    /*
    @IBAction func onSignOut(sender: AnyObject) {
        signOut()
    }
    */
    
    func signOut(){
        print("signOut")
        let userDefaults = NSUserDefaults.standardUserDefaults()
            userDefaults.removeObjectForKey("userFirstName")
            userDefaults.removeObjectForKey("userLastName")
            userDefaults.removeObjectForKey("userID")
            userDefaults.synchronize()
        
        let signInPage = self.storyboard?.instantiateViewControllerWithIdentifier("viewController") as! ViewController
        
        let signInNav = UINavigationController(rootViewController: signInPage)
        
        let appDelegate = UIApplication.sharedApplication().delegate
            appDelegate?.window??.rootViewController = signInNav
    }

}
