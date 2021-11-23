//
//  HistoryViewController.swift
//  Count my breathsUITests
//
//  Created by Lucas Desouza on 10/24/20.
//  Copyright © 2020 Lucas Desouza. All rights reserved.
//

import XCTest

class HistoryPageTests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func setUp() {
        super.setUp()
        XCUIApplication().launch()
    }

    func test_shouldLoad() throws {
        let historyPage = HistoryPageModel()
        XCTAssert(historyPage.viewDidLoad())
    }

    func test_shouldCreateARecord() throws {
        let counterPage = CounterPageModel()
        counterPage.clickCountBreathButton(times: 5)
        XCTAssert(counterPage.isResult(at: 10, timeout: 35))
        let historyPage = HistoryPageModel()
        XCTAssert(historyPage.recordExists(with: 10))
    }

    func test_shouldDeleteARecord() throws {
        let counterPage = CounterPageModel()
        counterPage.clickCountBreathButton(times: 2)
        XCTAssert(counterPage.isResult(at: 4, timeout: 35))
        let historyPage = HistoryPageModel()
        let expectedRowCount = historyPage.getRecordsCount() - 6
        print(expectedRowCount)
        historyPage.deleteRecord(at: 0)
        XCTAssert(historyPage.getRecordsCount() == expectedRowCount, "Expect \(historyPage.getRecordsCount()) to be \(expectedRowCount)")
    }

}
