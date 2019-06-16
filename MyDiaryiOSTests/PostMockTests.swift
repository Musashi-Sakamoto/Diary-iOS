//
//  PostMockTests.swift
//  MyDiaryiOSTests
//
//  Created by Musashi Sakamoto on 2019/06/16.
//  Copyright © 2019 musashi. All rights reserved.
//

import Alamofire
@testable import MyDiaryiOS
import SwiftyJSON
import XCTest

class MockPostInteractor: PostInteractorInterface {
    var isCreatePostAPICalled = false
    var isEditPostAPICalled = false
    var isCreateImageAPICalled = false
    var editedPost: PostInterface?
    func creartePost(title: String, description: String, completion: @escaping PostCompletionBlock) {
        self.isCreatePostAPICalled = true
        let post = MockPost(id: "1", mainTitle: title, description: description, updatedAt: nil, url: nil, media: nil)
        let result = Result<Any>.success(post)
        let httpResponse = HTTPURLResponse(url: Constants.API.URLBase!.appendingPathComponent("posts"), statusCode: 201, httpVersion: nil, headerFields: nil)
        let dataResponse = DataResponse(request: nil, response: httpResponse, data: nil, result: result)
        completion(dataResponse)
    }

    func editPost(title: String, description: String, postId: Int, completion: @escaping PostCompletionBlock) {
        self.isEditPostAPICalled = true
        let post = MockPost(id: "", mainTitle: title, description: description, updatedAt: nil, url: nil, media: nil)
        let result = Result<Any>.success(post)
        let httpResponse = HTTPURLResponse(url: Constants.API.URLBase!.appendingPathComponent("posts/\(postId)"), statusCode: 204, httpVersion: nil, headerFields: nil)
        let dataResponse = DataResponse(request: nil, response: httpResponse, data: nil, result: result)
        completion(dataResponse)
    }

    func createImage(data: Data, postId: Int, isImage: Bool, completion: @escaping ImageCompletionBlock) {
        self.isCreateImageAPICalled = true
        let result = Result<Any>.success("image")
        let httpResponse = HTTPURLResponse(url: Constants.API.URLBase!.appendingPathComponent("images"), statusCode: 201, httpVersion: nil, headerFields: nil)
        let dataResponse = DataResponse(request: nil, response: httpResponse, data: nil, result: result)
        completion(dataResponse)
    }

    func getEditedPost() -> PostInterface? {
        return self.editedPost
    }
}

class MockPostWireframe: PostWireframeInterface {
    var errorAlertText: String?
    var isNavigateToPostListCalled = false
    var isNavigateToLibraryCalled = false

    func navigate(to option: PostNavigationOption) {
        switch option {
        case .dismiss:
            self.isNavigateToPostListCalled = true
        case .library:
            self.isNavigateToLibraryCalled = true
        default:
            print("default")
        }
    }

    func popFromNavigationController(animated: Bool) {}

    func dismiss(animated: Bool) {}

    func showErrorAlert(with message: String?) {
        self.errorAlertText = message
    }

    func showAlert(with title: String?, message: String?) {}
}

class MockPostViewController: PostViewInterface {
    var isShowEditedPostCalled = false
    func showEditedPost(post: PostInterface?) {
        self.isShowEditedPostCalled = true
    }
}

class PostMockTests: XCTestCase {
    var presenter: PostPresenterInterface!
    var vc: MockPostViewController!
    var interactor: MockPostInteractor!
    var wireframe: MockPostWireframe!

    override func setUp() {
        super.setUp()
        self.interactor = MockPostInteractor()
        self.wireframe = MockPostWireframe()
        self.vc = MockPostViewController()
        self.presenter = PostPresenter(wireframe: self.wireframe, view: self.vc, interactor: self.interactor)
    }

    override func tearDown() {
        self.interactor = nil
        self.wireframe = nil
        self.vc = nil
        self.presenter = nil
        super.tearDown()
    }

    func test_ポスト作成() {
        XCTAssertFalse(self.presenter.isEditing())
        XCTAssertFalse(self.interactor.isCreatePostAPICalled)
        self.presenter.postButtonClicked(title: "", description: "", data: nil, isImage: true)
        XCTAssertFalse(self.interactor.isCreatePostAPICalled)
        self.presenter.postButtonClicked(title: "title", description: "", data: nil, isImage: true)
        XCTAssertFalse(self.interactor.isCreatePostAPICalled)
        self.presenter.postButtonClicked(title: "title", description: "description", data: nil, isImage: true)
        XCTAssertTrue(self.interactor.isCreatePostAPICalled)
        XCTAssertTrue(self.wireframe.isNavigateToPostListCalled)
    }

    func test_ポスト編集() {
        let post = MockPost(id: "1", mainTitle: "mainTitle", description: "description", updatedAt: "1292/07/13 18:34:00", url: nil, media: nil)
        interactor.editedPost = post
        XCTAssertTrue(self.presenter.isEditing())
        XCTAssertFalse(self.interactor.isEditPostAPICalled)
        self.presenter.editButtonClicked(title: "", description: "", postId: Int(post.id)!, data: nil, isImage: true)
        XCTAssertFalse(self.interactor.isEditPostAPICalled)
        self.presenter.editButtonClicked(title: "", description: "edit description", postId: Int(post.id)!, data: nil, isImage: true)
        XCTAssertFalse(self.interactor.isEditPostAPICalled)
        self.presenter.editButtonClicked(title: "title", description: "edit description", postId: Int(post.id)!, data: nil, isImage: true)
        XCTAssertTrue(self.interactor.isEditPostAPICalled)
        XCTAssertTrue(self.wireframe.isNavigateToPostListCalled)
    }

    func test_ポスト写真選択() {
        XCTAssertFalse(self.wireframe.isNavigateToLibraryCalled)
        self.presenter.addMediaButtonClicked()
        XCTAssertTrue(self.wireframe.isNavigateToLibraryCalled)

        self.presenter.postButtonClicked(title: "title", description: "description", data: Data(), isImage: true)
        XCTAssertTrue(self.interactor.isCreateImageAPICalled)
    }

    func test_キャンセルボタンを押した時にポストリストに線維() {
        XCTAssertFalse(self.wireframe.isNavigateToPostListCalled)
        self.presenter.cancelButtonClicked()
        XCTAssertTrue(self.wireframe.isNavigateToPostListCalled)
    }
}
