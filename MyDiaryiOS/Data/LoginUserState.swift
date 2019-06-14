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
    private(set) var user: UserInterface?

    private(set) var isLogin = true
}

extension LoginUserState {
    enum Action: ReSwift.Action {
        case LoginAction(user: UserInterface?)
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
            case let .LoginAction(user):
                state.user = user
            case .LogoutAction:
                state.user = nil
            case .ToggleLoginAction:
                state.isLogin = !state.isLogin
            }
        default:
            break
        }
        return state
    }
}
