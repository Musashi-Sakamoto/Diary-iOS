//
//  LoginInterface.swift
//  MyDiaryiOS
//
//  Created by 坂元 武佐志 on 2019/06/05.
//  Copyright © 2019 musashi. All rights reserved.
//

import Foundation

enum LoginNavigationOption {}

protocol LoginWireframeInterface: WireframeInterface {
    func navigate(to option: LoginNavigationOption)
}

protocol LoginViewInterface: ViewInterface {}

protocol LoginPresenterInterface: PresenterInterface {}

protocol LoginInteractorInterface: InteractorInterface {}
