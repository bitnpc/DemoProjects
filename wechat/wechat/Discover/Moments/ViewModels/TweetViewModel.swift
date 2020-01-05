//
//  TweetViewModel.swift
//  wechat
//
//  Created by tongchao on 2019/12/21.
//  Copyright © 2019 tongchao. All rights reserved.
//

private struct SizeConst {
    static let screenWidth = UIScreen.main.bounds.width
    static let screenHeight = UIScreen.main.bounds.height
    static let contentWidth = min(screenWidth, screenHeight) - 100
    static let maxSize = CGSize.init(width: contentWidth, height: CGFloat.greatestFiniteMagnitude)
    static let avatar = CGSize.init(width: 44, height: 44)
    static let image = CGSize.init(width: (contentWidth - 10) / 3, height: (contentWidth - 10) / 3)
}

private struct FontConst {
    static let nick = UIFont.systemFont(ofSize: 16)
    static let sender = UIFont.systemFont(ofSize: 14)
    static let content = UIFont.systemFont(ofSize: 16)
    static let comment = UIFont.systemFont(ofSize: 14)
}

private struct ColorConst {
    static let content = UIColor.black
    static let sender = UIColor.blue
    static let comment = UIColor.black
}

import UIKit

class CommentViewModel: NSObject {

    public let content: NSAttributedString
    public let contentSize: CGSize
    
    init(model: Comment) {
        let content = NSMutableAttributedString.init()
        if let sender = model.sender {
            let attributes = [
                NSAttributedString.Key.font: FontConst.comment,
                NSAttributedString.Key.foregroundColor: ColorConst.sender
            ]
            let name = NSAttributedString.init(string: (sender.nick != nil) ? sender.nick! + ": " : "", attributes: attributes)
            content.append(name)
        }
        if let commentContent = model.content {
            let attributes = [
                NSAttributedString.Key.font: FontConst.comment,
                NSAttributedString.Key.foregroundColor: ColorConst.comment
            ]
            let comment = NSAttributedString.init(string: commentContent, attributes: attributes)
            content.append(comment)
        }
        self.content = content
        let size = content.boundingRect(with: SizeConst.maxSize, options: .usesLineFragmentOrigin, context: nil).size
        self.contentSize = CGSize.init(width: SizeConst.contentWidth, height: ceil(size.height))
        super.init()
    }
}

class UserViewModel: NSObject {
    
    public let username: String
    public let nick: String
    public let avatar: String
    public let profileImage: String
    
    init(model: Sender) {
        username = model.username ?? ""
        nick = model.nick ?? ""
        avatar = model.avatar ?? ""

        guard let proImg = model.profileImage else {
            profileImage = ""
            return
        }
        if !(proImg.hasPrefix("https")) {
            profileImage = proImg.replacingOccurrences(of: "http", with: "https")
        }else {
            profileImage = proImg
        }
    }
}

class ImageViewModel: NSObject {
    public let url: String
    public let imageSize = SizeConst.image
    
    init(model: Image) {
        url = model.url ?? ""
    }
}

class TweetViewModel: NSObject {
    
    public lazy var cellHeight: CGFloat = self.contentSize.height + self.imageGroupSize.height + 120

    public let avatarSize = SizeConst.avatar
    public var avatar: String!
    
    public let nick: NSAttributedString
    
    public var content: NSAttributedString
    public var contentSize: CGSize!
    
    public var imageViewModels: [ImageViewModel]
    public let imageGroupSize: CGSize
    
    public let commentViewModels: [CommentViewModel]
    public let commentViewSize: CGSize
    
    init(model: Tweet) {
        if let sender = model.sender {
            avatar = sender.avatar ?? ""
            nick = NSAttributedString.init(string: sender.nick ?? "Nickname", attributes: [NSAttributedString.Key.font : FontConst.nick])
        }else {
            avatar = ""
            nick = NSAttributedString.init(string: "Nickname")
        }
        
        let attributes = [
            NSAttributedString.Key.font: FontConst.content,
            NSAttributedString.Key.foregroundColor: ColorConst.content
        ]
        content = NSAttributedString.init(string: model.content ?? "", attributes: attributes)
        let size = content.boundingRect(with: SizeConst.maxSize, options: .usesLineFragmentOrigin , context: nil).size
        contentSize = CGSize.init(width: SizeConst.contentWidth, height: ceil(size.height))
        
        if !(avatar.hasPrefix("https")) {
            avatar = avatar.replacingOccurrences(of: "http", with: "https")
        }
        
        if let images = model.images {
            imageViewModels = images.compactMap({ (image) -> ImageViewModel in
                return ImageViewModel.init(model: image)
            })
            let cnt = imageViewModels.count
            imageGroupSize = CGSize.init(width: SizeConst.contentWidth, height: CGFloat(ceil(Double(cnt) / 3)) * SizeConst.image.width)
        }else {
            imageViewModels = []
            imageGroupSize = .zero
        }
        
        if let comments = model.comments {
            var width: CGFloat = 0.0
            var height: CGFloat = 0.0
            self.commentViewModels = comments.compactMap({ (comment) -> CommentViewModel in
                return CommentViewModel.init(model: comment)
            })
            for viewModel in self.commentViewModels {
                height += viewModel.contentSize.height
                width = viewModel.contentSize.width
            }
            commentViewSize = CGSize.init(width: width, height: height + 5)
        }else {
            self.commentViewModels = []
            commentViewSize = .zero
        }
    }
}
