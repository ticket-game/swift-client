//
//  CalculatorTest.swift
//  tiket-gameTests
//
//  Created by Andrew Khasanov on 26.06.2019.
//  Copyright © 2019 Andrew Khasanov. All rights reserved.
//

import XCTest
@testable import tiket_game;

class CalculatorTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCalculate() throws {
        do {
            let calc = Calculator();
            let result = try calc.Calculate(expression: [9, 12, 9])
            print(String(result!))
            XCTAssertEqual(result, 1)
        } catch {
            print(error)
            Thread.callStackSymbols.forEach {
                print($0)
            }
        }
    }

    func testCalculate2() throws {
        do {
            let calc = Calculator();
            let result = try calc.Calculate(expression: [0, 0, 0])
            print(String(result!))
            XCTAssertEqual(result, 0)
        } catch {
            print(error)
            Thread.callStackSymbols.forEach {
                print($0)
            }
        }
    }

    func testCalculate3() throws {
        do {
            let calc = Calculator();
            let result = try calc.Calculate(expression: [9, 11, 15, 5, 13, 3, 16])
            print(String(result!))
            XCTAssertEqual(result, 72)
        } catch {
            print(error)
            Thread.callStackSymbols.forEach {
                print($0)
            }
        }
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
