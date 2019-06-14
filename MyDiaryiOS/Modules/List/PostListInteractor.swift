//
//  PostListInteractor.swift
//  MyDiaryiOS
//
//  Created by 坂元 武佐志 on 2019/06/06.
//  Copyright © 2019 musashi. All rights reserved.
//

import Alamofire
import Foundation
import ReSwift

final class PostListInteractor {
    private let _postService = PostService()
    public weak var presenter: PostListPresenterInterface?

    init() {
        mainStore.subscribe(self) { subscription in
            subscription.select { state in state.postDataState }
        }
    }

    deinit {
        mainStore.unsubscribe(self)
    }
}

extension PostListInteractor: StoreSubscriber {
    func newState(state: PostDataState) {
        guard let posts = state.posts as? [PostViewItemInterface] else { return }
        self.presenter?.setPost(posts)
    }
}

extension PostListInteractor: PostListInteractorInterface {
    func getPosts(completion: @escaping PostCompletionBlock) {
        self._postService.getPosts(completion: completion)
    }

    func deletePost(postId: Int, completion: @escaping PostCompletionBlock) {
        self._postService.deletePost(postId, completion: completion)
    }
}
