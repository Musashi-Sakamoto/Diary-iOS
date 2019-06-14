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

struct MockUser: UserInterface {
    var username: String
    var email: String
}

struct MockPost: PostInterface {
    var id: String

    var mainTitle: String

    var description: String

    var updatedAt: String?

    var url: String?

    var media: MediaType?
}

class MyDiaryiOSStateTests: XCTestCase {
    var mainStore: Store<AppState>!
    var posts: [PostInterface]!
    var editedPost: PostInterface!

    override func setUp() {
        super.setUp()
        self.mainStore = Store<AppState>(reducer: appReducer, state: AppState())
        self.posts = [
            MockPost(id: "1", mainTitle: "title1", description: "description1", updatedAt: "12920788:125:11", url: nil, media: nil),
            MockPost(id: "2", mainTitle: "title2", description: "description2", updatedAt: "12920788:125:11", url: nil, media: nil),
            MockPost(id: "3", mainTitle: "title3", description: "description3", updatedAt: "12920788:125:11", url: nil, media: nil)
        ]
        self.editedPost = MockPost(id: "4", mainTitle: "mainTitle", description: "description", updatedAt: "1l23l41;j;", url: nil, media: nil)
    }

    override func tearDown() {
        self.mainStore = nil
        super.tearDown()
    }

    func test_editPostAction() {
        XCTAssertNil(self.mainStore.state.postDataState.editedPost, "edited post should be nil")
        self.mainStore.dispatch(PostDataState.Action.editPosts(post: self.editedPost))
        XCTAssertNotNil(self.mainStore.state.postDataState.editedPost, "edited post should be nil")
        XCTAssertEqual(self.mainStore.state.postDataState.editedPost!.mainTitle, self.editedPost.mainTitle, "title equals")
        self.mainStore.dispatch(PostDataState.Action.addPost)
        XCTAssertNil(self.mainStore.state.postDataState.editedPost, "editedPost should be nil")
    }

    func test_setPostAction() {
        XCTAssertNil(self.mainStore.state.postDataState.posts, "posts data should be nil")
        self.mainStore.dispatch(PostDataState.Action.setPosts(posts: self.posts))
        XCTAssertNotNil(self.mainStore.state.postDataState.posts, "posts data should be nil")
        XCTAssertEqual(self.mainStore.state.postDataState.posts!.count, self.posts.count, "posts data should be nil")
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

        let user = MockUser(username: name, email: email)
        XCTAssertNil(self.mainStore.state.loginUserState.user, "user should be nil")
        self.mainStore.dispatch(LoginUserState.Action.LoginAction(user: user))
        XCTAssertNotNil(self.mainStore.state.loginUserState.user, "user should not be nil")
        XCTAssertEqual(self.mainStore.state.loginUserState.user?.email, email, "email should be \(email)")
        XCTAssertEqual(self.mainStore.state.loginUserState.user?.username, name, "username should be \(name)")
        self.mainStore.dispatch(LoginUserState.Action.LogoutAction)
        XCTAssertNil(self.mainStore.state.loginUserState.user, "user should be nil")
    }
}
