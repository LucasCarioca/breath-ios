//
//  HistoryViewController.swift
//  Count my breathsUITests
//
//  Created by Lucas Desouza on 10/24/20.
//  Copyright © 2020 Lucas Desouza. All rights reserved.
//

import XCTest

public class HistoryViewController: Controller {
    var app: XCUIApplication
    
    required init(app: XCUIApplication) {
        self.app = app
        setup()
        openMenu()
        app.cells["History"].tap()
    }
    
    public func viewDidLoad() -> Bool {
        app.buttons["List"].exists
            && app.buttons["Graph"].exists
            && app.buttons["Stats"].exists
    }
    
    public func createRecord(at beats: Int) {
        openMenu()
        app.cells["Counter"].tap()
        for _ in 0..<beats {
            app.buttons["Start counting"].tap()
        }
        guard app.staticTexts["Counted \(beats * 2) beats per minute."].waitForExistence(timeout: 35) else { return }
        openMenu()
        app.cells["History"].tap()
    }
    
    public func recordExists(with value: Int) -> Bool {
        app.staticTexts["\(value).00"].exists
    }
    
}
