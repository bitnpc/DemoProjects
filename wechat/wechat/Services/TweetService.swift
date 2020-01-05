//
//  TweetService.swift
//  wechat
//
//  Created by tongchao on 2019/12/21.
//  Copyright © 2019 tongchao. All rights reserved.
//

import UIKit

class TweetService: BaseService {
    
    private let TweetPath = "user/jsmith/tweets"

    func fetchTweets(param: Dictionary<String, String>?, completion: @escaping (([Tweet]) -> Void) ) {
        guard let url = URL.init(string: TweetPath, relativeTo: URL.init(string: baseURL)) else { return }
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: url) { (data, response, error) in
            guard let dataResponse = data, error == nil else {
                print(error?.localizedDescription ?? "Response Error")
                return
            }
            do {
                let decoder = JSONDecoder()
                let tweets = try decoder.decode([Tweet].self, from:
                    dataResponse) //Decode JSON Response Data
                DispatchQueue.main.async {
                    completion(tweets)
                }
            } catch let parsingError {
                print("Error", parsingError)
            }
        }
        dataTask.resume()
    }
}
