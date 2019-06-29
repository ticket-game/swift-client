//
//  checkAnswerTest.swift
//  tiket-gameTests
//
//  Created by Andrew Khasanov on 27.06.2019.
//  Copyright © 2019 Andrew Khasanov. All rights reserved.
//

import XCTest
@testable import tiket_game;

class checkAnswerTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCheckAnswer() throws {
        let variant = try Answer(operators:["(", "+", ")*(", "+", ")*", "*", ""], numset: [9, 1, 7, 3, 1, 1])
        let result = try checkAnswer(variant: variant)!
        XCTAssert(100 == result);
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
