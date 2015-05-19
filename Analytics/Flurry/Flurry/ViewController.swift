//
//  ViewController.swift
//  Flurry
//
//  Created by tommy trojan on 5/19/15.
//  Copyright (c) 2015 Chris Mendez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tabBar: UITabBar!
    
    @IBAction func button1Clicked(sender: AnyObject) {
        var dictionary:NSDictionary = [ "event": [ "source": "button 1", "timestamp": getTimestamp() ] ]
        Flurry.logEvent("buttonClicked", withParameters: dictionary as [NSObject : AnyObject] )
    }
    
    @IBAction func button2Clicked(sender: AnyObject) {
        var dictionary:NSDictionary = [ "event": [ "source": "button 2", "timestamp": getTimestamp() ] ]
        Flurry.logEvent("buttonClicked", withParameters: dictionary as [NSObject : AnyObject] )
    }
    
    @IBAction func button3Clicked(sender: AnyObject) {
        var dictionary:NSDictionary = [ "event": [ "source": "button 3", "timestamp": getTimestamp() ] ]
        Flurry.logEvent("buttonClicked", withParameters: dictionary as [NSObject : AnyObject] )
    }
    
    @IBAction func button4Clicked(sender: AnyObject) {
        var dictionary:NSDictionary = [ "event": [ "source": "button 4", "timestamp": getTimestamp() ] ]
        Flurry.logEvent("buttonClicked", withParameters: dictionary as [NSObject : AnyObject] )
    }
    
    func getTimestamp() -> String{
        let date = NSDate()
        let dateFormatter = NSDateFormatter()
        let timeZone = NSTimeZone(name: "UTC")
        
        dateFormatter.timeZone = timeZone
        
        return String(dateFormatter.stringFromDate(date))
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tabBar.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController: UITabBarDelegate {
    func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem!) {
        var selectedItem = tabBar.selectedItem?.title!
        var selectedTitle = selectedItem!.lowercaseString
        
        var dictionary:NSDictionary = NSDictionary()

        switch(selectedTitle){
        case "favorites":
            dictionary = [ "event": [ "source": "favorites", "timestamp": getTimestamp() ] ]
        break
        case "messages":
            dictionary = [ "event": [ "source": "messages", "timestamp": getTimestamp() ] ]
        break
        case "my account":
            dictionary = [ "event": [ "source": "my account", "timestamp": getTimestamp() ] ]
            break
        case "more":
            dictionary = [ "event": [ "source": "more", "timestamp": getTimestamp() ] ]
        break;
        default:
            break;
        }
        
        Flurry.logEvent("tabBarClicked", withParameters: dictionary as [NSObject : AnyObject] )
    }
}