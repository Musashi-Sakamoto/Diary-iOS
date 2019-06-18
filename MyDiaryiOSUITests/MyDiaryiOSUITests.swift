//
//  MyDiaryiOSUITests.swift
//  MyDiaryiOSUITests
//
//  Created by 坂元 武佐志 on 2019/06/05.
//  Copyright © 2019 musashi. All rights reserved.
//

import XCTest

class MyDiaryiOSUITests: XCTestCase {
    var app: XCUIApplication!
    var emailTextField: XCUIElement!
    var usernameTextField: XCUIElement!
    var passwordTextField: XCUIElement!
    var loginButton: XCUIElement!
    var signupButton: XCUIElement!
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        self.app = XCUIApplication()
        self.app.launch()
        self.emailTextField = self.app.textFields["email"]
        self.usernameTextField = self.app.textFields["username"]
        self.passwordTextField = self.app.secureTextFields["password"]
        self.loginButton = self.app.buttons["Login"]
        self.signupButton = self.app.buttons["Signup"]

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        self.app = nil
        self.usernameTextField = nil
        self.passwordTextField = nil
        self.loginButton = nil
    }

    func test_ログインサインアップ画面遷移() {
        XCTAssertTrue(self.usernameTextField.exists)
        XCTAssertTrue(self.passwordTextField.exists)

        self.app.buttons["To Signup"].tap()
        XCTAssertTrue(self.emailTextField.exists)
        self.app.buttons["To Login"].tap()
        XCTAssertTrue(self.app.buttons["To Signup"].exists)
    }

    func test_サインアップバリデーション() {
        self.app.buttons["To Signup"].tap()

        self.signupButton.tap()
        self.waitForHudToAppear()
        self.waitForHudToDisappear()

        self.emailTextField.tap()
        self.emailTextField.typeText("dummy@dumcum.com")

        self.signupButton.tap()
        self.waitForHudToAppear()
        self.waitForHudToDisappear()

        self.usernameTextField.tap()

        self.usernameTextField.typeText("musashi")

        self.signupButton.tap()
        self.waitForHudToAppear()
        self.waitForHudToDisappear()

        self.passwordTextField.tap()
        self.passwordTextField.typeText("password")

        self.signupButton.tap()

        self.waitForHudToAppear()
        self.waitForHudToDisappear()

        self.usernameTextField.tap()

        self.usernameTextField.typeText("")

        self.signupButton.tap()
        self.waitForHudToAppear()
        self.waitForHudToDisappear()

        self.usernameTextField.tap()

        self.usernameTextField.typeText("musashi")
    }

    func test_ログインバリデーション() {
        self.usernameTextField.tap()

        self.usernameTextField.typeText("musashi")

        self.loginButton.tap()
        self.waitForHudToAppear()
        self.waitForHudToDisappear()

        self.passwordTextField.tap()
        self.passwordTextField.typeText("password")

        self.loginButton.tap()

        self.waitForHudToAppear()
        self.waitForHudToDisappear()

        self.usernameTextField.tap()

        self.usernameTextField.typeText("")

        self.loginButton.tap()
        self.waitForHudToAppear()
        self.waitForHudToDisappear()
    }

    func test_ログイン成功() {
        self.usernameTextField.tap()

        self.usernameTextField.typeText("musashi")

        self.loginButton.tap()
        self.waitForHudToAppear()
        self.waitForHudToDisappear()

        self.passwordTextField.tap()
        self.passwordTextField.typeText("1292602b")

        self.loginButton.tap()

        XCTAssertTrue(self.app.staticTexts["PostList"].exists)
    }

    func waitForCondition(element: XCUIElement, predicate: NSPredicate, timeout: TimeInterval = 3) {
        expectation(for: predicate, evaluatedWith: element, handler: nil)
        waitForExpectations(timeout: timeout, handler: nil)
    }

    func waitForHudToDisappear() {
        self.waitForCondition(element: self.app.otherElements["PKHUD"], predicate: NSPredicate(format: "exists == false"), timeout: 5)
    }

    func waitForHudToAppear() {
        self.waitForCondition(element: self.app.otherElements["PKHUD"], predicate: NSPredicate(format: "exists == true"), timeout: 3)
    }
}
