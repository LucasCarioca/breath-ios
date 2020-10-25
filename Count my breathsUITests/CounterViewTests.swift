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
        skipNewVersionPopup(app: XCUIApplication())
    }
    
    func test_onLoad_shouldShowCounterPage() throws {
        let app = XCUIApplication()
        app.launch()
        XCTAssert(app.staticTexts["Click on the heart below to start counting"].exists)
        XCTAssert(app.buttons["Start counting"].exists)
    }
    
    func test_onCountStart_shouldShowBreathsAndTime() throws {
        let app = XCUIApplication()
        app.launch()
        app.buttons["Start counting"].tap()
        XCTAssert(app.staticTexts["Breaths: 1"].exists)
        XCTAssert(app.staticTexts["Seconds remaining 30"].exists)
        XCTAssert(app.buttons["Reset"].exists)
        app.buttons["Start counting"].tap()
        XCTAssert(app.staticTexts["Breaths: 2"].exists)
        app.buttons["Start counting"].tap()
        XCTAssert(app.staticTexts["Breaths: 3"].exists)
    }
    
    func test_onCountReset_shouldStopCounting() throws {
        let app = XCUIApplication()
        app.launch()
        app.buttons["Start counting"].tap()
        XCTAssert(app.staticTexts["Breaths: 1"].exists)
        XCTAssert(app.buttons["Reset"].exists)
        app.buttons["Reset"].tap()
        XCTAssert(!app.staticTexts["Breaths: 1"].exists)
    }
    
    func test_onCountEnd_shouldShowResult() throws {
        let app = XCUIApplication()
        app.launch()
        app.buttons["Start counting"].tap()
        app.buttons["Start counting"].tap()
        app.buttons["Start counting"].tap()
        XCTAssert(app.staticTexts["Counted 6 beats per minute."].waitForExistence(timeout: 35))
    }
}
