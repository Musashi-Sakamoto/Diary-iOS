//
//  MyDiaryiOSAPIMockTests.swift
//  MyDiaryiOSAPIMockTests
//
//  Created by Musashi Sakamoto on 2019/06/14.
//  Copyright © 2019 musashi. All rights reserved.
//

// class MockPostListInteractor: PostListInteractorInterface {
//    func getPosts(completion: @escaping PostCompletionBlock) -> DataRequest {
//        return Res
//    }
//
//    func deletePost(postId: Int, completion: @escaping PostCompletionBlock) -> DataRequest {
//        <#code#>
//    }
// }

import Alamofire
@testable import MyDiaryiOS
import XCTest

class MyDiaryiOSAPIMockTests: XCTestCase {
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
