//
//  ProgressSynchronizer.swift
//  contacts
//
//  Created by tongchao on 2019/12/29.
//  Copyright © 2019 tongchao. All rights reserved.
//

import UIKit

protocol ProgressUpdateProtocol: class {
    func update(_ progress: Double) -> Void
}

protocol ProgressSyncDelegate: class {
    func didUpdate(subject: AnyObject, progress: Double) -> Void
}

class ProgressSynchronizer: ProgressSyncDelegate {
    
    private var currentSubject: AnyObject?
    private let observers = WeakArray<ProgressUpdateProtocol>()
    private var currentClearTask: DispatchWorkItem?
    
    func addObserver(observer: ProgressUpdateProtocol) -> Void {
        self.observers.add(observer)
    }
    
    func didUpdate(subject: AnyObject, progress: Double) -> Void {
        // Sync only in main thread
        guard Thread.current == .main else {
            return
        }
        if currentSubject == nil {
            currentSubject = subject
        }
        if currentSubject !== subject {
            return
        }
        // Update all observers except currentSubject
        observers.filter({ $0 as AnyObject !== subject }).forEach({ $0.update(progress) })
        
        // Clear previous subject to let observers update from other subject
        self.clearPreSubject()
    }
    
    private func clearPreSubject() -> Void {
        currentClearTask?.cancel()
        let item = DispatchWorkItem {
            self.currentSubject = nil
        }
        currentClearTask = item
        let interval = DispatchTime.now() + 0.25
        DispatchQueue.main.asyncAfter(deadline: interval, execute: item)
    }
}
