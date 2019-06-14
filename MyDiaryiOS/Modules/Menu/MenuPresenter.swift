//
//  MenuPresenter.swift
//  MyDiaryiOS
//
//  Created by Musashi Sakamoto on 2019/06/10.
//  Copyright © 2019 musashi. All rights reserved.
//

import Alamofire
import Foundation
import SwiftyJSON

final class MenuPresenter {
    private unowned let _view: MenuViewInterface
    private let _interactor: MenuInteractorInterface
    private let _wireframe: MenuWireframeInterface
    private let _authorizationManager: AuthorizationAdapter

    init(wireframe: MenuWireframeInterface, view: MenuViewInterface, interactor: MenuInteractorInterface, authorizationManager: AuthorizationAdapter = AuthorizationAdapter.shared) {
        self._wireframe = wireframe
        self._view = view
        self._interactor = interactor
        self._authorizationManager = authorizationManager
    }
}

extension MenuPresenter: MenuPresenterInterface {
    func showProfileInfo(user: UserInterface?) {
        self._view.showProfileInfo(user: user)
    }

    func logoutButtonClicked() {
        self._interactor.logout { [weak self] response in
            self?._handleLogoutResult(response)
        }
    }
}

private extension MenuPresenter {
    private func _handleLogoutResult(_ response: DataResponse<Any>) {
        print(response.result.value)
        switch response.response!.statusCode {
        case 200:
            mainStore.dispatch(LoginUserState.Action.LogoutAction)
            self._authorizationManager.authorizationHeader = nil
            self._wireframe.navigate(to: .login)
        default:
            let error = JSON(response.result.value)
            self._wireframe.showErrorAlert(with: error["error"]["message"].stringValue)
        }
    }
}
