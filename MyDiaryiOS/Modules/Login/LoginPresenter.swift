//
//  LoginPresenter.swift
//  MyDiaryiOS
//
//  Created by 坂元 武佐志 on 2019/06/05.
//  Copyright © 2019 musashi. All rights reserved.
//

import Alamofire
import Foundation
import SwiftyJSON

final class LoginPresenter {
    private unowned let _view: LoginViewInterface
    private let _interactor: LoginInteractorInterface
    private let _wireframe: LoginWireframeInterface
    private let _authorizationManager: AuthorizationAdapter

    init(wireframe: LoginWireframeInterface, view: LoginViewInterface, interactor: LoginInteractorInterface, authorizationManager: AuthorizationAdapter = AuthorizationAdapter.shared) {
        self._wireframe = wireframe
        self._view = view
        self._interactor = interactor
        self._authorizationManager = authorizationManager
    }
}

extension LoginPresenter: LoginPresenterInterface {
    func signupButtonClicked(email: String, username: String, password: String) {
        guard email.count > 0 else {
            _showEmailValidationError()
            return
        }
        
        guard username.count > 0 else {
            _showUsernameValidationError()
            return
        }
        
        guard password.count > 0 else {
            _showPasswordValidationError()
            return
        }
        
        _interactor.signupUser(email: email, username: username, password: password) { [weak self] response in
            self?._handleSignupResult(response)
        }
    }
    
    func isLogin() -> Bool {
        return _interactor.isLogin()
    }
    
    func toLoginButtonClicked() {
        mainStore.dispatch(LoginUserState.Action.ToggleLoginAction)
    }

    func setLoginState(isLogin: Bool) {
        if isLogin {
            self._view.showLogin()
        } else {
            self._view.showSignup()
        }
    }
    
    func loginButtonClicked(username: String, password: String) {
        guard username.count > 0 else {
            _showUsernameValidationError()
            return
        }

        guard password.count > 0 else {
            _showPasswordValidationError()
            return
        }

        self._interactor.loginUser(username: username, password: password) { [weak self] response in
            self?._handleLoginResult(response)
        }
    }
}

private extension LoginPresenter {
    private func _handleLoginResult(_ response: DataResponse<Any>) {
        print(response.result.value)
        switch response.response!.statusCode {
        case 200:
            let user = JSON(response.result.value)
            mainStore.dispatch(LoginUserState.Action.LoginAction(username: user["user"]["name"].stringValue, email: user["user"]["email"].stringValue))
            self._authorizationManager.authorizationHeader = "Bearer \(user["token"].stringValue)"
            self._wireframe.navigate(to: .postList)
        default:
            let error = JSON(response.result.value)
            self._wireframe.showErrorAlert(with: error["error"]["message"].stringValue)
        }
    }
    
    private func _handleSignupResult(_ response: DataResponse<Any>) {
        print(response.result.value)
        switch response.response!.statusCode {
        case 201:
            let user = JSON(response.result.value)
        default:
            let error = JSON(response.result.value)
            self._wireframe.showErrorAlert(with: error["error"]["message"].stringValue)
        }
    }
    
    func _showEmailValidationError() {
        self._wireframe.showAlert(with: "Error", message: "Please enter valid email")
    }

    func _showLoginValidationError() {
        self._wireframe.showAlert(with: "Error", message: "Please enter email and password")
    }

    func _showUsernameValidationError() {
        self._wireframe.showAlert(with: "Error", message: "Please enter valid username")
    }

    func _showPasswordValidationError() {
        self._wireframe.showAlert(with: "Error", message: "Password should be at least 6 characters long")
    }
}
