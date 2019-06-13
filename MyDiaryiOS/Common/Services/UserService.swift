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
typealias SignupCompletionBlock = (DataResponse<Any>) -> Void
typealias LogoutCompletionBlock = (DataResponse<Any>) -> Void

class UserService: NSObject {
    @discardableResult
    func loginUser(username: String, password: String, completion: @escaping LoginCompletionBlock) -> DataRequest {
        let parameters: Parameters = [
            "username": username,
            "password": password
        ]
        return Alamofire.request(Constants.API.URLBase!.appendingPathComponent("login"), method: .post, parameters: parameters).responseJSON(completionHandler: completion)
    }

    @discardableResult
    func signupUser(email: String, username: String, password: String, completion: @escaping SignupCompletionBlock) -> DataRequest {
        let parameters: Parameters = [
            "email": email,
            "name": username,
            "password": password
        ]
        return Alamofire.request(Constants.API.URLBase!.appendingPathComponent("users"), method: .post, parameters: parameters).responseJSON(completionHandler: completion)
    }

    @discardableResult
    func logoutUser(completion: @escaping LogoutCompletionBlock) -> DataRequest {
        return SessionManager.default.request(Constants.API.URLBase!.appendingPathComponent("logout"), method: .get).responseJSON(completionHandler: completion)
    }
}
