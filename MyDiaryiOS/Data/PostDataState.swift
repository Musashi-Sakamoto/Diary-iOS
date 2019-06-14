//
//  PostDataState.swift
//  MyDiaryiOS
//
//  Created by Musashi Sakamoto on 2019/06/11.
//  Copyright © 2019 musashi. All rights reserved.
//

import Foundation
import ReSwift

public struct PostDataState: StateType {
    private(set) var posts: [PostInterface]?
    private(set) var editedPost: PostInterface?
}

extension PostDataState {
    enum Action: ReSwift.Action {
        case setPosts(posts: [PostInterface])
        case editPosts(post: PostInterface?)
        case addPost
    }
}

extension PostDataState {
    public static func reducer(action: ReSwift.Action, state: PostDataState?) -> PostDataState {
        var state = state ?? PostDataState()

        switch action {
        case let postData as PostDataState.Action:
            switch postData {
            case let .setPosts(posts):
                state.posts = posts
            case let .editPosts(post):
                state.editedPost = post
            case .addPost:
                state.editedPost = nil
            }
        default:
            break
        }
        return state
    }
}
