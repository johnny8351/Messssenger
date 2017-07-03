//
//  CustomTabBarController.swift
//  Messenger
//
//  Created by CHENG-SYUANYU on 2017/7/3.
//  Copyright © 2017年 CHENG-SYUANYU. All rights reserved.
//

import UIKit
class CustomTabBarController: UITabBarController{
    override func viewDidLoad() {
        super.viewDidLoad()
        //setup our custom view controller
        let layout = UICollectionViewFlowLayout()
        let friendsController = FriendsController(collectionViewLayout:layout)
        let recentMessageNavController = UINavigationController(rootViewController: friendsController)
        recentMessageNavController.tabBarItem.title = "Recent"
        viewControllers = [recentMessageNavController]
    }
}
