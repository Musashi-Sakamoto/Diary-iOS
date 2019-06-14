//
//  MockTest.swift
//  MyDiaryiOSTests
//
//  Created by Musashi Sakamoto on 2019/06/14.
//  Copyright © 2019 musashi. All rights reserved.
//

import Alamofire
@testable import MyDiaryiOS
import SwiftyJSON
import XCTest

class MockPostListInteractor: PostListInteractorInterface {
    func getPosts(completion: @escaping PostCompletionBlock) {
        let value: [String: [String: [PostInterface]]] = [
            "posts": [
                "rows": [
                    MockPost(id: "1", mainTitle: "title1", description: "description1", updatedAt: "12920788:125:11", url: nil, media: nil),
                    MockPost(id: "2", mainTitle: "title2", description: "description2", updatedAt: "12920788:125:11", url: nil, media: nil),
                    MockPost(id: "3", mainTitle: "title3", description: "description3", updatedAt: "12920788:125:11", url: nil, media: nil)
                ]
            ]
        ]
        let result = Result<Any>.success(value)
        let httpResponse = HTTPURLResponse(url: Constants.API.URLBase!.appendingPathComponent("posts"), statusCode: 200, httpVersion: nil, headerFields: nil)
        let dataResponse = DataResponse(request: nil, response: httpResponse, data: nil, result: result)
        completion(dataResponse)
    }

    func deletePost(postId: Int, completion: @escaping PostCompletionBlock) {}
}

class MockPostListWireframe: PostListWireframeInterface {
    func popFromNavigationController(animated: Bool) {}

    func dismiss(animated: Bool) {}

    func showErrorAlert(with message: String?) {}

    func showAlert(with title: String?, message: String?) {}

    func navigate(to option: PostListNavigationOption) {}
}

class MockPostListViewController: PostListViewInterface {
    func reloadData() {}
    func setEmptyPlaceholderHidden(_ hidden: Bool) {}
    func setLoadingVisible(_ visible: Bool) {}
}

class MyDiaryiOSAPIMockTests: XCTestCase {
    var presenter: PostListPresenter!
    var vc: MockPostListViewController!
    var interactor: MockPostListInteractor!
    var wireframe: MockPostListWireframe!

    override func setUp() {
        super.setUp()
        self.interactor = MockPostListInteractor()
        self.wireframe = MockPostListWireframe()
        self.vc = MockPostListViewController()
        self.presenter = PostListPresenter(wireframe: self.wireframe, view: self.vc, interactor: self.interactor)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        self.presenter = nil
        super.tearDown()
    }

    func test_getPosts() {
        self.presenter.viewDidLoad()
        XCTAssertEqual(self.presenter.numberOrItems(in: 0), 3, "number should be 3")
    }

    //これいる？
    func test_getPostsInteractor() {
        let testExpectation = expectation(description: "status code 200")
        let callback = { (response: DataResponse<Any>) in
            XCTAssertEqual(response.response!.statusCode, 200, "status code must be 200")
            let jsonObject = JSON(response.result.value)["posts"]["rows"].arrayValue
            XCTAssertEqual(jsonObject.count, 3, "count should be 3")
            testExpectation.fulfill()
        }
        interactor.getPosts(completion: callback)
        wait(for: [testExpectation], timeout: 1)
    }
}
