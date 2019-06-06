//
//  PostListInteractor.swift
//  MyDiaryiOS
//
//  Created by 坂元 武佐志 on 2019/06/06.
//  Copyright © 2019 musashi. All rights reserved.
//

import Alamofire
import Foundation

final class PostListInteractor {
    private let _postService = PostService()
}

extension PostListInteractor: PostListInteractorInterface {
    @discardableResult
    func getPosts(completion: @escaping PostCompletionBlock) -> DataRequest {
        return self._postService.getPosts(completion: completion)
    }
}
