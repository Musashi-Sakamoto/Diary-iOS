//
//  MenuInteractor.swift
//  MyDiaryiOS
//
//  Created by Musashi Sakamoto on 2019/06/10.
//  Copyright © 2019 musashi. All rights reserved.
//

import Alamofire
import Foundation

final class MenuInteractor {
    private var _userService = UserService()
}

extension MenuInteractor: MenuInteractorInterface {
    @discardableResult
    func logout(completion: @escaping LogoutCompletionBlock) -> DataRequest {
        return self._userService.logoutUser(completion: completion)
    }
}
