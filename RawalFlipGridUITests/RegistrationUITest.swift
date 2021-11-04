//
//  RegistrationUITest.swift
//  RawalFlipGridUITests
//
//  Created by Bansri Rawal on 11/3/21.
//

import XCTest
import RawalFlipGrid

class RegistrationUITest: XCTestCase {
    
    let app = XCUIApplication()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method
        app.launchArguments = ["-TESTING"]
        app.launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testRegisterUser() throws {
        let validEmail = "example@example.com"
        let validPassword = "Abc12@defghi!"
        let name = "User"
        let website = "www.example.com"

        let app = XCUIApplication()

        print(app.textFields)
        let nameField = app.textFields[AccessibilityIdentifiers.RegisterScreen.registerNameField]
        nameField.tap()
        nameField.typeText(name)

        let emailField = app.textFields[AccessibilityIdentifiers.RegisterScreen.registerEmailField]
        emailField.tap()
        emailField.typeText(validEmail)

        let passwordField = app.textFields[AccessibilityIdentifiers.RegisterScreen.registerPasswordField]
        passwordField.tap()
        passwordField.typeText(validPassword)

        let webField = app.textFields[AccessibilityIdentifiers.RegisterScreen.registerWebsiteField]
        webField.tap()
        webField.typeText(website)
        
        let registerButton = app.buttons[AccessibilityIdentifiers.RegisterScreen.registerButton]
        registerButton.tap()
        
        XCTAssertTrue(app.staticTexts["Hello, User!"].exists, "Welcome message should be displayed")
        
        
    }
    
    func testRegisterValidation() throws{
        
        let validEmail = "example@example.com"
        let invalidEmail = "example"
        let validPassword = "Abc12@def"
        let invalidPassword = "abcdefg"
        
        let registerButton = app.buttons[AccessibilityIdentifiers.RegisterScreen.registerButton]
        registerButton.tap()
        
        let errorEmail = app.alerts["Invalid Email"]
        XCTAssertTrue(errorEmail.exists, "Email error should exist")
        app.buttons["OK"].tap()
        
        
        let emailField = app.textFields[AccessibilityIdentifiers.RegisterScreen.registerEmailField]
        emailField.tap()
        emailField.typeText(invalidEmail)
        
        let staticErrorEmail = app.staticTexts["Invalid Email"]
        XCTAssertTrue(staticErrorEmail.exists, "Email error should exist")
        emailField.typeText(validEmail)
        XCTAssertTrue(!staticErrorEmail.exists, "Email error should NOT exist")
        
        registerButton.tap()
        
        let errorPassword = app.alerts["Invalid Password"]
        XCTAssertTrue(errorPassword.exists, "Password error should exist")
        app.buttons["OK"].tap()

        let passwordField = app.textFields[AccessibilityIdentifiers.RegisterScreen.registerPasswordField]
        passwordField.tap()
        passwordField.typeText(invalidPassword)
        
        let staticPasswordError = app.staticTexts["Invalid Password"]
        XCTAssertTrue(staticPasswordError.exists, "Password error should exist")
        passwordField.typeText(validPassword)
        XCTAssertTrue(!staticPasswordError.exists, "Password error should NOT exist")
        
        registerButton.tap()
        
        XCTAssertTrue(app.staticTexts["Hello!"].exists, "Welcome message should be displayed")

    }

}
