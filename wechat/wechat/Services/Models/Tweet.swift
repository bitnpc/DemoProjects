//
//  Tweet.swift
//  wechat
//
//  Created by tongchao on 2019/12/21.
//  Copyright © 2019 tongchao. All rights reserved.
//

import UIKit

struct Image: Decodable {
    let url: String?

    enum CodingKeys: String, CodingKey {
        case url
    }
}

struct Sender: Decodable {
    let username: String?
    let nick: String?
    let avatar: String?
    let profileImage: String?

    enum CodingKeys: String, CodingKey {
        case username
        case nick
        case avatar
        case profileImage = "profile-image"
    }
}

struct Comment: Decodable {
    let content: String?
    let sender: Sender?

    enum CodingKeys: String, CodingKey {
        case content
        case sender
    }
}

struct Tweet: Decodable {
    let content: String?
    let images: [Image]?
    let sender: Sender?
    let comments: [Comment]?

    enum CodingKeys: String, CodingKey {
        case content
        case images
        case sender
        case comments
    }
}
