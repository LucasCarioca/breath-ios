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
    
    func backToPetProfiles() {
        openMenu()
        app.cells["Pet profile"].tap()
    }
    
    func viewDidLoad() -> Bool {
        isTargetBPMFieldPresent()
            && isPetNameFieldPresent()
            && isChipIdFieldPresent()
    }
    
    func isTargetBPMFieldPresent() -> Bool {
        findElementWith("Target breathing rate", in: app.tables.buttons).exists
    }
    
    func isPetNameFieldPresent() -> Bool {
        findElementWith("Pet name", in: app.tables.buttons).exists
    }
    
    func isChipIdFieldPresent() -> Bool {
        findElementWith("Chip Id", in: app.tables.buttons).exists
    }
    
    func isTargetBPM(_ bpm: String) -> Bool {
        app.tables.buttons["Target breathing rate: \n\(bpm)"].exists
    }
    
    func isPetName(_ name: String) -> Bool {
        app.tables.buttons["Pet name: \n\(name)"].exists
    }
    
    func isChipId(_ id: String) -> Bool {
        app.tables.buttons["Chip Id: \n\(id)"].exists
    }
    
    func setTargetBPM(to bpm: String) {
        findElementWith("Target breathing rate", in: app.tables.buttons).tap()
        app.pickerWheels.element.adjust(toPickerWheelValue: bpm)
        app.buttons["Save target breathing rate"].tap()
        backToPetProfiles()
    }
    
    func setPetName(to name: String) {
        findElementWith("Pet name", in: app.tables.buttons).tap()
        app.textFields["Pet name"].clearAndEnterText(text: name)
        app.buttons["Save pet name"].tap()
        backToPetProfiles()
    }
    
    func setChipId(to id: String) {
        findElementWith("Chip Id", in: app.tables.buttons).tap()
        app.textFields["Chip Id"].clearAndEnterText(text: id)
        app.buttons["Save chip id"].tap()
        backToPetProfiles()
    }
}
