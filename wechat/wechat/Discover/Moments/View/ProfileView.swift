//
//  ProfileView.swift
//  wechat
//
//  Created by tongchao on 2019/12/21.
//  Copyright © 2019 tongchao. All rights reserved.
//

import UIKit

private struct Const {
    static let AvatarWidth = CGFloat(70)
    static let AvatarHeight = CGFloat(70)
}

class ProfileView: UIView {

    private let bgImageView = UIImageView()
    private let avatarImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    private func setupUI() {
        self.backgroundColor = .white
        self.setupBackground()
        self.setupAvatarImageView()
    }

    private func setupBackground() {
        bgImageView.backgroundColor = .lightGray
        self.addSubview(bgImageView)
        bgImageView.pin(top: 0, leading: 0, bottom: -22, trailing: 0)
    }
    
    private func setupAvatarImageView() {
        avatarImageView.backgroundColor = .gray
        self.addSubview(self.avatarImageView)
        avatarImageView.pin(width: Const.AvatarWidth, height: Const.AvatarHeight)
        avatarImageView.pin(bottom: 0, trailing: -12)
    }
    
    func configure(with model: UserViewModel) {
        bgImageView.setImage(with: URL.init(string: model.profileImage)!)
        avatarImageView.setImage(with: URL.init(string: model.avatar)!)
    }
    
}
