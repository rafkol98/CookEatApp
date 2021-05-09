//
//  CookEatUITests.swift
//  CookEatUITests
//
//  Created by Rafael Kollyfas on 09/05/2021.
//

import XCTest

class CookEatUITests: XCTestCase {
    
    private var app: XCUIApplication!
    
    //Setup tests.
    override func setUp() {
        continueAfterFailure = false
        self.app = XCUIApplication()
        self.app.launch()
    }
    
    
    //Add a new recipe.
    func testAddRecipe() {
        app.buttons["add_recipe"].tap()
        
        let message = app.staticTexts["Add Recipe"]
        XCTAssertTrue(message.waitForExistence(timeout: 5))
    }
    
    
}
