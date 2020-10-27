//
//  PetProfilePageTests.swift
//  Count my breathsUITests
//
//  Created by Lucas Desouza on 10/25/20.
//  Copyright © 2020 Lucas Desouza. All rights reserved.
//

import XCTest

class PetProfilePageTests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }
    
    override func setUp() {
        super.setUp()
        XCUIApplication().launch()
    }
    
    func test_shouldLoad() {
        let petProfilePage = PetProfilePageModel()
        XCTAssert(petProfilePage.viewDidLoad())
    }
    
    func test_shouldChangeThePetName() {
        let petProfilePage = PetProfilePageModel()
        petProfilePage.setPetName(to: "TestPetName")
        XCTAssert(petProfilePage.isPetName("TestPetName"))
    }
    
    func test_shouldChangeTheChipId() {
        let petProfilePage = PetProfilePageModel()
        petProfilePage.setChipId(to: "1234567")
        XCTAssert(petProfilePage.isChipId("1234567"))
    }
    
    func test_shouldChangeTheTargetBPM() {
        let petProfilePage = PetProfilePageModel()
        petProfilePage.setTargetBPM(to: "50")
        XCTAssert(petProfilePage.isTargetBPM("50"))
    }
}
