//
//  extensions.swift
//  Count my breathsUITests
//
//  Created by Lucas Desouza on 10/26/20.
//  Copyright © 2020 Lucas Desouza. All rights reserved.
//

import XCTest

extension XCUIElement {
    /**
     Removes any current text in the field before typing in the new value
     - Parameter text: the text to enter into the field
     */
    func clearAndEnterText(text: String) {
        guard let stringValue = self.value as? String else {
            XCTFail("Tried to clear and enter text into a non string value")
            return
        }

        self.tap()

        let deleteString = String(repeating: XCUIKeyboardKey.delete.rawValue, count: stringValue.count)

        self.typeText(deleteString)
        self.typeText(text)
    }
}

func findElementWith(_ value: String, in query: XCUIElementQuery) -> XCUIElement {
    return query.containing(NSPredicate(format: "label CONTAINS[c] '\(value)'")).element
}
