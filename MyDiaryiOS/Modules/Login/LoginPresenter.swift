//
//  LoginPresenter.swift
//  MyDiaryiOS
//
//  Created by 坂元 武佐志 on 2019/06/05.
//  Copyright © 2019 musashi. All rights reserved.
//

import Foundation

final class LoginPresenter {
    private unowned let _view: LoginViewInterface
    private let _interactor: LoginInteractorInterface
    private let _wireframe: LoginWireframeInterface

    init(wireframe: LoginWireframeInterface, view: LoginViewInterface, interactor: LoginInteractorInterface) {
        self._wireframe = wireframe
        self._view = view
        self._interactor = interactor
    }
}

extension LoginPresenter: LoginPresenterInterface {}
