//
//  PostListInterface.swift
//  MyDiaryiOS
//
//  Created by 坂元 武佐志 on 2019/06/06.
//  Copyright © 2019 musashi. All rights reserved.
//

import Alamofire
import Foundation
import UIKit

enum PostListNavigationOption {
    case login
    case add
    case detail
}

protocol PostListWireframeInterface: WireframeInterface {
    func navigate(to option: PostListNavigationOption)
}

protocol PostListViewInterface: ViewInterface {
    func reloadData()
    func setEmptyPlaceholderHidden(_ hidden: Bool)
    func setLoadingVisible(_ visible: Bool)
}

protocol PostListPresenterInterface: PresenterInterface {
    func didSelectLogoutAction()
    func didSelectAddAction()

    func numberOfSections() -> Int
    func numberOrItems(in section: Int) -> Int
    func item(at indexPath: IndexPath) -> PostViewItemInterface
    func didSelectItem(at indexPath: IndexPath)
}

protocol PostListInteractorInterface: InteractorInterface {
    @discardableResult
    func getPosts(completion: @escaping PostCompletionBlock) -> DataRequest
}

protocol PostViewItemInterface {
    var title: String? { get }
    var imageURL: URL? { get }
    var mediaType: MediaType? { get }
}
