//
//  AppDelegate.swift
//  DualPanel
//
//  Created by Tommy Trojan on 12/19/15.
//  Copyright © 2015 Chris Mendez. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var drawerContainer:MMDrawerController?
    var userDefaults:NSUserDefaults?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        //If User is signed in, create a Main Navigation
        if(isSignedIn()){
            initNavigationDrawer()
        } else {
            //Set the User ID to something
            userDefaults?.setValue("USER ID ADDED", forKey: "userID")
            //Kick off the process all over again
            initNavigationDrawer()
        }
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

extension AppDelegate{
    
    func isSignedIn() -> Bool{
        userDefaults = NSUserDefaults()
        let userID = userDefaults!.stringForKey("userID")
        if(userID != nil){
            print("User Signed In")
            return true
        }
        print("User Not Signed In")
        return false
    }
    
    func initProtectedPage(){
        let mainStoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let mainPage = mainStoryboard.instantiateViewControllerWithIdentifier("mainViewController") as! MainPageViewController
        let mainPageNav = UINavigationController(rootViewController: mainPage)
        self.window?.rootViewController = mainPageNav
    }
    
    func initNavigationDrawer(){
        //Instantiate 3 navigation View Controllers
        let mainStoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let mainPage = mainStoryboard.instantiateViewControllerWithIdentifier("mainViewController") as! MainPageViewController
        let leftSideMenu = mainStoryboard.instantiateViewControllerWithIdentifier("leftSideViewController") as! LeftSideViewController
        let rightSideMenu = mainStoryboard.instantiateViewControllerWithIdentifier("rightSideViewController") as! RightSideViewController
        
        //Wrap each View Controller into a Navigation Controller
        let mainPageNav = UINavigationController(rootViewController: mainPage)
        let leftSideMenuNav = UINavigationController(rootViewController: leftSideMenu)
        let rightSideMenuNav = UINavigationController(rootViewController: rightSideMenu)
        
        //Create the Navigation Drawer itself
        drawerContainer = MMDrawerController(centerViewController: mainPageNav, leftDrawerViewController: leftSideMenuNav, rightDrawerViewController: rightSideMenuNav)
        drawerContainer!.openDrawerGestureModeMask = MMOpenDrawerGestureMode.PanningCenterView
        drawerContainer!.closeDrawerGestureModeMask = MMCloseDrawerGestureMode.PanningCenterView
        
        //Set the Navigation Controller to the window Root Controller
        window?.rootViewController = drawerContainer
    }
}