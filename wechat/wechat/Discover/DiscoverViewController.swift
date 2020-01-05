//
//  DiscoverViewController.swift
//  wechat
//
//  Created by tongchao on 2019/12/21.
//  Copyright © 2019 tongchao. All rights reserved.
//

import UIKit

class DiscoverViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    public var tableView: UITableView?
    private let reuseID = "cell"
    
    override func viewDidLoad() {
//        let memoryCache = MemoryCache<UIImage>.init(countLimit: 20, automaticallyRemoveAllObjects: true)
//        let cache = MultiCache<UIImage>(caches: [memoryCache as! AnyCache<UIImage>])
        super.viewDidLoad()
        tableView = UITableView.init(frame: self.view.bounds, style: .grouped)
        tableView?.dataSource = self
        tableView?.delegate = self
        tableView?.register(UITableViewCell.self, forCellReuseIdentifier: reuseID)
        self.view.addSubview(tableView!)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseID, for: indexPath)
        cell.textLabel?.text = "朋友圈"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let momentViewContrller = MomentsViewController()
        self.navigationController?.pushViewController(momentViewContrller, animated: true)
    }
}
