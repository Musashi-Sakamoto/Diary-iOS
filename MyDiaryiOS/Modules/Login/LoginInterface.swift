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

protocol LoginViewInterface: ViewInterface {
    func showLogin()
    func showSignup()
    func showSnackBar(text: String)
}

protocol LoginPresenterInterface: PresenterInterface {
    func loginButtonClicked(username: String, password: String)
    func signupButtonClicked(email: String, username: String, password: String)
    func toLoginButtonClicked()
    func setLoginState(isLogin: Bool)
    func isLogin() -> Bool
}

protocol LoginInteractorInterface: InteractorInterface {
    @discardableResult
    func loginUser(username: String, password: String, completion: @escaping LoginCompletionBlock) -> DataRequest

    @discardableResult
    func signupUser(email: String, username: String, password: String, completion: @escaping SignupCompletionBlock) -> DataRequest

    func isLogin() -> Bool
}
