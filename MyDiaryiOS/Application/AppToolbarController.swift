//
//  AppToolbarController.swift
//  MyDiaryiOS
//
//  Created by Musashi Sakamoto on 2019/06/08.
//  Copyright © 2019 musashi. All rights reserved.
//

import Material
import UIKit

class AppToolbarController: ToolbarController {
    fileprivate var menuButton: IconButton!

    override func prepare() {
        super.prepare()
        prepareStatusBar()
        prepareMenuButton()
        prepareToolbar()
    }
}

private extension AppToolbarController {
    func prepareMenuButton() {
        self.menuButton = IconButton(image: Icon.cm.menu, tintColor: .white)
        self.menuButton.pulseColor = .white
        self.menuButton.addTarget(self, action: #selector(handleMenuButton), for: .touchUpInside)
    }

    func prepareToolbar() {
        toolbar.backgroundColor = Color.purple.darken2
        toolbar.titleLabel.textColor = .white
        toolbar.leftViews = [
            menuButton
        ]
    }

    func prepareStatusBar() {
        statusBarStyle = .lightContent
        statusBar.backgroundColor = Color.purple.darken3
    }
}

extension AppToolbarController {
    @objc
    fileprivate func handleMenuButton() {
        navigationDrawerController?.toggleLeftView()
    }
}
