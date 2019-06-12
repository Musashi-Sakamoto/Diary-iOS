//
//  PostListPresenter.swift
//  MyDiaryiOS
//
//  Created by 坂元 武佐志 on 2019/06/06.
//  Copyright © 2019 musashi. All rights reserved.
//

import Alamofire
import Foundation
import SwiftyJSON

final class PostListPresenter {
    private unowned var _view: PostListViewInterface
    private var _interactor: PostListInteractorInterface
    private var _wireframe: PostListWireframeInterface

    private let _authorizationManager = AuthorizationAdapter.shared

    private var _items: [Post] = [] {
        didSet {
            self._view.reloadData()
        }
    }

    init(wireframe: PostListWireframeInterface, view: PostListViewInterface, interactor: PostListInteractorInterface) {
        self._wireframe = wireframe
        self._view = view
        self._interactor = interactor
    }
}

extension PostListPresenter: PostListPresenterInterface {
    func didSelectEditPost(post: Post) {
        self._wireframe.navigate(to: .edit)
        mainStore.dispatch(PostDataState.Action.editPosts(post: post))
    }

    func didSelectDeletePost(postId: Int) {
        self._interactor.deletePost(postId: postId) { [weak self] _ in
            self?._reload()
        }
    }

    func setPost(_ posts: [Post]?) {
        self._items = posts ?? []
    }

    func viewDidLoad() {
        self._reload()
    }

    func viewWillAppear(animated _: Bool) {
        self._reload()
    }

    private func _reload() {
        self._view.setLoadingVisible(true)
        self._interactor.getPosts { [weak self] response in
            self?._view.setLoadingVisible(false)
            self?._handlePostListResult(response)
        }
    }

    func pulledToRefresh() {
        self._reload()
    }

    func didSelectLogoutAction() {
        self._authorizationManager.authorizationHeader = nil
        self._wireframe.navigate(to: .login)
    }

    func didSelectAddAction() {
        mainStore.dispatch(PostDataState.Action.addPost)
        self._wireframe.navigate(to: .add)
    }

    func numberOfSections() -> Int {
        return 1
    }

    func numberOrItems(in _: Int) -> Int {
        return self._items.count
    }

    func item(at indexPath: IndexPath) -> PostViewItemInterface {
        return self._items[indexPath.row]
    }

    func didSelectItem(at _: IndexPath) {
        self._wireframe.navigate(to: .detail)
    }
}

private extension PostListPresenter {
    private func _handlePostListResult(_ response: DataResponse<Any>) {
        switch response.response!.statusCode {
        case 200:
            let posts = JSON(response.result.value)["posts"]["rows"].arrayValue
            self._items = posts.map { Post(jsonObject: $0) }
            mainStore.dispatch(PostDataState.Action.setPosts(posts: posts.map { Post(jsonObject: $0) }))
            self._view.setEmptyPlaceholderHidden(true)
        default:
            let error = JSON(response.result.value)
            self._wireframe.showErrorAlert(with: error["error"]["message"].stringValue)
        }
    }
}
