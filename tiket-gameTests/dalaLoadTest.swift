//
//  dalaLoadTest.swift
//  tiket-gameTests
//
//  Created by Andrew Khasanov on 29.06.2019.
//  Copyright © 2019 Andrew Khasanov. All rights reserved.
//

import XCTest
@testable import tiket_game;

class dalaLoadTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testDataLoad() {
        /*loadTickets("https://puh.xax.cloud:5001/api/tickets")
        while(loadingState == true) {
            sleep(1)
        }
        print(ticketData)
        XCTAssertEqual(100, ticketData.count)*/
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
