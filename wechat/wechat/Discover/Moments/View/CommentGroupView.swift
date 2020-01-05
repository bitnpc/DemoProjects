//
//  CommentGroupView.swift
//  wechat
//
//  Created by tongchao on 2019/12/21.
//  Copyright © 2019 tongchao. All rights reserved.
//

import UIKit

class CommentGroupView: UIView, UITableViewDelegate, UITableViewDataSource {
    
    public let tableView = UITableView.init(frame: .zero, style: .plain)
    private var comments: [CommentViewModel]?
    
    internal class CommentCell: BaseCell {
        
        private let commentLabel = UILabel()
        
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            setupUI()
        }
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
            setupUI()
        }
        
        func setupUI() {
            self.backgroundColor = UIColor.init(hex: 0xf3f3f5)
            contentView.addSubview(commentLabel)
        }
        
        func configure(viewModel: CommentViewModel) {
            self.commentLabel.attributedText = viewModel.content
        }
        
        override func layoutSubviews() {
            super.layoutSubviews()
            commentLabel.frame = contentView.bounds
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    func setupUI() {
        setupTriangleLayer()
        setupTableView()
    }
    
    func setupTriangleLayer() {
        let triangleLayer = CAShapeLayer()
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 16, y: 0))
        bezierPath.addLine(to: CGPoint(x: 22, y: 5))
        bezierPath.addLine(to: CGPoint(x: 10, y: 5))
        bezierPath.addLine(to: CGPoint(x: 16, y: 0))
        triangleLayer.path = bezierPath.cgPath
        triangleLayer.strokeColor = UIColor.init(hex: 0xf3f3f5).cgColor
        triangleLayer.fillColor = UIColor.init(hex: 0xf3f3f5).cgColor
        self.layer.addSublayer(triangleLayer)
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.register(CommentCell.self, forCellReuseIdentifier: CommentCell.reuseIdentifier())
        self.addSubview(tableView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        tableView.frame = CGRect.init(x: 0, y: 5, width: self.frame.width, height: self.frame.height - 5)
    }
    
    func configure(viewModels: [CommentViewModel]) {
        comments = viewModels
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let comments = self.comments else {
            return 0;
        }
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CommentCell.reuseIdentifier(), for: indexPath) as! CommentCell
        guard let comments = self.comments else {
            return cell;
        }
        cell.configure(viewModel: comments[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let comments = self.comments else {
            return 0;
        }
        return comments[indexPath.row].contentSize.height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}
