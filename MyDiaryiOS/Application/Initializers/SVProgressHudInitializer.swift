//
//  SVProgressHudInitializer.swift
//  MyDiaryiOS
//
//  Created by 坂元 武佐志 on 2019/06/06.
//  Copyright © 2019 musashi. All rights reserved.
//

import SVProgressHUD
import UIKit

class SVProgressHudInitializer: Initializerable {
    func performInitialization() {
        SVProgressHUD.setForegroundColor(UIColor.white)
        SVProgressHUD.setDefaultStyle(.dark)
    }
}
