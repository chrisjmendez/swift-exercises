//
//  AppDelegate.swift
//  MenuBar
//
//  Created by Tommy Trojan on 10/5/15.
//  Copyright © 2015 Chris Mendez. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var statusMenu: NSMenu!

    @IBAction func menuClicked(sender: NSMenuItem) {
        executeCommand(sender)
    }

    let nsVarStatusItemLength = -1
    //Reference to main systems status bar
    let statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(NSVariableStatusItemLength)

    
    func executeCommand(sender: NSMenuItem){
        //Execute Mac command line from code
        let task = NSTask()
        //path to the executable
        task.launchPath = "/usr/bin/defaults"
        
        //Test the state of that menu item. It is "on" or "off"
        if(sender.state == NSOnState){
            sender.state = NSOffState
            task.arguments = ["write", "com.apple.finder", "AppleShowAllFiles", "NO"]
        }
        else{
            sender.state = NSOnState
            task.arguments = ["write", "com.apple.finder", "AppleShowAllFiles", "YES"]
        }

        task.launch()
        //Block this task until this command has executed
        task.waitUntilExit()
        
        
        //Relaunch finder
        let killtask = NSTask()
        killtask.launchPath = "/usr/bin/killall"
        killtask.arguments = ["Finder"]
        killtask.launch()
    }
    
    
    func initIcons(){
        //Create an instance of NSImage
        let icon = NSImage(named: "Icons")
            //Know if OS is in "dark" mode and invert the image
            icon?.template = true
            //Set the image property of our status item
            statusItem.image = icon
            //Attach status menu to that status item
            statusItem.menu = statusMenu
    }
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        initIcons()
    }
}

