//
//  BaseCell.swift
//  wechat
//
//  Created by tongchao on 2020/1/1.
//  Copyright © 2020 tongchao. All rights reserved.
//

import UIKit

class BaseCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.backgroundColor = .white
    }
    
    public class func reuseIdentifier() -> String {
        return String(describing: self)
    }
}
