//
//  IntroViewModel.swift
//  contacts
//
//  Created by tongchao on 2019/12/24.
//  Copyright © 2019 tongchao. All rights reserved.
//

import UIKit

class IntroViewModel: NSObject {
    
    let firstName: String
    let lastName: String
    let subtitle: String
    let intro: String
    
    init(contact: Contact) {
        firstName = contact.firstName ?? "firstName"
        lastName = contact.lastName ?? "lastName"
        subtitle = contact.title ?? "title"
        intro = contact.intro ?? "introduction"
    }
}
