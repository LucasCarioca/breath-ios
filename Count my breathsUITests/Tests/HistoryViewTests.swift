//
//  HistoryViewController.swift
//  Count my breathsUITests
//
//  Created by Lucas Desouza on 10/24/20.
//  Copyright © 2020 Lucas Desouza. All rights reserved.
//

import XCTest

class HistoryViewTests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }
    
    override func setUp() {
        super.setUp()
        XCUIApplication().launch()
    }
    
    func test_shouldLoad() throws {
        let historyView = HistoryViewController()
        XCTAssert(historyView.viewDidLoad())
    }
    
    func test_shouldCreateARecord() throws {
        let counterView = CounterViewController()
        counterView.clickCountBreathButton(times: 5)
        XCTAssert(counterView.isResult(at: 10, timeout: 35))
        let historyView = HistoryViewController()
        XCTAssert(historyView.recordExists(with: 10))
    }
    
    func test_shouldDeleteARecord() throws {
        let counterView = CounterViewController()
        counterView.clickCountBreathButton(times: 2)
        XCTAssert(counterView.isResult(at: 4, timeout: 35))
        let historyView = HistoryViewController()
        let expectedRowCount = historyView.getRecordsCount()-6
        print(expectedRowCount)
        historyView.deleteRecord(at: 0)
        XCTAssert(historyView.getRecordsCount() == expectedRowCount, "Expect \(historyView.getRecordsCount()) to be \(expectedRowCount)")
    }

}
