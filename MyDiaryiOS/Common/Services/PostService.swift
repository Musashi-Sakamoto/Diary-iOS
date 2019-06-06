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

class PostService: NSObject {
    func getPosts(completion: @escaping PostCompletionBlock) -> DataRequest {
        return SessionManager.default.request(URL(string: Constants.API.URLBase!.appendingPathComponent("posts?limit=50&offset=0").absoluteString.removingPercentEncoding!)!, method: .get).responseJSON(completionHandler: completion)
    }
}
