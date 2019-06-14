//
//  MyDiaryiOSTests.swift
//  MyDiaryiOSTests
//
//  Created by 坂元 武佐志 on 2019/06/05.
//  Copyright © 2019 musashi. All rights reserved.
//

@testable import MyDiaryiOS
import ReSwift
import XCTest

class MyDiaryiOSStateTests: XCTestCase {
    let mainStore = Store<AppState>(reducer: appReducer, state: AppState())

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_ToggleLoginAction() {
        XCTAssertTrue(self.mainStore.state.loginUserState.isLogin)
        self.mainStore.dispatch(LoginUserState.Action.ToggleLoginAction)
        XCTAssertFalse(self.mainStore.state.loginUserState.isLogin)
        self.mainStore.dispatch(LoginUserState.Action.ToggleLoginAction)
        XCTAssertTrue(self.mainStore.state.loginUserState.isLogin)
    }

    func test_LoginActionTest() {
        let name = "name123"
        let email = "1292602b@gmail.com"
        XCTAssertEqual(self.mainStore.state.loginUserState.email, "", "email should be empty")
        XCTAssertEqual(self.mainStore.state.loginUserState.username, "", "username should be empty")
        self.mainStore.dispatch(LoginUserState.Action.LoginAction(username: name, email: email))
        XCTAssertEqual(self.mainStore.state.loginUserState.email, email, "email should be \(email)")
        XCTAssertEqual(self.mainStore.state.loginUserState.username, name, "username should be \(name)")
    }
    
}
