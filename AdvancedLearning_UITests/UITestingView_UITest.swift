//
//  UITestingView_UITest.swift
//  AdvancedLearning_UITests
//
//  Created by Назар Горевой on 08/12/2023.
//

import XCTest

class UITestingView_UITest: XCTestCase {
    
    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
        
    }
    
    override func tearDownWithError() throws {
        
    }
    func test_UITestingView_signUpButton_shouldSignIn() {
        // Given
        let textField = app.textFields["Add your name..."]
        // When
        textField.tap()
        
        let keyA = app.keys["A"]
        keyA.tap()
        let keya = app.keys["a"]
        keya.tap()
        keya.tap()
        
        let returnButton = app.buttons["Return"].tap()
        
        let signUpButton = app.buttons["Sign up"].tap()

        let navBar = app.navigationBars["Welcome"]
        // Then
        XCTAssertTrue(navBar.exists)

    }
    
    func test_UITestingView_signUpButton_shouldNotSignIn() {
        
    }
    
    
}
    
