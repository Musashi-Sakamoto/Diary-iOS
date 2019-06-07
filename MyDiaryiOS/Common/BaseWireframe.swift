//
//  BaseWireframe.swift
//  MyDiaryiOS
//
//  Created by 坂元 武佐志 on 2019/06/05.
//  Copyright © 2019 musashi. All rights reserved.
//

import Foundation
import PKHUD
import UIKit

protocol WireframeInterface: AnyObject {
    func popFromNavigationController(animated: Bool)
    func dismiss(animated: Bool)

    func showErrorAlert(with message: String?)
    func showAlert(with title: String?, message: String?)
}

class BaseWireframe {
    private unowned var _viewController: UIViewController

    private var _temporaryStoredViewController: UIViewController?

    init(viewController: UIViewController) {
        self._temporaryStoredViewController = viewController
        self._viewController = viewController
    }
}

extension BaseWireframe: WireframeInterface {
    func popFromNavigationController(animated: Bool) {
        navigationController?.popViewController(animated: animated)
    }

    func dismiss(animated: Bool) {
        navigationController?.dismiss(animated: animated)
    }

    func showErrorAlert(with message: String?) {
        self.showAlert(with: "Something went wrong", message: message)
    }

    func showAlert(with title: String?, message: String?) {
        HUD.flash(.labeledError(title: title, subtitle: message), delay: 3)
    }
}

extension BaseWireframe {
    var viewController: UIViewController {
        defer {
            _temporaryStoredViewController = nil
        }
        return self._viewController
    }

    var navigationController: UINavigationController? {
        return self.viewController.navigationController
    }
}

extension UIViewController {
    func presentWifreframe(_ wireframe: BaseWireframe, animated: Bool = true, completion: (() -> Void)? = nil) {
        present(wireframe.viewController, animated: animated, completion: completion)
    }
}

extension UINavigationController {
    func pushWireframe(_ wireframe: BaseWireframe, animated: Bool = true) {
        self.pushViewController(wireframe.viewController, animated: animated)
    }

    func setRootWireframe(_ wireframe: BaseWireframe, animated: Bool = true) {
        self.setViewControllers([wireframe.viewController], animated: animated)
    }
}
