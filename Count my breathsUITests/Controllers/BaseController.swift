//
//  BaseController.swift
//  Count my breathsUITests
//
//  Created by Lucas Desouza on 10/24/20.
//  Copyright © 2020 Lucas Desouza. All rights reserved.
//

import XCTest

protocol Controller {
    var app: XCUIApplication { get set }
    func skipNewVersionPopup() -> Void
    func viewDidLoad() -> Bool
    func openMenu() -> Void
}

extension Controller {

    public func setup(){
        skipNewVersionPopup()
    }
    
    public func openMenu() {
        self.app.navigationBars.buttons.element(boundBy: 0).tap()
    }
    
    public func skipNewVersionPopup() {
        if(app.staticTexts["We have made some changes since you last used the app."].exists) {
            app.swipeLeft(velocity: .fast)
            app.swipeLeft(velocity: .fast)
            app.buttons["Continue to app"].tap()
        }
    }

}


