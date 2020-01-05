//
//  UICollectionView+Center.swift
//  contacts
//
//  Created by tongchao on 2019/12/29.
//  Copyright © 2019 tongchao. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    var centerPoint: CGPoint {
        get {
            return CGPoint(x: center.x + contentOffset.x, y: center.y + contentOffset.y)
        }
    }
    
    var centerIndexPath: IndexPath? {
        get {
            return indexPathForItem(at: centerPoint)
        }
    }
    
    var centerCell: UICollectionViewCell? {
        get {
            guard let indexPath = centerIndexPath else {
                return nil
            }
            return cellForItem(at: indexPath)
        }
    }
}
