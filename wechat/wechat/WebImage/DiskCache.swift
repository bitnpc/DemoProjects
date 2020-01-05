//
//  DiskCache.swift
//  wechat
//
//  Created by Tony Clark on 2020/1/2.
//  Copyright © 2020 tongchao. All rights reserved.
//

import UIKit

class DiskCache<T: NSCoding>: CacheProtocol {
    
    private let directory = NSHomeDirectory() + "Library/Caches/ImageCache"
    private let fileManager = FileManager()
    private let queue = DispatchQueue(label: "com.tony.diskCache", attributes: .concurrent)

    init() {
        do {
            try fileManager.createDirectory(at: URL.init(string: directory)!, withIntermediateDirectories: true, attributes: nil)
        }catch {
            print("FileManager error")
        }
    }
    
    public func get(key: String, completion: @escaping ((T?) -> Void)) {
        let path = pathForKey(key)

        coordinate {
            let value = NSKeyedUnarchiver.unarchiveObject(withFile: path) as? T
            completion(value)
        }
    }
    
    public func set(key: String, value: T, completion: (() -> Void)? = nil) {
        let path = pathForKey(key)
        let fileManager = self.fileManager

        coordinate(barrier: true) {
            if fileManager.fileExists(atPath: path) {
                do {
                    try fileManager.removeItem(atPath: path)
                } catch {}
            }
            NSKeyedArchiver.archiveRootObject(value, toFile: path)
        }
    }
    
    public func remove(key: String, completion: (() -> Void)? = nil) {
        let path = pathForKey(key)
        let fileManager = self.fileManager

        coordinate {
            if fileManager.fileExists(atPath: path) {
                do {
                    try fileManager.removeItem(atPath: path)
                } catch {}
            }
        }
    }
    
    public func removeAll(completion: (() -> Void)? = nil) {
        let fileManager = self.fileManager
        let directory = self.directory

        coordinate {
            guard let paths = try? fileManager.contentsOfDirectory(atPath: directory) else { return }

            for path in paths {
                do {
                    try fileManager.removeItem(atPath: path)
                } catch {}
            }
        }
    }
    
    private func coordinate(barrier: Bool = false, block: @escaping () -> Void) {
        if barrier {
            queue.async(flags: .barrier, execute: block)
            return
        }
        queue.async(execute: block)
    }
    
    private func pathForKey(_ key: String) -> String {
         return (directory as NSString).appendingPathComponent(key)
     }
}
