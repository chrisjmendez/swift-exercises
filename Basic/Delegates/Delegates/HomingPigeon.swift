//
//  RandomTaskUtil.swift
//  Delegates
//
//  Created by Tommy Trojan on 12/11/15.
//  Copyright © 2015 Chris Mendez. All rights reserved.
//

import UIKit

protocol HomingPigeonDelegate {
    func voyageDidFinish(message:String)
}

class HomingPigeon {
    var delegate:HomingPigeonDelegate? = nil
    
    internal init(message:String){
        print("Sending Message")
        deliverMessage(message)
    }
    
    func deliverMessage(message:String){
        print("Message Delivered")
        //This is simply to show you that you can do another few million tasks
        Simulator.sharedInstance.runSimulatorWithMinTime(2, maxTime: 5)
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            //Run simulator to resemble an HTTP request
            Simulator.sharedInstance.runSimulatorWithMinTime(2, maxTime: 20)
            self.sendResponse(message)
        })
    }
    
    func sendResponse(message:String){
        print("Response Sent")
        let reponse = "\(message) Polo!"
        delegate?.voyageDidFinish(reponse)
    }
}
