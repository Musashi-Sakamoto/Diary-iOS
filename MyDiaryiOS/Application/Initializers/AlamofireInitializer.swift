//
//  AlamofireInitializer.swift
//  MyDiaryiOS
//
//  Created by 坂元 武佐志 on 2019/06/05.
//  Copyright © 2019 musashi. All rights reserved.
//

import Alamofire
import Foundation

class AlamofireInitializer: Initializerable {
    func performInitialization() {
        Alamofire.SessionManager.default.adapter = AuthorizationAdapter.shared
    }
}
