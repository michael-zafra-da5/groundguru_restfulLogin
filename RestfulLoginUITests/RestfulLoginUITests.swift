//
//  RestfulLoginUITests.swift
//  RestfulLoginUITests
//
//  Created by Michael Angelo Zafra on 1/13/22.
//

import XCTest

class RestfulLoginUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
    
    func testNavigation() throws {
        let app = XCUIApplication()
        let emailTextField = app.textFields["emailTF"]
        XCTAssertTrue(emailTextField.exists, "Text field email doesn't exist")
        emailTextField.tap()
        emailTextField.clearText(andReplaceWith: "sample@gmail.com")
        XCTAssertEqual(emailTextField.value as! String, "sample@gmail.com", "Text field value is not correct")
        sleep(2)
        
        let email = app.textFields.element(boundBy: 0)
        let pass = app.secureTextFields.element(boundBy: 0)
        XCTAssertTrue(email.exists, "Text field email doesn't exist")
        XCTAssertTrue(pass.exists, "Text field password doesn't exist")
        pass.tap()
        pass.typeText("123456")
//        XCTAssertEqual(pass.value as! String, "123456", "Text field value is not correct")
        
        let button = app.buttons["Login"]
        XCTAssertTrue(button.exists, "button doesn't exist")
        button.tap()
    }

//    func testRestLoginPage() throws {
//        let app = XCUIApplication()
//        let login = app.buttons["Login"]
//        let email = app.staticTexts["Email"]
//        let password = app.staticTexts["Password"]
////        let register = app.staticTexts["registerLbl"]
//
////        if login.isEnabled {
////            XCTAssertTrue(register.exists)
////        } else {
////            XCTAssertFalse(register.exists)
////        }
//        XCTAssertTrue(login.exists)
//        XCTAssertTrue(email.exists)
//        XCTAssertTrue(password.exists)
//
//        app.buttons["Login"].tap()
////        XCTAssertTrue(register.exists, "Missing Register")
////        let alert = app.alerts["myAlert"]
////        if alert.exists {
////            let button = alert.buttons["OK"]
////            button.tap()
////        }
//    }
    
    override func setUp() {
        continueAfterFailure = false
        let app = XCUIApplication()
        app.launch()
        addUIInterruptionMonitor(withDescription: "System Dialog") {
          (alert) -> Bool in
          let okButton = alert.buttons["OK"]
          if okButton.exists {
            okButton.tap()
          }

          return true
        }
    }
}

extension XCUIElement {
    func clearText(andReplaceWith newText:String? = nil) {
        tap()
        press(forDuration: 1.0)
        var select = XCUIApplication().menuItems["Select All"]

        if !select.exists {
            select = XCUIApplication().menuItems["Select"]
        }
        //For empty fields there will be no "Select All", so we need to check
        if select.waitForExistence(timeout: 0.5), select.exists {
            select.tap()
            typeText(String(XCUIKeyboardKey.delete.rawValue))
        } else {
            tap()
        }
        if let newVal = newText {
            typeText(newVal)
        }
    }
}
