//
//  LeftSideViewController.swift
//  DualPanel
//
//  Created by Tommy Trojan on 12/19/15.
//  Copyright © 2015 Chris Mendez. All rights reserved.
//
//
//  !!! Don't forget to create outlets for "dataSource" and "delegate" http://imgur.com/a/lVJ0u

import UIKit

class LeftSideViewController: UIViewController {

    var menuItems = [
        "Main Page",
        "About Page",
        "Log Out Page"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension LeftSideViewController:UITableViewDataSource{

    //Create three rows to reflect "menuItem"
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    //For each "menuItem", we much instantiate and return a UITableViewCell
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //You Created a custom cell like this => http://imgur.com/7rorjBf
        let myCustomCell = tableView.dequeueReusableCellWithIdentifier("myCustomCell", forIndexPath: indexPath) as UITableViewCell
        
        myCustomCell.textLabel?.text = menuItems[indexPath.row]
        
        return myCustomCell
    }
}

extension LeftSideViewController:UITableViewDelegate{
    //This is called when one of the user taps the rows in our tableview
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        switch(indexPath.row){
            //Main Page
        case 0:
            print("Main Page Tapped \(indexPath.row)")
            //Instantiate MainPageViewController. Remember, identifer is "m" not "M" http://imgur.com/jyGblaR
            let mainPageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("mainViewController") as! MainPageViewController
            
            //Wrap it into Navigation Controller
            let mainPageNav = UINavigationController(rootViewController: mainPageViewController)
            //Set Navigation Controller to Navigation Drawer which was created in AppDelegate
            
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            //Assign mainPageNav is the Center View Controller
                appDelegate.drawerContainer?.centerViewController = mainPageNav
            //Toggle the LeftPanel and close it
                appDelegate.drawerContainer?.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
        case 1:
            print("About Page Tapped \(indexPath.row)")
            //Instantiate MainPageViewController. Remember, identifer is "a" not "A"
            let aboutViewController = self.storyboard?.instantiateViewControllerWithIdentifier("aboutViewController") as! AboutViewController
            
            //Wrap it into Navigation Controller
            let aboutPageNav = UINavigationController(rootViewController: aboutViewController)
            //Set Navigation Controller to Navigation Drawer which was created in AppDelegate
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            
            //Swap the Center View Controller with the active item
            appDelegate.drawerContainer?.centerViewController = aboutPageNav
            //Toggle the LeftPanel and close it
            appDelegate.drawerContainer?.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
            break
            
        case 2:
            print("Logout Tapped \(indexPath.row)")
            
            let mainPageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("mainViewController") as! MainPageViewController
                mainPageViewController.signOut()
            
            
            /*
            let userDefaults = NSUserDefaults.standardUserDefaults()
            userDefaults.removeObjectForKey("userFirstName")
            userDefaults.removeObjectForKey("userLastName")
            userDefaults.removeObjectForKey("userID")
            userDefaults.synchronize()
            
            let signInPage = self.storyboard?.instantiateViewControllerWithIdentifier("viewController") as! ViewController
            
            let signInNav = UINavigationController(rootViewController: signInPage)
            
            let appDelegate = UIApplication.sharedApplication().delegate
            appDelegate?.window??.rootViewController = signInNav
            */
            break
        default:
            print("Not Handled")
            break
        }
    }
}
