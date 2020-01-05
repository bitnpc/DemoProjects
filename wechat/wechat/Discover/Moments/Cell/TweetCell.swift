//
//  TweetCell.swift
//  wechat
//
//  Created by tongchao on 2019/12/21.
//  Copyright © 2019 tongchao. All rights reserved.
//

import UIKit

class TweetCell: BaseCell {
    
    private let nameLabel = UILabel()
    private let avatarImageView = UIImageView()
    private let contentTextView = UITextView()
    private let commentGroupView = CommentGroupView()
    private let imageGroupView = ImageGroupView()
    private let commentHoverView = CommentHoverView()
    
    private weak var viewModel: TweetViewModel?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupUI()
    }
    
    func setupUI() {
        avatarImageView.backgroundColor = .gray
        contentView.addSubview(avatarImageView)
        
        contentView.addSubview(nameLabel)
        
        contentTextView.textContainerInset = .zero
        contentTextView.textContainer.lineFragmentPadding = 0
        contentTextView.isEditable = false
        contentTextView.showsVerticalScrollIndicator = false
        contentView.addSubview(contentTextView)
        
        contentView.addSubview(imageGroupView)
        contentView.addSubview(commentGroupView)
    }

    func configure(with viewModel: TweetViewModel) {
        self.viewModel = viewModel
        avatarImageView.setImage(with: URL.init(string: viewModel.avatar)!)
//        avatarImageView.kf.setImage(with: URL.init(string: viewModel.avatar))
        nameLabel.attributedText = viewModel.nick
        contentTextView.attributedText = viewModel.content
        commentGroupView.configure(viewModels: viewModel.commentViewModels)
        imageGroupView.configureImageViews(imageViewModels: viewModel.imageViewModels)
        
        self.setNeedsLayout()
    }
    
    override func prepareForReuse() {
        imageGroupView.prepareToReuse()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        guard let viewModel = self.viewModel else {
            return
        }
        
        // The magic number here is not so good, time is limited
        nameLabel.frame.origin = CGPoint(x: 80, y: 16)
        nameLabel.frame.size = CGSize.init(width: 100, height: 15)
        
        avatarImageView.frame.size = viewModel.avatarSize
        avatarImageView.frame.origin = CGPoint(x: 20, y: 15)
        
        contentTextView.frame.size = viewModel.contentSize
        contentTextView.frame.origin = CGPoint(x: 80, y: 40)
        
        imageGroupView.frame.size = viewModel.imageGroupSize
        imageGroupView.frame.origin = CGPoint(x: 80, y: contentTextView.frame.maxY + 10)
        
        let offset = max(contentTextView.frame.maxY, imageGroupView.frame.maxY) + 10
        commentGroupView.frame.size = viewModel.commentViewSize
        commentGroupView.frame.origin = CGPoint(x: 80, y: offset)
    }
}
