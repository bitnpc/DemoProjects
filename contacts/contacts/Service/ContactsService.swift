//
//  ContactsService.swift
//  contacts
//
//  Created by tongchao on 2019/12/24.
//  Copyright © 2019 tongchao. All rights reserved.
//

import Foundation

enum DataFetchResult {
    case success(contacts: [Contact])
    case failure
}

class ContactsService {
    
    func fetchContacts(param: Dictionary<String, String>?, completion: @escaping (DataFetchResult) -> Void) {
        // Simulate network delay by 3 seconds
        let deadlineTime = DispatchTime.now() + .seconds(2)
        DispatchQueue.global().asyncAfter(deadline: deadlineTime) {
            guard let path = Bundle.main.url(forResource: "contacts", withExtension: "json"),
                let jsonData = try? Data(contentsOf: path) else
            {
                DispatchQueue.main.async {
                    completion(.failure)
                }
                return
            }
            do {
                let dicArray = try JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) as! Array<Any>
                let contacts = dicArray.map { (dic) -> Contact in
                    return Contact.init(dic: dic as! Dictionary<String, Any>)
                }
                DispatchQueue.main.async {
                    completion(.success(contacts: contacts))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.success(contacts: []))
                }
            }
        }
    }
    
    func fetchContactsPlaceholder() -> [Contact] {
        guard let path = Bundle.main.url(forResource: "contactsPlaceholder", withExtension: "json"),
            let jsonData = try? Data(contentsOf: path)
            else { return [] }
        do {
            let dicArray = try JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) as! Array<Any>
            let contacts = dicArray.map { (dic) -> Contact in
                return Contact.init(dic: dic as! Dictionary<String, Any>)
            }
            return contacts
        } catch {
            return []
        }
    }
}
