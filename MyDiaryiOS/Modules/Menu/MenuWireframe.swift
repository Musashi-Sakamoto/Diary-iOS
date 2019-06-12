//
//  MenuWireframe.swift
//  MyDiaryiOS
//
//  Created by Musashi Sakamoto on 2019/06/10.
//  Copyright © 2019 musashi. All rights reserved.
//

import Foundation
import Material
import UIKit

final class MenuWireframe: BaseWireframe {
    private let _storyboard = UIStoryboard(name: "Menu", bundle: nil)

    init() {
        let moduleViewController = self._storyboard.instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
        super.init(viewController: moduleViewController)

        let interactor = MenuInteractor()
        let presenter = MenuPresenter(wireframe: self, view: moduleViewController, interactor: interactor)
        interactor.presenter = presenter
        moduleViewController.presenter = presenter
    }
}

extension MenuWireframe: MenuWireframeInterface {
    func navigate(to option: MenuNavigationOption) {
        switch option {
        case .login:
            viewController.navigationDrawerController?.closeLeftView()
            if let appToolC = viewController.navigationDrawerController?.rootViewController as? AppToolbarController,
                let navigationVC = appToolC.rootViewController as? UINavigationController {
                navigationVC.popToRootViewController(animated: true)
            }
        default:
            print("default")
        }
    }
}
