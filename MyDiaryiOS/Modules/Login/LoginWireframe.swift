//
//  LoginWireframe.swift
//  MyDiaryiOS
//
//  Created by 坂元 武佐志 on 2019/06/05.
//  Copyright © 2019 musashi. All rights reserved.
//

import Foundation
import UIKit

final class LoginWireframe: BaseWireframe {
    private let _storyboard = UIStoryboard(name: "Login", bundle: nil)

    init() {
        let moduleViewController = self._storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        super.init(viewController: moduleViewController)

        let interactor = LoginInteractor()
        let presenter = LoginPresenter(wireframe: self, view: moduleViewController, interactor: interactor)
        moduleViewController.presenter = presenter
    }
}

extension LoginWireframe: LoginWireframeInterface {
    func navigate(to _: LoginNavigationOption) {}
}
