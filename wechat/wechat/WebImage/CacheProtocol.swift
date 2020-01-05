//
//  CacheProtocol.swift
//  wechat
//
//  Created by Tony Clark on 2020/1/2.
//  Copyright © 2020 tongchao. All rights reserved.
//

import UIKit

public protocol CacheProtocol {
    
    associatedtype T
    
    func get(key: String, completion: @escaping ((T?) -> Void))
    func set(key: String, value: T, completion: (() -> Void)?)
    func remove(key: String, completion: (() -> Void)?)
    func removeAll(completion: (() -> Void)?)
}
