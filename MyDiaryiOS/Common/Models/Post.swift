//
//  Post.swift
//  MyDiaryiOS
//
//  Created by 坂元 武佐志 on 2019/06/06.
//  Copyright © 2019 musashi. All rights reserved.
//

import Foundation
import SwiftyJSON

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

    var media: MediaType

    init(jsonObject: JSON) {
        self.id = jsonObject["id"].stringValue
        self.mainTitle = jsonObject["title"].stringValue
        self.description = jsonObject["description"].stringValue
        self.updatedAt = jsonObject["updatedAt"].stringValue
        self.url = jsonObject["presignedUrl"].stringValue
        self.media = MediaType(rawValue: jsonObject["mediaType"].stringValue)!
    }
}

extension Post: PostViewItemInterface {
    var imageURL: URL? {
        return URL(string: self.url)
    }

    var title: String? {
        return self.mainTitle
    }

    var mediaType: MediaType? {
        return self.media
    }
}
