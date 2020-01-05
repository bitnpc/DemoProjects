//
//  UIImageView+Web.swift
//  wechat
//
//  Created by Tony Clark on 2020/1/2.
//  Copyright © 2020 tongchao. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func setImage(with url: URL) {
        
        let urlString = url.absoluteString
        let cache = ImageCache.shareInstance
        
        cache.get(key: urlString) { (image) in
            if image != nil {
                self.image = image
                return
            }
        }
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url) { (data, response, error) in
            guard let dataResponse = data, error == nil else {
                print(error?.localizedDescription ?? "Response Error")
                return
            }
            DispatchQueue.main.async {
                let image = UIImage.init(data: dataResponse)
                guard let img = image else { return }
                cache.set(key: urlString, value: img, completion: nil)
                self.image = img
            }
        }
        dataTask.resume()
    }
}
