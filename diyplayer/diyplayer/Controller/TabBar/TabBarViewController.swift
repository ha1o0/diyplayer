//
//  TabBarViewController.swift
//  diyplayer
//
//  Created by sidney on 2019/7/21.
//  Copyright © 2019 sidney. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTabBar()
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated:Bool) {
        super.viewDidAppear(animated)
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    func setUpTabBar() {
        let homeController = HomeViewController()
        let homeNavigation = BaseNavigationViewController(rootViewController: homeController)
        homeNavigation.navigationBar.isHidden = true
        homeNavigation.tabBarItem.title = "首页"
        homeNavigation.tabBarItem.image = UIImage(named: "home")
        homeNavigation.tabBarItem.selectedImage = UIImage(named: "home_select")
        
        let channelController = ChannelViewController()
        let channelNavigation = BaseNavigationViewController(rootViewController: channelController)
        channelNavigation.navigationBar.isHidden = true
        channelNavigation.tabBarItem.title = "频道"
        channelNavigation.tabBarItem.image = UIImage(named: "channel")
        channelNavigation.tabBarItem.selectedImage = UIImage(named: "channel_select")
        
        let items = [homeNavigation, channelNavigation]
        for item in items {
            item.tabBarItem.selectedImage = item.tabBarItem.selectedImage?.withRenderingMode(.alwaysOriginal)
            item.tabBarItem.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.main], for: .selected)
            item.tabBarItem.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.tabBarGray], for: .normal)
        }
        self.viewControllers = items
        self.tabBar.barTintColor = UIColor.white
        self.tabBar.backgroundColor = UIColor.white
    }

}
