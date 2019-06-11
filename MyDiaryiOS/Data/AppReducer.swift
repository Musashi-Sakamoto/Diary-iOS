//
//  AppReducer.swift
//  MyDiaryiOS
//
//  Created by Musashi Sakamoto on 2019/06/11.
//  Copyright © 2019 musashi. All rights reserved.
//

import Foundation
import ReSwift

func appReducer(action: Action, state: AppState?) -> AppState {
    var state = state ?? AppState()

    switch action {
    case let loginAction as LoginUserState.Action:
        state.loginUserState = LoginUserState.reducer(action: loginAction, state: state.loginUserState)
    case let postDataAction as PostDataState.Action:
        state.postDataState = PostDataState.reducer(action: postDataAction, state: state.postDataState)
    default:
        print("error")
    }
    return state
}
