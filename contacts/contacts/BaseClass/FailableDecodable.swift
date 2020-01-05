//
//  FailableDecodable.swift
//  contacts
//
//  Created by tongchao on 2019/12/30.
//  Copyright © 2019 tongchao. All rights reserved.
//

import Foundation

struct FailableDecodable<Base : Decodable> : Decodable {

    let base: Base?

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.base = try? container.decode(Base.self)
    }
}
