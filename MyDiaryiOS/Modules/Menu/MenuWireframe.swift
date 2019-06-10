//
//  MenuWireframe.swift
//  MyDiaryiOS
//
//  Created by Musashi Sakamoto on 2019/06/10.
//  Copyright © 2019 musashi. All rights reserved.
//

import Foundation
import UIKit
import Material

final class MenuWireframe: BaseWireframe {
    private let _storyboard = UIStoryboard(name: "Menu", bundle: nil)

    init() {
        let moduleViewController = self._storyboard.instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
        super.init(viewController: moduleViewController)

        let interactor = MenuInteractor()
        let presenter = MenuPresenter(wireframe: self, view: moduleViewController, interactor: interactor)
        moduleViewController.presenter = presenter
    }
}

extension MenuWireframe: MenuWireframeInterface {
    func navigate(to option: MenuNavigationOption) {
        switch option {
        case .login:
            navigationController?.popToRootViewController(animated: true)
        default:
            print("default")
        }
    }
}
