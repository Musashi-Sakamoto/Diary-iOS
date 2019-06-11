//
//  MenuInteractor.swift
//  MyDiaryiOS
//
//  Created by Musashi Sakamoto on 2019/06/10.
//  Copyright © 2019 musashi. All rights reserved.
//

import Alamofire
import Foundation
import ReSwift

final class MenuInteractor {
    public weak var presenter: MenuPresenterInterface?
    private var _userService = UserService()

    init() {
        mainStore.subscribe(self) { subscription in
            subscription.select { state in state.loginUserState }
        }
    }

    deinit {
        mainStore.unsubscribe(self)
    }
}

extension MenuInteractor: StoreSubscriber {
    func newState(state: LoginUserState) {
        print(state)
        self.presenter?.showProfileInfo(username: state.username, email: state.email)
    }
}

extension MenuInteractor: MenuInteractorInterface {
    @discardableResult
    func logout(completion: @escaping LogoutCompletionBlock) -> DataRequest {
        return self._userService.logoutUser(completion: completion)
    }
}
