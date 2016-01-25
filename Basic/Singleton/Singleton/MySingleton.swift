//
//  MySingleton.swift
//  Singleton
//
//  Created by Chris on 1/22/16.
//  Copyright © 2016 Chris Mendez. All rights reserved.
//

//http://krakendev.io/blog/the-right-way-to-write-a-singleton

class MySingleton {
    static let sharedInstance = MySingleton()
    private init() {} //This prevents others from using the default '()' initializer for this class.
    
    private var sessionScore = 0
    
    
    func addPoint(number:Int){
        sessionScore += number
        print("Game Score:", sessionScore)
    }
    
}
