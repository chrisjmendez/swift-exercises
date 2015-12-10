//
//  Config.swift
//
//  The benefit of a structure-based config file is that
//  there is no intermediate step between the config file
//  and our code to deserialize the config value into an
//  object.
//
//  http://collectiveidea.com/blog/archives/2014/10/01/simple-cocoa-configuration-using-swift-structures/
//
//  Created by Chris Mendez on 9/26/15.
//  Copyright (c) 2015 Chris Mendez. All rights reserved.
//

import UIKit

struct Config {
    static let maxConnections = 10
    
    struct db {
        static let uri = "https://swift-example.firebaseio.com/"
    }
 }
