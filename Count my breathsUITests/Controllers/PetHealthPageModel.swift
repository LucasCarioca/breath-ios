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
        openMenu()
        app.cells["Pet health"].tap()
    }
    
    func viewDidLoad() -> Bool {
        app.tables.staticTexts["Why count breaths"].exists
            && app.tables.staticTexts["Dog Heart disease"].exists
    }
}
