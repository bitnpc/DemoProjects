//
//  BaseTabBarController.swift
//  wechat
//
//  Created by tongchao on 2019/12/21.
//  Copyright © 2019 tongchao. All rights reserved.
//

import UIKit

class BaseTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let messageViewController = MessagesViewController();
        self.addViewController(viewController: messageViewController, title: "Message", image: nil, selectedImage: nil)
        let contactsViewController = ContactsViewController();
        self.addViewController(viewController: contactsViewController, title: "Contacts", image: nil, selectedImage: nil)
        let discoverViewController = DiscoverViewController();
        self.addViewController(viewController: discoverViewController, title: "Discover", image: nil, selectedImage: nil)
        let meViewController = MessagesViewController();
        self.addViewController(viewController: meViewController, title: "Me", image: nil, selectedImage: nil)
    }
    
    func addViewController(viewController: UIViewController, title: String, image: UIImage?, selectedImage: UIImage?) -> Void {
        viewController.view.backgroundColor = .white
        viewController.title = title
        viewController.tabBarItem.image = image
        viewController.tabBarItem.selectedImage = selectedImage
        
        let navController = UINavigationController.init(rootViewController: viewController)
        self.addChild(navController)
    }
}
