//
//  Contact.swift
//  contacts
//
//  Created by tongchao on 2019/12/24.
//  Copyright © 2019 tongchao. All rights reserved.
//

import Foundation

class Contact: NSObject, Decodable {
    
    let firstName: String?
    let lastName: String?
    let avatarFileName: String?
    let title: String?
    let intro: String?
    
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case avatarFileName = "avatar_filename"
        case title
        case intro = "introduction"
    }
    
    init(dic: Dictionary<String, Any>) {
        firstName = dic["first_name"] as? String
        lastName = dic["last_name"] as? String
        avatarFileName = dic["avatar_filename"] as? String
        title = dic["title"] as? String
        intro = dic["introduction"] as? String
    }
}
