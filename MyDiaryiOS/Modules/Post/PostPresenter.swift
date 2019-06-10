//
//  PostPresenter.swift
//  MyDiaryiOS
//
//  Created by Musashi Sakamoto on 2019/06/10.
//  Copyright © 2019 musashi. All rights reserved.
//

import Alamofire
import Foundation
import SwiftyJSON

final class PostPresenter {
    private unowned let _view: PostViewInterface
    private let _interactor: PostInteractorInterface
    private let _wireframe: PostWireframeInterface
    private let _authorizationManager: AuthorizationAdapter

    init(wireframe: PostWireframeInterface, view: PostViewInterface, interactor: PostInteractorInterface, authorizationManager: AuthorizationAdapter = AuthorizationAdapter.shared) {
        self._wireframe = wireframe
        self._view = view
        self._interactor = interactor
        self._authorizationManager = authorizationManager
    }
}

extension PostPresenter: PostPresenterInterface {
    func postButtonClicked(title: String, description: String) {
        guard title.count > 0 else {
            _showTitleValidationError()
            return
        }

        guard description.count > 0 else {
            _showDescriptionValidationError()
            return
        }

        self._interactor.creartePost(title: title, description: description) { [weak self] response in
            self?._handlePostResult(response)
        }
    }

    func cancelButtonClicked() {
        self._wireframe.navigate(to: .dismiss)
    }
}

private extension PostPresenter {
    private func _handlePostResult(_ response: DataResponse<Any>) {
        print(response.result.value)
        switch response.response!.statusCode {
        case 201:
            self._wireframe.navigate(to: .dismiss)
        default:
            let error = JSON(response.result.value)
            self._wireframe.showErrorAlert(with: error["error"]["message"].stringValue)
        }
    }

    func _showTitleValidationError() {
        self._wireframe.showAlert(with: "Error", message: "Title can not be empty")
    }

    func _showDescriptionValidationError() {
        self._wireframe.showAlert(with: "Error", message: "Description can not be empty")
    }
}
