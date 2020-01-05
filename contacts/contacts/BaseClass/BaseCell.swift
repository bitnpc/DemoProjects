//
//  BaseCollectionViewCell.swift
//  contacts
//
//  Created by tongchao on 2019/12/23.
//  Copyright © 2019 tongchao. All rights reserved.
//

import UIKit

class BaseCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public class func reuseIdentifier() -> String {
        return String(describing: self)
    }
}
