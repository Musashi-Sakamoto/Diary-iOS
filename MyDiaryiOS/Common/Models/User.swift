//
//  User.swift
//  MyDiaryiOS
//
//  Created by 坂元 武佐志 on 2019/06/05.
//  Copyright © 2019 musashi. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol UserInterface {
    var email: String { get }
    var username: String { get }
}

struct User: UserInterface {
    var email: String
    var username: String

    init(jsonObject: JSON) {
        self.email = jsonObject["user"]["email"].stringValue
        self.username = jsonObject["user"]["username"].stringValue
    }
}
