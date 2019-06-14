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
    var mainStore: Store<AppState>!
    var posts: [Post]!
    var editedPost: Post!

    override func setUp() {
        super.setUp()
        self.mainStore = Store<AppState>(reducer: appReducer, state: AppState())
//        posts = [
//            Post(jsonObject: <#T##JSON#>)
//        ]
    }

    override func tearDown() {
        self.mainStore = nil
        super.tearDown()
    }

    func test_ToggleLoginAction() {
        XCTAssertTrue(self.mainStore.state.loginUserState.isLogin)
        self.mainStore.dispatch(LoginUserState.Action.ToggleLoginAction)
        XCTAssertFalse(self.mainStore.state.loginUserState.isLogin)
        self.mainStore.dispatch(LoginUserState.Action.ToggleLoginAction)
        XCTAssertTrue(self.mainStore.state.loginUserState.isLogin)
    }

//    func test_LoginActionTest() {
//        let name = "name123"
//        let email = "1292602b@gmail.com"
//        XCTAssertEqual(self.mainStore.state.loginUserState.user?.email, "", "email should be empty")
//        XCTAssertEqual(self.mainStore.state.loginUserState.user?.username, "", "username should be empty")
//        self.mainStore.dispatch(LoginUserState.Action.LoginAction(user: <#T##UserInterface?#>)
//        XCTAssertEqual(self.mainStore.state.loginUserState.email, email, "email should be \(email)")
//        XCTAssertEqual(self.mainStore.state.loginUserState.username, name, "username should be \(name)")
//        self.mainStore.dispatch(LoginUserState.Action.LogoutAction)
//        XCTAssertEqual(self.mainStore.state.loginUserState.email, "", "email should be empty")
//        XCTAssertEqual(self.mainStore.state.loginUserState.username, "", "username should be empty")
//    }

//    func test_getPostTest() {
//        <#function body#>
//    }
}
