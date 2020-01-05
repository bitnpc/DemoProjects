//
//  IntroCell.swift
//  contacts
//
//  Created by tongchao on 2019/12/24.
//  Copyright © 2019 tongchao. All rights reserved.
//

import UIKit

private struct FontConst {
    static let title = UIFont.boldSystemFont(ofSize: 19)
    static let subtitle = UIFont.systemFont(ofSize: 14)
    static let aboutMe = UIFont.boldSystemFont(ofSize: 15)
    static let intro = UIFont.systemFont(ofSize: 14)
}

class IntroCell: BaseCell {
    
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let aboutMeLabel = UILabel()
    private let introTextView = UITextView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupUI()
    }
    
    private func setupUI() {
        setupTitle()
        setupSubtitle()
        setupAboutMe()
        setupIntro()
    }
    
    private func setupTitle() {
        titleLabel.textAlignment = .center
        contentView.addSubview(titleLabel)
        titleLabel.pin(top: 0, leading: 0, trailing: 0)
    }
    
    private func setupSubtitle() {
        subtitleLabel.font = FontConst.subtitle
        subtitleLabel.textColor = .gray
        subtitleLabel.textAlignment = .center
        contentView.addSubview(subtitleLabel)
        subtitleLabel.pin(height: 30)
        subtitleLabel.pin(top: titleLabel.bottomAnchor,
                          leading: contentView.leadingAnchor,
                          trailing: contentView.trailingAnchor)
    }
    
    private func setupAboutMe() {
        aboutMeLabel.font = FontConst.aboutMe
        aboutMeLabel.text = "About me"
        contentView.addSubview(aboutMeLabel)
        aboutMeLabel.pin(top: subtitleLabel.bottomAnchor, offset: 30)
        aboutMeLabel.pin(leading: contentView.leadingAnchor, offset: 25)
    }
    
    private func setupIntro() {
        introTextView.isEditable = false
        introTextView.font = FontConst.intro
        introTextView.textColor = .gray
        introTextView.textContainerInset = .zero
        contentView.addSubview(introTextView)
        introTextView.pin(top: aboutMeLabel.bottomAnchor, offset: 4)
        introTextView.pin(leading: contentView.leadingAnchor, offset: 20)
        introTextView.pin(bottom: contentView.bottomAnchor, offset: -8)
        introTextView.pin(trailing: contentView.trailingAnchor, offset: -20)
    }
    
    func configure(with viewModel: IntroViewModel) {
        let title = NSMutableAttributedString(string: viewModel.firstName)
        title.addAttributes([.font: FontConst.title],
                            range: NSRange(location: 0, length: viewModel.firstName.count))
        title.append(NSAttributedString(string: " " + viewModel.lastName))
        
        titleLabel.attributedText = title
        subtitleLabel.text = viewModel.subtitle
        introTextView.text = viewModel.intro
    }
}
