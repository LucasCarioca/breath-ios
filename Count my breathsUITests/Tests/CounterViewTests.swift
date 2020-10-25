//
//  CounterViewTests.swift
//  CounterViewTests
//
//  Created by Lucas Desouza on 10/24/20.
//  Copyright © 2020 Lucas Desouza. All rights reserved.
//

import XCTest

class CounterViewTests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }
    
    override func setUp() {
        super.setUp()
        XCUIApplication().launch()
    }
    
    func test_shouldLoad() throws {
        let counterView = CounterViewController()
        XCTAssert(counterView.viewDidLoad())
    }
    
    func test_shouldCountOnButtonTap() throws {
        let counterView = CounterViewController()
        counterView.clickCountBreathButton()
        XCTAssert(counterView.isCounter(at: 1))
        XCTAssert(counterView.isTimer(at: 30))
        XCTAssert(counterView.isResetButtonVisible())
        counterView.clickCountBreathButton()
        XCTAssert(counterView.isCounter(at: 2))
        counterView.clickCountBreathButton()
        XCTAssert(counterView.isCounter(at: 3))
    }
    
    func test_onCountReset_shouldStopCounting() throws {
        let counterView = CounterViewController()
        counterView.clickCountBreathButton()
        XCTAssert(counterView.isCounter(at: 1))
        counterView.clickResetButton()
        XCTAssert(!counterView.isCounter(at: 1))
        XCTAssert(!counterView.isResetButtonVisible())
    }
    
    func test_onCountEnd_shouldShowResult() throws {
        let counterView = CounterViewController()
        counterView.clickCountBreathButton(times: 3)
        XCTAssert(counterView.isResult(at: 6, timeout: 35))
    }
}
