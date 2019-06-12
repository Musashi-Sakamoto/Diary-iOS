//
//  LoginInterface.swift
//  MyDiaryiOS
//
//  Created by 坂元 武佐志 on 2019/06/05.
//  Copyright © 2019 musashi. All rights reserved.
//

import Alamofire
import Foundation

enum LoginNavigationOption {
    case postList
}

protocol LoginWireframeInterface: WireframeInterface {
    func navigate(to option: LoginNavigationOption)
}

protocol LoginViewInterface: ViewInterface {}

protocol LoginPresenterInterface: PresenterInterface {
    func loginButtonClicked(username: String, password: String)
}

protocol LoginInteractorInterface: InteractorInterface {
    @discardableResult
    func loginUser(username: String, password: String, completion: @escaping LoginCompletionBlock) -> DataRequest
}
