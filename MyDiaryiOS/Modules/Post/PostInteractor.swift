//
//  PostInteractor.swift
//  MyDiaryiOS
//
//  Created by Musashi Sakamoto on 2019/06/10.
//  Copyright © 2019 musashi. All rights reserved.
//

import Alamofire
import Foundation

final class PostInteractor {
    private var _postService = PostService()
}

extension PostInteractor: PostInteractorInterface {
    @discardableResult
    func creartePost(title: String, description: String, completion: @escaping PostCompletionBlock) -> DataRequest {
        return self._postService.createPost(title: title, description: description, completion: completion)
    }

    func createImage(image: UIImage, postId: Int, completion: @escaping ImageCompletionBlock) {
        return self._postService.uploadImage(image: image, postId: postId, completion: completion)
    }
}
