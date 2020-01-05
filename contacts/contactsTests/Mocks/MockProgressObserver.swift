//
//  MockProgressObserver.swift
//  contactsTests
//
//  Created by tongchao on 2019/12/30.
//  Copyright © 2019 tongchao. All rights reserved.
//

import Foundation
@testable import contacts

class MockProgressObserver: ProgressUpdateProtocol {
    
    var updated: Bool = false
    var progress: Double = 0
    
    func update(_ progress: Double) {
        self.updated = true
        self.progress = progress
    }
}
