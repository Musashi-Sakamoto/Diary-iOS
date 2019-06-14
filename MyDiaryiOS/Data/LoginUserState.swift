//
//  LoginUserState.swift
//  MyDiaryiOS
//
//  Created by Musashi Sakamoto on 2019/06/11.
//  Copyright © 2019 musashi. All rights reserved.
//

import Foundation
import ReSwift

public struct LoginUserState: StateType {
    private(set) var username = ""
    private(set) var email = ""

    private(set) var isLogin = true
}

extension LoginUserState {
    public enum Action: ReSwift.Action {
        case LoginAction(username: String, email: String)
        case ToggleLoginAction
        case LogoutAction
    }
}

extension LoginUserState {
    public static func reducer(action: ReSwift.Action, state: LoginUserState?) -> LoginUserState {
        var state = state ?? LoginUserState()

        switch action {
        case let loginAction as LoginUserState.Action:
            switch loginAction {
            case let .LoginAction(name, email):
                state.username = name
                state.email = email
            case .LogoutAction:
                state.username = ""
                state.email = ""
            case .ToggleLoginAction:
                state.isLogin = !state.isLogin
            }
        default:
            break
        }
        return state
    }
}
