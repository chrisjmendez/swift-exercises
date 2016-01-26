//
//  Util.swift
//  TDD
//
//  Created by Chris on 1/25/16.
//  Copyright © 2016 Chris Mendez. All rights reserved.
//

public class Util {

    func isPrime(number:Int) -> Bool {
        
        var primeFlag:Bool = true
        
        if ((number == 2) || (number == 3)) {
            return primeFlag
        }
        
        if (number > 3) {
            for index in 2...number-1 {
                if (number % index == 0) {
                    primeFlag = false
                    break
                }
            }
        } else {
            primeFlag = false
        }
        return primeFlag
    }
}