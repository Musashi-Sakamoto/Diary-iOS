
//
//  AppSnackbarController.swift
//  MyDiaryiOS
//
//  Created by Musashi Sakamoto on 2019/06/13.
//  Copyright © 2019 musashi. All rights reserved.
//

import Material
import UIKit

class AppSnackbarController: SnackbarController {
    override func prepare() {
        super.prepare()
        delegate = self
    }
}

extension AppSnackbarController: SnackbarControllerDelegate {
    func snackbarController(snackbarController: SnackbarController, willShow snackbar: Snackbar) {
        print("snackbarController will show")
    }

    func snackbarController(snackbarController: SnackbarController, willHide snackbar: Snackbar) {
        print("snackbarController will hide")
    }

    func snackbarController(snackbarController: SnackbarController, didShow snackbar: Snackbar) {
        print("snackbarController did show")
    }

    func snackbarController(snackbarController: SnackbarController, didHide snackbar: Snackbar) {
        print("snackbarController did hide")
    }
}
