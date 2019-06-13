//
//  PostInteractor.swift
//  MyDiaryiOS
//
//  Created by Musashi Sakamoto on 2019/06/10.
//  Copyright © 2019 musashi. All rights reserved.
//

import Alamofire
import Foundation
import ReSwift

final class PostInteractor {
    private var _postService = PostService()

    public weak var presenter: PostPresenterInterface?

    init() {
        mainStore.subscribe(self) { subscription in
            subscription.select { state in state.postDataState }
        }
    }

    deinit {
        mainStore.unsubscribe(self)
    }
}

extension PostInteractor: StoreSubscriber {
    func newState(state: PostDataState) {
        print("state: \(state.editedPost)")
        self.presenter?.setEditedPost(post: state.editedPost)
    }
}

extension PostInteractor: PostInteractorInterface {
    func getEditedPost() -> Post? {
        return mainStore.state.postDataState.editedPost
    }

    @discardableResult
    func editPost(title: String, description: String, postId: Int, completion: @escaping PostCompletionBlock) -> DataRequest {
        return self._postService.editPost(title: title, description: description, postId: postId, completion: completion)
    }

    @discardableResult
    func creartePost(title: String, description: String, completion: @escaping PostCompletionBlock) -> DataRequest {
        return self._postService.createPost(title: title, description: description, completion: completion)
    }

    func createImage(data: Data, postId: Int, isImage: Bool, completion: @escaping ImageCompletionBlock) {
        return self._postService.uploadImage(data: data, postId: postId, isImage: isImage, completion: completion)
    }
}
