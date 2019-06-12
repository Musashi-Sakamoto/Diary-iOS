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

protocol PostViewInterface: ViewInterface {}

protocol PostPresenterInterface: PresenterInterface {
    func postButtonClicked(title: String, description: String, data: Data?, isImage: Bool)
    func cancelButtonClicked()
    func addMediaButtonClicked()
}

protocol PostInteractorInterface: InteractorInterface {
    func creartePost(title: String, description: String, completion: @escaping PostCompletionBlock) -> DataRequest
    func createImage(data: Data, postId: Int, isImage: Bool, completion: @escaping ImageCompletionBlock)
}
