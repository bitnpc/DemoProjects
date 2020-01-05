//
//  MomentsViewController.swift
//  wechat
//
//  Created by tongchao on 2019/12/21.
//  Copyright © 2019 tongchao. All rights reserved.
//

import UIKit

private struct Const {
    static let headerHeight = CGFloat(200)
}

class MomentsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    public var tableView = UITableView.init(frame: .zero, style: .grouped)
    
    // As the API does not support paging, here we store all the tweets.
    private var tweetViewModels: [TweetViewModel]?
    
    // Currently displayed tweets
    private var displayTweets: [TweetViewModel]?
    
    // API services
    private let tweetService = TweetService()
    private let userInfoService = UserInfoService()
    
    private let profileView = ProfileView()
    
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.setupTableView()
        self.getUserInfo(param: nil)
        self.getTweets(param: nil)
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TweetCell.self, forCellReuseIdentifier: TweetCell.reuseIdentifier())
        tableView.allowsSelection = false
        self.view.addSubview(tableView)
        tableView.pinToSuperview()
        
        self.setupTableHeaderView()
        self.setupRefreshControl()
    }
    
    func setupTableHeaderView() {
        profileView.frame.size.height = Const.headerHeight
        tableView.tableHeaderView = profileView
    }
    
    func setupRefreshControl() {
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    @objc func refresh(sender:AnyObject) {
        self.getTweets(param: nil)
    }
    
    func getUserInfo(param: Dictionary<String, String>?) -> Void {
        userInfoService.getUserInfo(param: nil) { (user: Sender) in
            let user = UserViewModel.init(model: user)
            self.profileView.configure(with: user)
        }
    }
    
    func getTweets(param: Dictionary<String, String>?) -> Void {
        tweetService.fetchTweets(param: param) { (tweets: [Tweet]) in
            let viewModels = tweets.compactMap({ (tweet) -> TweetViewModel? in
                // ignore tweet whose images and content are both nil
                if tweet.images == nil && tweet.content == nil {
                    return nil
                }
                return TweetViewModel.init(model: tweet)
            })
            self.refreshControl.endRefreshing()
            self.tweetViewModels = viewModels
            self.displayTweets = self.slice(objects: viewModels, position: 5)
            self.tableView.reloadData()
        }
    }
    
    func slice(objects: Array<TweetViewModel>, position: Int) -> Array<TweetViewModel> {
        let fixedPosition = min(objects.count, position)
        let sliced = Array(objects[0..<fixedPosition])
        return sliced
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModels = displayTweets else { return 0 }
        return viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TweetCell = tableView.dequeueReusableCell(withIdentifier: TweetCell.reuseIdentifier(), for: indexPath) as! TweetCell
        let tweetViewModel = displayTweets![indexPath.row]
        cell.configure(with: tweetViewModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let tweetViewModel = displayTweets![indexPath.row]
        return tweetViewModel.cellHeight
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let viewModels = tweetViewModels else { return }
        if displayTweets?.count == viewModels.count { return }
        if scrollView.contentOffset.y > scrollView.contentSize.height - scrollView.frame.size.height - 44 {
            self.displayTweets = self.slice(objects: viewModels, position: self.displayTweets!.count + 5)
            tableView.reloadData()
        }
    }
}
