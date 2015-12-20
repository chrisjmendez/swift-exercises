//
//  Simulator.swift
//  DualPanel
//
//  Created by Tommy Trojan on 12/19/15.
//  Copyright © 2015 Chris Mendez. All rights reserved.
//

import Foundation

class Simulator {
    
    class var sharedInstance: Simulator {
        struct Static {
            static let instance: Simulator = Simulator()
        }
        return Static.instance
    }
    
    func runSimulatorWithMinTime( minTime:Int, maxTime:Int ) -> Double {
        print("Simulating a User sign in")
        //Calculate random thread wait time
        let ms:Int = ( Int(rand()) % ((maxTime - minTime) * 1000) ) + (minTime * 1000)
        
        let waitTime:Double = Double(ms) / 1000.0;
        
        let timer:Void = NSThread.sleepForTimeInterval(waitTime)
        
        print( "Simulator.runSimulatorWithMinTime:", waitTime )
        return waitTime
    }
    
}