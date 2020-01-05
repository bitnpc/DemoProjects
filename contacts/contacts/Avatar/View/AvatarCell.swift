//
//  AvatarCell.swift
//  contacts
//
//  Created by tongchao on 2019/12/23.
//  Copyright © 2019 tongchao. All rights reserved.
//

import UIKit

private struct SizeConst {
    static let highlight = CGSize(width: 72.0, height: 72.0)
    static let avatar = CGSize(width: 65.0, height: 65.0)
}

private struct ColorConst {
    static let hightlight = UIColor.gray
}

class AvatarCell: BaseCell {
    private let highlightView = UIView()
    private let avatarImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupUI()
    }
    
    private func setupUI() -> Void {
        self.highlightView.alpha = 0
        self.highlightView.backgroundColor = ColorConst.hightlight
        self.highlightView.layer.cornerRadius = SizeConst.highlight.width / 2
        self.contentView.addSubview(self.highlightView)
        self.highlightView.pin(width: SizeConst.highlight.width, height: SizeConst.highlight.height)
        self.highlightView.pinToSuperviewCenter()
        
        self.contentView.addSubview(self.avatarImageView)
        self.avatarImageView.pin(width: SizeConst.avatar.width, height: SizeConst.avatar.height)
        self.avatarImageView.pinToSuperviewCenter()
    }
    
    func configure(with viewModel: AvatarViewModel) -> Void {
        self.avatarImageView.image = UIImage(named: viewModel.imageName)
    }
    
    func updateHightlight(value: CGFloat) -> Void {
        highlightView.alpha = value
    }
}
