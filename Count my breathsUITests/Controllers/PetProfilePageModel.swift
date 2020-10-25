//
//  File.swift
//  Count my breathsUITests
//
//  Created by Lucas Desouza on 10/25/20.
//  Copyright © 2020 Lucas Desouza. All rights reserved.
//

import XCTest

public class PetProfilePageModel: PageModel {
    var app: XCUIApplication = XCUIApplication()
    
    init() {
        setup()
        openMenu()
        app.cells["Pet profile"].tap()
    }
    
    func viewDidLoad() -> Bool {
        app.tables.buttons["Target breathing rate: \n30"].exists
            && app.tables.buttons["Pet name: \nMyPet"].exists
            && app.tables.buttons["Chip Id: "].exists
    }
}
