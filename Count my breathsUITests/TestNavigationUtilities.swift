//
//  File.swift
//  Count my breathsUITests
//
//  Created by Lucas Desouza on 10/24/20.
//  Copyright © 2020 Lucas Desouza. All rights reserved.
//

import XCTest

public func skipNewVersionPopup(app: XCUIApplication) {
    app.launch()
    if(app.staticTexts["We have made some changes since you last used the app."].exists) {
        app.swipeLeft(velocity: .fast)
        app.swipeLeft(velocity: .fast)
        app.buttons["Continue to app"].tap()
    }
}


