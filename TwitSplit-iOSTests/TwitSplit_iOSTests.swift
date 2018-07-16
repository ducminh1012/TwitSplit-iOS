//
//  TwitSplit_iOSTests.swift
//  TwitSplit-iOSTests
//
//  Created by MD on 7/10/18.
//  Copyright © 2018 MD. All rights reserved.
//

import XCTest
@testable import TwitSplit_iOS

class TwitSplit_iOSTests: XCTestCase {
    var viewController: ViewController!
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        viewController = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        viewController.loadViewIfNeeded()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSplitMessage() {
        let m1 = "I can't believe Tweeter now supports chunking my messages, so I don't have to do it myself."
        
        let m2 = "The burger is made with habanero peppers, ghost chilis, and secret hot sauce, as well as two Angus beef patties, maple bacon, cheese, pickles, jalapeños, tomato, and lettuce. Ghost chilis alone are considered the hottest chilis in the world, measuring between 855,000 and 1,041,427 SHU (Scoville Heat Units)."
        
        let e1 = ["1/2 I can't believe Tweeter now supports chunking", "2/2 my messages, so I don't have to do it myself."]
        
        let e2 = ["1/7 The burger is made with habanero peppers,", "2/7 ghost chilis, and secret hot sauce, as well as", "3/7 two Angus beef patties, maple bacon, cheese,", "4/7 pickles, jalapeños, tomato, and lettuce. Ghost", "5/7 chilis alone are considered the hottest chilis", "6/7 in the world, measuring between 855,000 and", "7/7 1,041,427 SHU (Scoville Heat Units)."]
        
        let r1 = viewController.splitMessage(message: m1)
        let r2 = viewController.splitMessage(message: m2)

        let c1 = r1.filter { (text) -> Bool in
            return text.count >= 50
        }
        
        let c2 = r2.filter { (text) -> Bool in
            return text.count > 50
        }
        
        XCTAssertEqual(c1.count, 0)
        XCTAssertEqual(c2.count, 0)
        XCTAssertEqual(r1, e1)
        XCTAssertEqual(r2, e2)
    }
}
