//
//  MemoryCache.swift
//  wechat
//
//  Created by Tony Clark on 2020/1/2.
//  Copyright © 2020 tongchao. All rights reserved.
//

import Foundation
import UIKit

final class Box<T> {
    let value: T
    init(_ value: T) {
        self.value = value
    }
}

public final class MemoryCache<T>: NSObject {
    private let _cache = NSCache<NSString, Box<T>>.init()
    
    init(countLimit: Int? = nil) {
        _cache.countLimit = countLimit ?? 0
    }
    
    public func set(key: String, value: T, completion: (() -> Void)? = nil) {
        _cache.setObject(Box(value), forKey: key as NSString)
        completion?()
    }
    
    public func get(key: String, completion: @escaping ((T?) -> Void)) {
        let box = _cache.object(forKey: key as NSString)
        let value = box.flatMap({ $0.value })
        completion(value)
    }

    public func remove(key: String, completion: (() -> Void)? = nil) {
        _cache.removeObject(forKey: key as NSString)
        completion?()
    }

    public func removeAll(completion: (() -> Void)? = nil) {
        _cache.removeAllObjects()
        completion?()
    }
    
    public subscript(key: String) -> T? {
        get {
            return (_cache.object(forKey: key as NSString))?.value
        }
        
        set(newValue) {
            if let newValue = newValue {
                _cache.setObject(Box(newValue), forKey: key as NSString)
            } else {
                _cache.removeObject(forKey: key as NSString)
            }
        }
    }
}
