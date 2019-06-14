//
//  PostInterface.swift
//  MyDiaryiOS
//
//  Created by Musashi Sakamoto on 2019/06/10.
//  Copyright © 2019 musashi. All rights reserved.
//

import Alamofire
import Foundation

enum PostNavigationOption {
    case dismiss
    case library
}

protocol PostWireframeInterface: WireframeInterface {
    func navigate(to option: PostNavigationOption)
}

protocol PostViewInterface: ViewInterface {
    func showEditedPost(post: PostInterface?)
}

protocol PostPresenterInterface: PresenterInterface {
    func postButtonClicked(title: String, description: String, data: Data?, isImage: Bool)
    func editButtonClicked(title: String, description: String, postId: Int, data: Data?, isImage: Bool)
    func cancelButtonClicked()
    func addMediaButtonClicked()
    func setEditedPost(post: PostInterface?)
    func isEditing() -> Bool
    func getPostId() -> Int?
}

protocol PostInteractorInterface: InteractorInterface {
    func creartePost(title: String, description: String, completion: @escaping PostCompletionBlock)
    func editPost(title: String, description: String, postId: Int, completion: @escaping PostCompletionBlock)
    func createImage(data: Data, postId: Int, isImage: Bool, completion: @escaping ImageCompletionBlock)
    func getEditedPost() -> PostInterface?
}
