// Playground - noun: a place where people can play

import Foundation

class Observer: NSObject{
    deinit{
        println("Good Bye!")
        let nc = NSNotificationCenter.defaultCenter()
        nc.removeObserver(self, name: "The Big Event", object: nil)
    }
    override init(){
        super.init()
        
        let nc = NSNotificationCenter.defaultCenter()
        //Notice how "processBigEvent:" method has a trailing colon
        nc.addObserver(self, selector: "processBigEvent:", name: "The Big Event", object: nil)
    }
    
    func processBigEvent(notification: NSNotification){
        println("Woah! Looks like a Big Event has occurred")
    }
}

//Create Notification Instance
let notification = NSNotification(name: "The Big Event", object: nil)

//Nothing happens
let nc = NSNotificationCenter.defaultCenter()
nc.postNotification(notification)

//Create an instance of our Observer. WE're going to shoe it in the array
var observer = Observer()
nc.postNotification(notification)


var observers = [Observer()]
nc.postNotification(notification)

observers.removeAll()
nc.postNotification(notification)
