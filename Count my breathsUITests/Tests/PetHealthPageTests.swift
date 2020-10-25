//
//  PetHealthPageTests.swift
//  Count my breathsUITests
//
//  Created by Lucas Desouza on 10/25/20.
//  Copyright © 2020 Lucas Desouza. All rights reserved.
//

import XCTest

class PetHealthPageTests: XCTestCase {
    override func setUpWithError() throws {
        continueAfterFailure = false
    }
    
    override func setUp() {
        super.setUp()
        XCUIApplication().launch()
    }
    
    func test_shouldLoad() {
        let petHealthModel = PetHealthPageModel()
        XCTAssert(petHealthModel.viewDidLoad())
    }
}
