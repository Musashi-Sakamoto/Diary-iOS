//
//  AppNavigatinoDrawerController.swift
//  MyDiaryiOS
//
//  Created by Musashi Sakamoto on 2019/06/08.
//  Copyright © 2019 musashi. All rights reserved.
//

import Material
import UIKit

class AppNavigatinoDrawerController: NavigationDrawerController {
    override func prepare() {
        super.prepare()

        delegate = self
    }
}

extension AppNavigatinoDrawerController: NavigationDrawerControllerDelegate {
    func navigationDrawerController(navigationDrawerController: NavigationDrawerController, willOpen position: NavigationDrawerPosition) {
        print("navigationDrawerController willOpen")
    }

    func navigationDrawerController(navigationDrawerController: NavigationDrawerController, didOpen position: NavigationDrawerPosition) {
        print("navigationDrawerController didOpen")
    }

    func navigationDrawerController(navigationDrawerController: NavigationDrawerController, willClose position: NavigationDrawerPosition) {
        print("navigationDrawerController willClose")
    }

    func navigationDrawerController(navigationDrawerController: NavigationDrawerController, didClose position: NavigationDrawerPosition) {
        print("navigationDrawerController didClose")
    }

    func navigationDrawerController(navigationDrawerController: NavigationDrawerController, didBeginPanAt point: CGPoint, position: NavigationDrawerPosition) {
        print("navigationDrawerController didBeginPanAt: ", point, "with position:", position == .left ? "Left" : "Right")
    }

    func navigationDrawerController(navigationDrawerController: NavigationDrawerController, didChangePanAt point: CGPoint, position: NavigationDrawerPosition) {
        print("navigationDrawerController didChangePanAt: ", point, "with position:", position == .left ? "Left" : "Right")
    }

    func navigationDrawerController(navigationDrawerController: NavigationDrawerController, didEndPanAt point: CGPoint, position: NavigationDrawerPosition) {
        print("navigationDrawerController didEndPanAt: ", point, "with position:", position == .left ? "Left" : "Right")
    }

    func navigationDrawerController(navigationDrawerController: NavigationDrawerController, didTapAt point: CGPoint, position: NavigationDrawerPosition) {
        print("navigationDrawerController didTapAt: ", point, "with position:", position == .left ? "Left" : "Right")
    }

    func navigationDrawerController(navigationDrawerController: NavigationDrawerController, statusBar isHidden: Bool) {
        print("navigationDrawerController statusBar is hidden:", isHidden ? "Yes" : "No")
    }
}

extension AppNavigatinoDrawerController {
    convenience init(rootViewController: UIViewController, menuWireframe: BaseWireframe) {
        self.init(rootViewController: rootViewController, leftViewController: menuWireframe.viewController, rightViewController: nil)
    }
}
