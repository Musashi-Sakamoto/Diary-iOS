//
//  PostService.swift
//  MyDiaryiOS
//
//  Created by 坂元 武佐志 on 2019/06/06.
//  Copyright © 2019 musashi. All rights reserved.
//

import Alamofire
import Foundation

typealias PostCompletionBlock = (DataResponse<Any>) -> Void
typealias ImageCompletionBlock = (DataResponse<Any>) -> Void

class PostService: NSObject {
    @discardableResult
    func getPosts(completion: @escaping PostCompletionBlock) -> DataRequest {
        return SessionManager.default.request(URL(string: Constants.API.URLBase!.appendingPathComponent("posts?limit=20&offset=0").absoluteString.removingPercentEncoding!)!, method: .get).responseJSON(completionHandler: completion)
    }

    @discardableResult
    func deletePost(_ postId: Int, completion: @escaping PostCompletionBlock) -> DataRequest {
        return SessionManager.default.request(Constants.API.URLBase!.appendingPathComponent("posts/\(postId)"), method: .delete).responseJSON(completionHandler: completion)
    }

    @discardableResult
    func editPost(title: String, description: String, postId: Int, completion: @escaping PostCompletionBlock) -> DataRequest {
        let parameters: Parameters = [
            "title": title,
            "description": description
        ]

        return SessionManager.default.request(Constants.API.URLBase!.appendingPathComponent("posts/\(postId)"), method: .put, parameters: parameters).responseJSON(completionHandler: completion)
    }

    @discardableResult
    func createPost(title: String, description: String, completion: @escaping PostCompletionBlock) -> DataRequest {
        let parameters: Parameters = [
            "title": title,
            "description": description
        ]
        return SessionManager.default.request(Constants.API.URLBase!.appendingPathComponent("posts"), method: .post, parameters: parameters).responseJSON(completionHandler: completion)
    }

    func uploadImage(data: Data, postId: Int, isImage: Bool, completion: @escaping ImageCompletionBlock) {
        return SessionManager.default.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(data, withName: "image", fileName: "\(postId)", mimeType: isImage ? "image/jpeg" : "video/mp4")
        }, to: Constants.API.URLBase!.appendingPathComponent("images")) { encodingResult in
            switch encodingResult {
            case .success(let upload, _, _):
                upload.responseJSON(completionHandler: { response in
                    completion(response)
                })
            case let .failure(error):
                print(error)
            }
        }
    }
}
