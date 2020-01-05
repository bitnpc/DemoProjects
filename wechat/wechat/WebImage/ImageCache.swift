//
//  ImageCache.swift
//  wechat
//
//  Created by Tony Clark on 2020/1/2.
//  Copyright © 2020 tongchao. All rights reserved.
//

import UIKit

public class ImageCache: NSObject {
    
    public static let shareInstance = ImageCache()
    
    private let memoryCache = MemoryCache<UIImage>.init(countLimit: 30)
    private let diskCache = DiskCache<UIImage>.init()
    
    public func get(key: String, completion: @escaping ((UIImage?) -> Void)) {
        memoryCache.get(key: key) { (value) in
            if let value = value {
                completion(value)
            }else {
                self.diskCache.get(key: key) { (dValue) in
                    if let dValue = dValue {
                        completion(dValue)
                        self.memoryCache.set(key: key, value: dValue, completion: nil)
                    }else {
                        completion(nil)
                    }
                }
            }
        }
    }
    
    public func set(key: String, value: UIImage, completion: (() -> Void)?) {
        memoryCache.set(key: key, value: value, completion: completion)
        diskCache.set(key: key, value: value, completion: completion)
    }
    
    public func remove(key: String, completion: (() -> Void)?) {
        memoryCache.remove(key: key, completion: completion)
        diskCache.remove(key: key, completion: completion)
    }
    
    public func removeAll(completion: (() -> Void)?) {
        memoryCache.removeAll()
        diskCache.removeAll()
    }
}
