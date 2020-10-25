//
//  CounterViewController.swift
//  Count my breathsUITests
//
//  Created by Lucas Desouza on 10/24/20.
//  Copyright © 2020 Lucas Desouza. All rights reserved.
//

import XCTest

public class CounterViewController: Controller {
    var app: XCUIApplication
    
    required init(app: XCUIApplication) {
        self.app = app
        setup()
    }
    
    public func viewDidLoad() -> Bool {
        isCounterButtonVisible() && isInitialInstructionVisible()
    }
    
    public func isInitialInstructionVisible() -> Bool {
        app.staticTexts["Click on the heart below to start counting"].exists
    }
    
    public func isCounterButtonVisible() -> Bool{
        app.buttons["Start counting"].exists
    }
    
    public func isResetButtonVisible() -> Bool {
        app.buttons["Reset"].exists
    }
    
    public func isCounter(at value: Int) -> Bool {
        app.staticTexts["Breaths: \(value)"].exists
    }
    
    public func isTimer(at value: Int) -> Bool {
        app.staticTexts["Seconds remaining \(value)"].exists
    }
    
    public func isResult(at value: Int, timeout: Double) -> Bool {
        app.staticTexts["Counted \(value) beats per minute."].waitForExistence(timeout: timeout)
    }
    
    public func clickCountBreathButton() {
        app.buttons["Start counting"].tap()
    }
    
    public func clickCountBreathButton(times: Int) {
        for _ in 0..<times {
            clickCountBreathButton()
        }
    }
    
    public func clickResetButton() {
        app.buttons["Reset"].tap()
    }
}
