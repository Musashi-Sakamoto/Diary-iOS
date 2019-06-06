//
//  LoginInteractor.swift
//  MyDiaryiOS
//
//  Created by 坂元 武佐志 on 2019/06/05.
//  Copyright © 2019 musashi. All rights reserved.
//

import Alamofire
import Foundation

final class LoginInteractor {
    private var _userService = UserService()
}

extension LoginInteractor: LoginInteractorInterface {
    @discardableResult
    func loginUser(username: String, password: String, completion: @escaping LoginCompletionBlock) -> DataRequest {
        return self._userService.loginUser(username: username, password: password, completion: completion)
    }
}
