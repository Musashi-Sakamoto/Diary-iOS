//
//  LoginInteractor.swift
//  MyDiaryiOS
//
//  Created by 坂元 武佐志 on 2019/06/05.
//  Copyright © 2019 musashi. All rights reserved.
//

import Alamofire
import Foundation
import ReSwift

final class LoginInteractor {
    private var _userService = UserService()
    public weak var presenter: LoginPresenterInterface?

    init() {
        mainStore.subscribe(self) { subscription in
            subscription.select { state in state.loginUserState }
        }
    }

    deinit {
        mainStore.unsubscribe(self)
    }
}

extension LoginInteractor: StoreSubscriber {
    func newState(state: LoginUserState) {
        self.presenter?.setLoginState(isLogin: state.isLogin)
    }
}

extension LoginInteractor: LoginInteractorInterface {
    @discardableResult
    func loginUser(username: String, password: String, completion: @escaping LoginCompletionBlock) -> DataRequest {
        return self._userService.loginUser(username: username, password: password, completion: completion)
    }

    @discardableResult
    func signupUser(email: String, username: String, password: String, completion: @escaping SignupCompletionBlock) -> DataRequest {
        return self._userService.signupUser(email: email, username: username, password: password, completion: completion)
    }

    func isLogin() -> Bool {
        return mainStore.state.loginUserState.isLogin
    }
}
