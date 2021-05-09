//
//  CookEatUITests.swift
//  CookEatUITests
//
//  Created by Rafael Kollyfas on 09/05/2021.
//

import XCTest

class CookEatUITests: XCTestCase {
    
    //IMPORTANT: FOR THE TESTS TO RUN, ON THE SIMULATOR CLICK THE "I/O" SETTING AND THEN SELECT "Keyboard" AND FINALLY DEACTIVATE "Connect Hardware Keyboard".
    private var app: XCUIApplication!
    private var loggedIn = false

    
    //Setup tests.
    override func setUp() {
        continueAfterFailure = false
        self.app = XCUIApplication()
        self.app.launch()
        
        let email = app.textFields["email"]
        
        //Login with an account I created for testing purposes.
        if email.exists && !loggedIn {
            email.tap()
            email.typeText("demo-cookeat21@gmail.com")

            let pwd = app.secureTextFields["password"]
            pwd.tap()
            pwd.typeText("Password!")
            
            app.buttons["Sign In"].tap()
            loggedIn.toggle()
        }
       

    }
    
    //Add a new recipe.
    func testAddRecipe() {
        
        app.buttons["add_recipe"].tap()
        
        let message = app.staticTexts["Add Recipe"]
        XCTAssertTrue(message.waitForExistence(timeout: 5))
    }
    
    //Test feed view.
    func testFeed() {
        app.buttons["Feed"].tap()
        
        let message = app.staticTexts["Feed View"]
        XCTAssertTrue(message.waitForExistence(timeout: 5))
    }
    
    //Test search view.
    func testSearch() {
        app.buttons["Search"].tap()
        
        let message = app.staticTexts["Search"]
        XCTAssertTrue(message.waitForExistence(timeout: 5))
    }
    
    //Test account view.
    func testAccount() {
        app.buttons["Account"].tap()
        
        let message = app.buttons["Sign Out"]
        XCTAssertTrue(message.waitForExistence(timeout: 5))
    }
    
    //Test Contributions view.
    func testContributions() {
        app.buttons["Account"].tap()
        
        sleep(2)
        
        app.buttons["Contributions"].tap()
        
        let message = app.staticTexts["Contributions Sent"]
        XCTAssertTrue(message.waitForExistence(timeout: 5))
    }
    
    //Test Requests view.
    func testRequests() {
        app.buttons["Account"].tap()
        
        sleep(2)
        
        app.buttons["Requests"].tap()
        
        let message = app.staticTexts["Requests Received"]
        XCTAssertTrue(message.waitForExistence(timeout: 5))
    }
    
    //Test profile view.
    func testProfile() {
        app.buttons["Account"].tap()
        
        sleep(2)
        
        app.buttons["Profile"].tap()
        
        let message = app.staticTexts["Followers"]
        XCTAssertTrue(message.waitForExistence(timeout: 5))
    }

    
}
