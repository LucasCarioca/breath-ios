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
    
    func test_shouldLoad() throws {
        let historyView = HistoryViewController(app: XCUIApplication())
        XCTAssert(historyView.viewDidLoad())
    }
    
    func test_shouldCreateARecord() throws {
        let historyView = HistoryViewController(app: XCUIApplication())
        historyView.createRecord(at: 5)
        XCTAssert(historyView.recordExists(with: 10))
    }

}
