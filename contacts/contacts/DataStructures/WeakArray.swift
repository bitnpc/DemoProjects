//
//  WeakArray.swift
//  contacts
//
//  Created by tongchao on 2019/12/29.
//  Copyright © 2019 tongchao. All rights reserved.
//

import Foundation

class WeakArray<T>: Sequence {

    private let hashTable = NSHashTable<AnyObject>.weakObjects()

    func add(_ obj: T) -> Void {
        hashTable.add(obj as AnyObject)
    }
    
    func remove(_ obj: T) -> Void {
        hashTable.remove(obj as AnyObject)
    }
    
    var count: Int {
        return hashTable.count
    }

    func makeIterator() -> Array<T>.Iterator {
        let allObjects = hashTable.allObjects.compactMap { $0 as? T }
        return allObjects.makeIterator()
    }
}
