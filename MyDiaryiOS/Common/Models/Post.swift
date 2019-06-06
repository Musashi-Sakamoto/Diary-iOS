//
//  Post.swift
//  MyDiaryiOS
//
//  Created by 坂元 武佐志 on 2019/06/06.
//  Copyright © 2019 musashi. All rights reserved.
//

import Foundation

enum MediaType: String {
    case video
    case image
}

struct Post: Any {
    var id: String
    var mainTitle: String
    var description: String
    var updatedAt: String

    var url: String

    var mediaType: MediaType
}

extension Post: PostViewItemInterface {
    var imageURL: URL? {
        return URL(string: self.url)
    }

    var title: String? {
        return self.mainTitle
    }
}
