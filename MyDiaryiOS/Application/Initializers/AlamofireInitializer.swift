//
//  AlamofireInitializer.swift
//  MyDiaryiOS
//
//  Created by 坂元 武佐志 on 2019/06/05.
//  Copyright © 2019 musashi. All rights reserved.
//

import Alamofire
import AlamofireNetworkActivityIndicator
import Foundation

class AlamofireInitializer: Initializerable {
    func performInitialization() {
        let networkActivityManager = NetworkActivityIndicatorManager.shared
        networkActivityManager.isEnabled = true
        networkActivityManager.startDelay = 0
        SessionManager.default.adapter = AuthorizationAdapter.shared
    }
}
