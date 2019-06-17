//
//  PostList.swift
//  MyDiaryiOSUITests
//
//  Created by Musashi Sakamoto on 2019/06/17.
//  Copyright © 2019 musashi. All rights reserved.
//

import XCTest

class PostList: XCTestCase {
    var app: XCUIApplication!
    var fab: XCUIElement!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        self.app = XCUIApplication()
        self.app.launch()
        self.app.textFields["username"].tap()
        self.app.textFields["username"].typeText("musashi")
        self.app.secureTextFields["password"].tap()
        self.app.secureTextFields["password"].typeText("1292602b")
        self.app.buttons["Login"].tap()
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        self.app = nil
    }

    func test_ポスト作成画面遷移() {
        self.waitForLogin()
        XCTAssertTrue(self.app.staticTexts["PostList"].exists)

        XCTAssertTrue(self.app.buttons["cm add white"].exists, "floating action button exists")
        self.app.buttons["cm add white"].tap()
        XCTAssertTrue(self.app.buttons["Post"].exists, "post button exists")
        XCTAssertTrue(self.app.buttons["Cancel"].exists, "cancel button exists")

        self.app.buttons["Cancel"].tap()

        XCTAssertTrue(self.app.staticTexts["PostList"].exists)
    }

    func test_ログアウト() {
        self.app.buttons["cm menu white"].tap()
        self.app.tables/*@START_MENU_TOKEN@*/.cells.buttons["Logout"]/*[[".cells.buttons[\"Logout\"]",".buttons[\"Logout\"]"],[[[-1,1],[-1,0]]],[1]]@END_MENU_TOKEN@*/.tap()
        XCTAssertTrue(self.app.staticTexts["Login"].exists)
    }

    func test_ポスト作成と削除() {
        self.waitForLogin()
        let title = "title title"
        let description = "type text description type text description type text description type text description type text description type text description type text description "

        XCTAssertTrue(self.app.staticTexts["PostList"].exists)

        XCTAssertTrue(self.app.buttons["cm add white"].exists, "floating action button exists")

        self.app.buttons["cm add white"].tap()

        self.app.textFields["titleTextField"].tap()
        self.app.textFields["titleTextField"].typeText(title)

        self.app.textViews["description"].tap()
        self.app.textViews["description"].typeText(description)
        self.app.buttons["Post"].tap()
        XCTAssertTrue(self.app.staticTexts["PostList"].exists)
        let firstCell = self.app.cells.element(boundBy: 0)
        XCTAssertTrue(firstCell.staticTexts[title].exists, "\(title) exists")

        self.app.cells.element(boundBy: 0).buttons["cm more horiz white"].tap()
        self.app.cells.element(boundBy: 0).buttons["cm delete white"].tap()
        XCTAssertFalse(firstCell.staticTexts[title].exists, "\(title) exists")
    }

    func waitForCondition(element: XCUIElement, predicate: NSPredicate, timeout: TimeInterval = 3) {
        expectation(for: predicate, evaluatedWith: element, handler: nil)
        waitForExpectations(timeout: timeout, handler: nil)
    }

    func waitForLogin() {
        self.waitForCondition(element: self.app.staticTexts["PostList"], predicate: NSPredicate(format: "exists == true"), timeout: 3)
    }

    func waitForHudToDisappear() {
        self.waitForCondition(element: self.app.otherElements["PKHUD"], predicate: NSPredicate(format: "exists == false"), timeout: 5)
    }

    func waitForHudToAppear() {
        self.waitForCondition(element: self.app.otherElements["PKHUD"], predicate: NSPredicate(format: "exists == true"), timeout: 3)
    }
}
