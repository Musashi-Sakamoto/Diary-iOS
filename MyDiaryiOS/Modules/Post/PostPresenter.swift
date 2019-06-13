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
    func getPostId() -> Int? {
        guard let post = _interactor.getEditedPost() else { return nil }
        return Int(post.id)
    }

    func isEditing() -> Bool {
        return self._interactor.getEditedPost() != nil
    }

    func setEditedPost(post: Post?) {
        self._view.showEditedPost(post: post)
    }

    func addMediaButtonClicked() {
        self._wireframe.navigate(to: .library)
    }

    func editButtonClicked(title: String, description: String, postId: Int, data: Data?, isImage: Bool) {
        guard title.count > 0 else {
            _showTitleValidationError()
            return
        }

        guard description.count > 0 else {
            _showDescriptionValidationError()
            return
        }

        self._interactor.editPost(title: title, description: description, postId: postId) { [weak self] response in
            self?._handleEditResult(response, data, isImage, postId: postId)
        }
    }

    func postButtonClicked(title: String, description: String, data: Data?, isImage: Bool) {
        guard title.count > 0 else {
            _showTitleValidationError()
            return
        }

        guard description.count > 0 else {
            _showDescriptionValidationError()
            return
        }

        self._interactor.creartePost(title: title, description: description) { [weak self] response in
            self?._handlePostResult(response, data, isImage)
        }
    }

    func cancelButtonClicked() {
        self._wireframe.navigate(to: .dismiss)
    }
}

private extension PostPresenter {
    private func _handlePostResult(_ response: DataResponse<Any>, _ data: Data?, _ isImage: Bool) {
        print(response.result.value)
        switch response.response!.statusCode {
        case 201:
            if let data = data {
                let postId = JSON(response.result.value)["post"]["id"].intValue
                self._interactor.createImage(data: data, postId: postId, isImage: isImage) { _ in
                    self._wireframe.navigate(to: .dismiss)
                }
            } else {
                self._wireframe.navigate(to: .dismiss)
            }
        default:
            let error = JSON(response.result.value)
            self._wireframe.showErrorAlert(with: error["error"]["message"].stringValue)
        }
    }

    private func _handleEditResult(_ response: DataResponse<Any>, _ data: Data?, _ isImage: Bool, postId: Int) {
        print(response.result.value)
        switch response.response!.statusCode {
        case 204:
            if let data = data {
                self._interactor.createImage(data: data, postId: postId, isImage: isImage) { _ in
                    self._wireframe.navigate(to: .dismiss)
                }
            } else {
                self._wireframe.navigate(to: .dismiss)
            }
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
