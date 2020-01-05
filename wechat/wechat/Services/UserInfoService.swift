//
//  UserInfoService.swift
//  wechat
//
//  Created by tongchao on 2019/12/22.
//  Copyright © 2019 tongchao. All rights reserved.
//

import UIKit

class UserInfoService: BaseService {
    
    private let userInfoPath = "user/jsmith"

    func getUserInfo(param: Dictionary<String, String>?, completion: @escaping ((Sender) -> Void) ) {
        guard let url = URL.init(string: userInfoPath, relativeTo: URL.init(string: baseURL)) else { return }
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: url) { (data, response, error) in
            guard let dataResponse = data, error == nil else {
                print(error?.localizedDescription ?? "Response Error")
                return
            }
            do {
                let decoder = JSONDecoder()
                let user = try decoder.decode(Sender.self, from:
                    dataResponse)
                DispatchQueue.main.async {
                    completion(user)
                }
            } catch let parsingError {
                print("Error", parsingError)
            }
        }
        dataTask.resume()
    }
}
