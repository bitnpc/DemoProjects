//
//  AvatarViewModel.swift
//  contacts
//
//  Created by tongchao on 2019/12/24.
//  Copyright © 2019 tongchao. All rights reserved.
//

import UIKit

class AvatarViewModel: NSObject {

    let imageName: String
    
    public static let cellSize = CGSize(width: 80, height: 80)
    
    init(contact: Contact) {
        self.imageName = contact.avatarFileName ?? ""
    }
}
