//
//  UserService.swift
//  MyDiaryiOS
//
//  Created by 坂元 武佐志 on 2019/06/05.
//  Copyright © 2019 musashi. All rights reserved.
//

import Alamofire
import Foundation

typealias LoginCompletionBlock = (DataResponse<Any>) -> Void

class UserService: NSObject {
    func loginUser(username: String, password: String, completion: @escaping LoginCompletionBlock) -> DataRequest {
        let parameters: Parameters = [
            "username": username,
            "password": password
        ]
        return Alamofire.request(Constants.API.URLBase!.appendingPathComponent("login"), method: .post, parameters: parameters).responseJSON(completionHandler: completion)
    }
}
