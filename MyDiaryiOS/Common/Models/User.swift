//
//  User.swift
//  MyDiaryiOS
//
//  Created by 坂元 武佐志 on 2019/06/05.
//  Copyright © 2019 musashi. All rights reserved.
//

import Foundation

struct User: Any {
    var id: String
    var username: String
    var authToken: String
}

extension User {
    var authorizationHeader: String {
        return String(format: "Bearer %@", self.authToken)
    }
}
