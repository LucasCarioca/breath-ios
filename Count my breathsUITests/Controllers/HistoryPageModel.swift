//
//  HistoryViewController.swift
//  Count my breathsUITests
//
//  Created by Lucas Desouza on 10/24/20.
//  Copyright © 2020 Lucas Desouza. All rights reserved.
//

import XCTest

public class HistoryPageModel: PageModel {
    var app: XCUIApplication = XCUIApplication()
    
    required init() {
        setup()
        clickBackButton()
        app.cells["History"].tap()
    }
    
    public func viewDidLoad() -> Bool {
        app.buttons["List"].exists
            && app.buttons["Graph"].exists
            && app.buttons["Stats"].exists
    }
    
    public func recordExists(with value: Int) -> Bool {
        app.staticTexts["\(value).00"].exists
    }
    
    public func getRecordsCount() -> Int {
        app.tables.cells.count
    }
    
    public func deleteRecord(at index: Int) {
        let tablesQuery = app.tables.cells
        tablesQuery.element(boundBy: index).swipeLeft()
        tablesQuery.element(boundBy: index).buttons["Delete"].tap()
    }
 
}
