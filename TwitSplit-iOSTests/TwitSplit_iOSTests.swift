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
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // Test the example in assignment
    func testExampleMessage() {
        
        // Given
        let input = "I can't believe Tweeter now supports chunking my messages, so I don't have to do it myself."
        let expect = ["1/2 I can't believe Tweeter now supports chunking",
                      "2/2 my messages, so I don't have to do it myself."]
        // When
        do {
            let result = try splitMessage(message: input)
        // Then
            XCTAssertEqual(result, expect)
        } catch SplitError.inputError(let errorMessage) {
            XCTFail(errorMessage)
        } catch (let error) {
            XCTFail(error.localizedDescription)
        }
        
    }
    
    func testShortMessage() {
        
        // Given
        let input = "Life is just a chance to grow a soul."
        let expect = ["Life is just a chance to grow a soul."]
        // When
        do {
            let result = try splitMessage(message: input)
        // Then
            XCTAssertEqual(result, expect)
        } catch SplitError.inputError(let errorMessage) {
            XCTFail(errorMessage)
        } catch (let error) {
            XCTFail(error.localizedDescription)
        }
        
    }
    
    // Test empty message. Error should throw out.
    func testEmptyMessage() {
        
        // Given
        let input = ""
        
        // When
        do {
            _ = try splitMessage(message: input)
        // Then
            XCTFail("Can not split empty message.")
        } catch SplitError.inputError(let errorMessage) {
            XCTAssert(errorMessage == "Can not split message. Your message is empty.")
        } catch (let error) {
            XCTFail(error.localizedDescription)
        }
        
    }
    
    // Test excess message. Error should throw out.
    func testExcessMessage() {
        
        // Given
        let input = "Thisisanexampleforlongmessagewithhasmorethan50characters."
        
        // When
        do {
            _ = try splitMessage(message: input)
        // Then
            XCTFail("Can not split excess message.")
        } catch SplitError.inputError(let errorMessage) {
            XCTAssert(errorMessage == "Can not split message. Your message has one or more words with have more than 50 characters.")
        } catch (let error) {
            XCTFail(error.localizedDescription)
        }
        
    }
    
    func testLongMessage() {
        
        // Given
        let input = "The burger is made with habanero peppers, ghost chilis, and secret hot sauce, as well as two Angus beef patties, maple bacon, cheese, pickles, jalapeños, tomato, and lettuce. Ghost chilis alone are considered the hottest chilis in the world, measuring between 855,000 and 1,041,427 SHU (Scoville Heat Units)."
        let expect = ["1/7 The burger is made with habanero peppers,", "2/7 ghost chilis, and secret hot sauce, as well as", "3/7 two Angus beef patties, maple bacon, cheese,", "4/7 pickles, jalapeños, tomato, and lettuce. Ghost", "5/7 chilis alone are considered the hottest chilis", "6/7 in the world, measuring between 855,000 and", "7/7 1,041,427 SHU (Scoville Heat Units)."]
        // When
        do {
            let result = try splitMessage(message: input)
        // Then
            XCTAssertEqual(result, expect)
        } catch SplitError.inputError(let errorMessage) {
            XCTFail(errorMessage)
        } catch (let error) {
            XCTFail(error.localizedDescription)
        }
        
    }
    
    func testSuperLongMessage() {
        // Given
        let input =
                    """
            The burger is made with habanero peppers, ghost chilis, and secret hot sauce, as well as two Angus beef patties, maple bacon, cheese, pickles, jalapeños, tomato, and lettuce. Ghost chilis alone are considered the hottest chilis in the world, measuring between 855,000 and 1,041,427 SHU (Scoville Heat Units).

            Eating the burger can be so dangerous, customers have to sign a waiver and wear protective gear. It’s definitely not for the faint of heart, tongue, or stomach.

            “It's legitimately the hottest burger in Australia. Those ghost chilis are no joke,” Burger Urge managing director Sean Carthew told 9News.

            The burger will be available at all 26 Burger Urge restaurants in Australia until Friday. Brave spice lovers should act fast, because they are apparently selling out quickly.
            """
        let expect = ["1/19 The burger is made with habanero peppers,", "2/19 ghost chilis, and secret hot sauce, as well", "3/19 as two Angus beef patties, maple bacon,", "4/19 cheese, pickles, jalapeños, tomato, and", "5/19 lettuce. Ghost chilis alone are considered", "6/19 the hottest chilis in the world, measuring", "7/19 between 855,000 and 1,041,427 SHU (Scoville", "8/19 Heat Units). Eating the burger can be so", "9/19 dangerous, customers have to sign a waiver", "10/19 and wear protective gear. It’s definitely", "11/19 not for the faint of heart, tongue, or", "12/19 stomach. “It\'s legitimately the hottest", "13/19 burger in Australia. Those ghost chilis are", "14/19 no joke,” Burger Urge managing director Sean", "15/19 Carthew told 9News. The burger will be", "16/19 available at all 26 Burger Urge restaurants", "17/19 in Australia until Friday. Brave spice", "18/19 lovers should act fast, because they are", "19/19 apparently selling out quickly."]
        
        // When
        do {
            let result = try splitMessage(message: input)
        // Then
            XCTAssertEqual(result, expect)
        } catch SplitError.inputError(let errorMessage) {
            XCTFail(errorMessage)
        } catch (let error) {
            XCTFail(error.localizedDescription)
        }
    }
}
