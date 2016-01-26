//
//  TDDTests.swift
//  TDDTests
//
//  Created by Chris on 1/25/16.
//  Copyright © 2016 Chris Mendez. All rights reserved.
//

import XCTest
@testable import TDD

class TDDTests: XCTestCase {
    
    func testTwoIsPrime() {
        let number:Int = 2;
        XCTAssertTrue(Util().isPrime(number), "2 is a prime number");
    }
    
    func testThreeIsPrime() {
        let number:Int = 3;
        XCTAssertTrue(Util().isPrime(number), "3 is a prime number");
    }
    
    func testFourIsPrime(){
        let number:Int = 4;
        XCTAssert(Util().isPrime(number), "4 is a prime number")
    }
    
    func testElevenIsPrimt(){
        let number:Int = 11
        XCTAssert(Util().isPrime(number), "11 is not a prime number")
    }
    
    func testThirtyOneIsPrime() {
        let number:Int = 31;
        XCTAssertTrue(Util().isPrime(number), "31 is a prime number");
    }
    
    func testFiftyIsPrime() {
        let number:Int = 50;
        XCTAssertFalse(Util().isPrime(number), "50 is not a prime number");
    }

    func testMinusOneIsPrime() {
        let number:Int = –1;
        XCTAssertFalse(Util().isPrime(number), "-1 is not a prime number");
    }
}
