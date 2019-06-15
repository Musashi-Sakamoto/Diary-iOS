//
//  MyDiaryiOSLoginMockTests.swift
//  MyDiaryiOSTests
//
//  Created by Musashi Sakamoto on 2019/06/15.
//  Copyright © 2019 musashi. All rights reserved.
//

import Alamofire
@testable import MyDiaryiOS
import SwiftyJSON
import XCTest

struct MockError: Error {
    var message: String?
}

extension MockUser {
    var password: String {
        return "password"
    }
}

class MockLoginInteractor: LoginInteractorInterface {
    var mockUser: MockUser?
    var isSignupAPICalled = false
    var isLoginAPICalled = false
    func signupUser(email: String, username: String, password: String, completion: @escaping SignupCompletionBlock) {
        self.isSignupAPICalled = true
        var result: Result<Any>!
        var httpResponse: HTTPURLResponse!
        if self.mockUser?.username == username || self.mockUser?.email == email {
            result = Result<Any>.failure(MockError(message: "user already exists"))
            httpResponse = HTTPURLResponse(url: Constants.API.URLBase!.appendingPathComponent("users"), statusCode: 409, httpVersion: nil, headerFields: nil)

        } else {
            self.mockUser = MockUser(username: username, email: email)
            result = Result<Any>.success(self.mockUser)
            httpResponse = HTTPURLResponse(url: Constants.API.URLBase!.appendingPathComponent("users"), statusCode: 201, httpVersion: nil, headerFields: nil)
        }
        let dataResponse = DataResponse(request: nil, response: httpResponse, data: nil, result: result)
        completion(dataResponse)
    }

    func isLogin() -> Bool {
        return true
    }

    func loginUser(username: String, password: String, completion: @escaping LoginCompletionBlock) {
        self.isLoginAPICalled = true
        self.mockUser = MockUser(username: "username", email: "email@mock.com")
        var result: Result<Any>!
        var httpResponse: HTTPURLResponse!
        if self.mockUser?.username == username, self.mockUser?.password == password {
            result = Result<Any>.success(self.mockUser)
            httpResponse = HTTPURLResponse(url: Constants.API.URLBase!.appendingPathComponent("login"), statusCode: 200, httpVersion: nil, headerFields: nil)
        } else {
            result = Result<Any>.failure(MockError(message: "not correct credentials"))
            httpResponse = HTTPURLResponse(url: Constants.API.URLBase!.appendingPathComponent("login"), statusCode: 400, httpVersion: nil, headerFields: nil)
        }
        let dataResponse = DataResponse(request: nil, response: httpResponse, data: nil, result: result)
        completion(dataResponse)
    }
}

class MockLoginWireframe: LoginWireframeInterface {
    var errorAlertText: String?
    var isNavigateToPostListCalled = false
    func popFromNavigationController(animated: Bool) {}

    func dismiss(animated: Bool) {}

    func showErrorAlert(with message: String?) {
        self.errorAlertText = message
    }

    func showAlert(with title: String?, message: String?) {}

    func navigate(to option: LoginNavigationOption) {
        switch option {
        case .postList:
            self.isNavigateToPostListCalled = true
        default:
            print("default")
        }
    }
}

class MockLoginViewController: LoginViewInterface {
    var snackBarText: String?
    func showLogin() {}

    func showSignup() {}

    func showSnackBar(text: String) {
        self.snackBarText = text
    }
}

class MyDiaryiOSLoginMockTests: XCTestCase {
    var presenter: LoginPresenterInterface!
    var vc: MockLoginViewController!
    var interactor: MockLoginInteractor!
    var wireframe: MockLoginWireframe!

    override func setUp() {
        super.setUp()
        self.interactor = MockLoginInteractor()
        self.wireframe = MockLoginWireframe()
        self.vc = MockLoginViewController()
        self.presenter = LoginPresenter(wireframe: self.wireframe, view: self.vc, interactor: self.interactor)
    }

    override func tearDown() {
        self.interactor = nil
        self.wireframe = nil
        self.vc = nil
        self.presenter = nil
        super.tearDown()
    }

    func test_サインアップバリデーション() {
        XCTAssertFalse(self.interactor.isSignupAPICalled)
        self.presenter.signupButtonClicked(email: "", username: "username", password: "password")
        XCTAssertFalse(self.interactor.isSignupAPICalled)
        self.presenter.signupButtonClicked(email: "email@mock.com", username: "", password: "password")
        XCTAssertFalse(self.interactor.isSignupAPICalled)
        self.presenter.signupButtonClicked(email: "email@mock.com", username: "username", password: "")
        XCTAssertFalse(self.interactor.isSignupAPICalled)
        self.presenter.signupButtonClicked(email: "email@mock.com", username: "username", password: "password")
        XCTAssertTrue(self.interactor.isSignupAPICalled, "signup api should be called")
    }

    func test_ログインバリデーション() {
        XCTAssertFalse(self.interactor.isLoginAPICalled)
        self.presenter.loginButtonClicked(username: "", password: "password")
        XCTAssertFalse(self.interactor.isLoginAPICalled)
        self.presenter.loginButtonClicked(username: "username", password: "")
        XCTAssertFalse(self.interactor.isLoginAPICalled)
        self.presenter.loginButtonClicked(username: "username", password: "password")
        XCTAssertTrue(self.interactor.isLoginAPICalled, "login api should be called")
    }

    func test_ログイン() {
        self.presenter.loginButtonClicked(username: "username2", password: "password")
        XCTAssertTrue(self.interactor.isLoginAPICalled, "login api should be called")
        XCTAssertNotNil(self.wireframe.errorAlertText, "error text should not be nil")
        XCTAssertFalse(self.wireframe.isNavigateToPostListCalled, "should not be navigated")
        
        self.presenter.loginButtonClicked(username: "username", password: "password2")
        XCTAssertTrue(self.interactor.isLoginAPICalled, "login api should be called")
        XCTAssertNotNil(self.wireframe.errorAlertText, "error text should not be nil")
        XCTAssertFalse(self.wireframe.isNavigateToPostListCalled, "should not be navigated")
        
        self.presenter.loginButtonClicked(username: "username", password: "password")
        XCTAssertTrue(self.interactor.isLoginAPICalled, "login api should be called")
        XCTAssertTrue(self.wireframe.isNavigateToPostListCalled, "should be navigated")
    }

    func test_サインアップ() {
        XCTAssertNil(self.vc.snackBarText)
        self.presenter.signupButtonClicked(email: "email@mock.com", username: "username", password: "password")
        XCTAssertTrue(self.interactor.isSignupAPICalled, "signup api should be called")
        XCTAssertNotNil(self.vc.snackBarText, "snackbar text should not be nil")

        self.presenter.signupButtonClicked(email: "email@mock.com", username: "username", password: "password")
        XCTAssertTrue(self.interactor.isSignupAPICalled, "login api should be called")
        XCTAssertNotNil(self.wireframe.errorAlertText, "error occurred")
    }
}
