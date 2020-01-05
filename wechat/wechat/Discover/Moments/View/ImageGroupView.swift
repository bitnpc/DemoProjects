//
//  ImageGroupView.swift
//  wechat
//
//  Created by tongchao on 2020/1/1.
//  Copyright © 2020 tongchao. All rights reserved.
//

import UIKit

class ImageGroupView: UIView {

    func configureImageViews(imageViewModels: [ImageViewModel]) {
        for i in 0..<imageViewModels.count {
            let viewModel = imageViewModels[i]
            let x = CGFloat(i % 3) * (viewModel.imageSize.width + 5)
            let y = CGFloat(i / 3) * (viewModel.imageSize.height + 5)
            
            let imageView = UIImageView.init(frame: CGRect.init(x: x, y: y, width: viewModel.imageSize.width, height: viewModel.imageSize.height))
            imageView.setImage(with: URL.init(string: viewModel.url)!)
            imageView.backgroundColor = .gray
            self.addSubview(imageView)
        }
    }
    
    func prepareToReuse() {
        for subView in self.subviews {
            subView.removeFromSuperview()
        }
    }
}
