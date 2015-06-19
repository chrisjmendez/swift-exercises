//
//  Item.swift
//  Firebase
//
//  Created by tommy trojan on 6/11/15.
//  Copyright (c) 2015 Chris Mendez. All rights reserved.
//
import Foundation

public class Item{
    let identifier:Int
    
    var type: String?  = nil
    var by: String?    = nil
    var date: NSDate?  = nil
    var title: String? = nil
    var url: NSURL?    = nil
    var text: String?  = nil
    var score: Int32
    
    init(dictionary: [String: AnyObject]){
        //Assign NSNumber to Int
        self.identifier = Int(dictionary["id"] as! NSNumber)
        self.score = 0
        self.update(dictionary)
    }
    
    public func update(dictionary: [String: AnyObject]){

        self.type = dictionary["type"] as? String
        
        self.by   = dictionary["by"] as? String
        
        let unixTime = dictionary["time"] as? NSNumber
        if let time:NSNumber = unixTime {
            self.date = NSDate(timeIntervalSince1970: time.doubleValue) as NSDate
        }
        
        self.title = dictionary["title"] as? String
        
        let urlString = dictionary["url"] as? String
        if let string = urlString{
            self.url = NSURL(string: string)
        }
        
        let score = dictionary["score"] as? NSNumber
        
        if let value:NSNumber  = score{
            self.score = Int32(value.intValue)
        }
        
        self.text = dictionary["text"] as? String
    }
}