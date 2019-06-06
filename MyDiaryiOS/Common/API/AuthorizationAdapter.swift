//
//  AuthorizationAdapter.swift
//  MyDiaryiOS
//
//  Created by 坂元 武佐志 on 2019/06/05.
//  Copyright © 2019 musashi. All rights reserved.
//

import Alamofire
import Foundation

class AuthorizationAdapter: RequestAdapter {
    static let shared = AuthorizationAdapter()

    var authorizationHeader: String?

    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        var urlRequest = urlRequest
        urlRequest.setValue(self.authorizationHeader, forHTTPHeaderField: Constants.API.AuthorizationHeader)
        return urlRequest
    }
}
