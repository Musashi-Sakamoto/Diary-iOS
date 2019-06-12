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

public struct Post: Any {
    var id: String
    var mainTitle: String
    var description: String
    var updatedAt: String?

    var url: String?

    var media: MediaType?

    init(jsonObject: JSON) {
        self.id = jsonObject["id"].stringValue
        self.mainTitle = jsonObject["title"].stringValue
        self.description = jsonObject["description"].stringValue
        self.updatedAt = jsonObject["updatedAt"].stringValue
        guard let url = jsonObject["presignedUrl"].string else { return }
        self.url = url
        guard let media = jsonObject["mediaType"].string else { return }
        self.media = MediaType(rawValue: media)
    }
}

extension Post: PostViewItemInterface {
    var imageURL: URL? {
        if let url = self.url {
            return URL(string: url)
        } else {
            return nil
        }
    }

    var title: String? {
        return self.mainTitle
    }

    var detail: String? {
        return self.description
    }

    var timeStamp: String? {
        return self.updatedAt
    }

    var mediaType: MediaType? {
        return self.media
    }
}
