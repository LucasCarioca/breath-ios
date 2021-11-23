//
//  CounterViewTests.swift
//  CounterViewTests
//
//  Created by Lucas Desouza on 10/24/20.
//  Copyright © 2020 Lucas Desouza. All rights reserved.
//

import XCTest

class CounterPageTests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func setUp() {
        super.setUp()
        XCUIApplication().launch()
    }

    func test_shouldLoad() throws {
        let counterPage = CounterPageModel()
        XCTAssert(counterPage.viewDidLoad())
    }

    func test_shouldCountOnButtonTap() throws {
        let counterPage = CounterPageModel()
        counterPage.clickCountBreathButton()
        XCTAssert(counterPage.isCounter(at: 1))
        XCTAssert(counterPage.isTimer(at: 30))
        XCTAssert(counterPage.isResetButtonVisible())
        counterPage.clickCountBreathButton()
        XCTAssert(counterPage.isCounter(at: 2))
        counterPage.clickCountBreathButton()
        XCTAssert(counterPage.isCounter(at: 3))
    }

    func test_onCountReset_shouldStopCounting() throws {
        let counterPage = CounterPageModel()
        counterPage.clickCountBreathButton()
        XCTAssert(counterPage.isCounter(at: 1))
        counterPage.clickResetButton()
        XCTAssert(!counterPage.isCounter(at: 1))
        XCTAssert(!counterPage.isResetButtonVisible())
    }

    func test_onCountEnd_shouldShowResult() throws {
        let counterPage = CounterPageModel()
        counterPage.clickCountBreathButton(times: 3)
        XCTAssert(counterPage.isResult(at: 6, timeout: 35))
    }
}
