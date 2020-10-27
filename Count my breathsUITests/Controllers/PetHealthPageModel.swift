//
//  InfoPageModel.swift
//  Count my breathsUITests
//
//  Created by Lucas Desouza on 10/25/20.
//  Copyright © 2020 Lucas Desouza. All rights reserved.
//

import XCTest

public class PetHealthPageModel: PageModel {
    var app: XCUIApplication = XCUIApplication()
    
    init() {
        setup()
        clickBackButton()
        app.cells["Pet health"].tap()
    }
    
    func viewDidLoad() -> Bool {
        app.tables.staticTexts["Why count breaths"].exists
            && app.tables.staticTexts["Dog Heart disease"].exists
    }
    
    func isCloseButtonVisible() -> Bool {
        app.buttons["Close"].exists
    }
    
    func openMenuOption(_ option: String) {
        findElementWith(option, in: app.tables.staticTexts).tap()
    }
    
    func clickCloseButton() {
        app.buttons["Close"].tap()
    }
}
