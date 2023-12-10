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
       // app.launchArguments = ["-UITest_startSignedIn"]
        app.launch()
    }
    
    override func tearDownWithError() throws {
        
    }
    func test_UITestingView_signUpButton_shouldSignIn() {
        // Given
        signUpAndSignIn(shouldTypeOnKeyboard: true)
        // When
        let navBar = app.navigationBars["Welcome"]
        // Then
        XCTAssertTrue(navBar.exists)

    }
    
    func test_UITestingView_signUpButton_shouldNotSignIn() {
        // Given
        signUpAndSignIn(shouldTypeOnKeyboard: false)
        // When
        let navBar = app.navigationBars["Welcome"]
        // Then
        XCTAssertFalse(navBar.exists)
    }
    

    
    func test_SignedInHomeView_showAlertButton_shouldDisplayAlert() {
        // Given
        signUpAndSignIn(shouldTypeOnKeyboard: true)
        // When
        let alertButton = app.buttons["ShowAlertButton"].tap()
        
        let alert = app.alerts.firstMatch
                
        // Then
        XCTAssertTrue(alert.exists)
    }
    
    func test_SignedInHomeView_showAlertButton_shouldDisplayAndDismissAlert() {
        // Given
        signUpAndSignIn(shouldTypeOnKeyboard: true)
        // When
        let alertButton = app.buttons["ShowAlertButton"].tap()
        
        let alert = app.alerts.firstMatch
        XCTAssertTrue(alert.exists)
        
        let alertOKButton = alert.buttons["OK"].tap()
        
        // Then
        XCTAssertFalse(alert.exists)
    }
    
    func test_SignedInHomeView_NavigationLinkToDestination_shouldNavigateToDestination() {
        // Given
        let textField = app.textFields["SignUpTextField"]
        // When
        textField.tap()
        
        let keyA = app.keys["A"]
        keyA.tap()
        let keya = app.keys["a"]
        keya.tap()
        keya.tap()
        
        let returnButton = app.buttons["Return"].tap()
        
        let signUpButton = app.buttons["SignUpButton"].tap()

        let navBar = app.navigationBars["Welcome"]

        XCTAssertTrue(navBar.exists)
        
        let navLinkButton = app.buttons["Navigate"].tap()
        
        let destinationText = app.staticTexts["Destination"]
        XCTAssertTrue(destinationText.exists)

        // Then
        XCTAssertTrue(destinationText.exists)
    }
    
    func test_SignedInHomeView_NavigationLinkToDestination_shouldNavigateToDestinationAndGoBack() {
        
        // Given
        let textField = app.textFields["SignUpTextField"]
        // When
        textField.tap()
        
        let keyA = app.keys["A"]
        keyA.tap()
        let keya = app.keys["a"]
        keya.tap()
        keya.tap()
        
        let returnButton = app.buttons["Return"].tap()
        
        let signUpButton = app.buttons["SignUpButton"].tap()

        let navBar = app.navigationBars["Welcome"]

        XCTAssertTrue(navBar.exists)
        
        let navLinkButton = app.buttons["Navigate"].tap()
        
        let destinationText = app.staticTexts["Destination"]
        XCTAssertTrue(destinationText.exists)
        
        let backButton = app.navigationBars.buttons["Welcome"].tap()
        XCTAssertTrue(navBar.exists)

        // Then
        XCTAssertTrue(navBar.exists)
        
    }
}
    // MARK: FUNCTIONS
extension UITestingView_UITest {
    func signUpAndSignIn(shouldTypeOnKeyboard: Bool) {
        let textField = app.textFields["SignUpTextField"]
        textField.tap()
        if shouldTypeOnKeyboard {
            let keyA = app.keys["A"]
            keyA.tap()
            let keya = app.keys["a"]
            keya.tap()
            keya.tap()
        }
        
        
        let returnButton = app.buttons["Return"].tap()
        
        let signUpButton = app.buttons["SignUpButton"].tap()
    }
}
