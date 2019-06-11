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
        self.presenter?.setPost(state.posts)
    }
}

extension PostListInteractor: PostListInteractorInterface {
    @discardableResult
    func getPosts(completion: @escaping PostCompletionBlock) -> DataRequest {
        return self._postService.getPosts(completion: completion)
    }
}
