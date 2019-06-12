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
    private(set) var posts: [Post]?
}

extension PostDataState {
    public enum Action: ReSwift.Action {
        case setPosts(posts: [Post])
    }
}

extension PostDataState {
    public static func reducer(action: Action, state: PostDataState?) -> PostDataState {
        var state = state ?? PostDataState()

        switch action {
        case let postData as PostDataState.Action:
            switch postData {
            case let .setPosts(posts):
                state.posts = posts
            }
        default:
            break
        }
        return state
    }
}
