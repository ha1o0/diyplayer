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
        
        let circleController = CircleViewController()
        let circleNavigation = BaseNavigationViewController(rootViewController: circleController)
        circleNavigation.navigationBar.isHidden = true
        circleNavigation.tabBarItem.title = "动态"
        circleNavigation.tabBarItem.image = UIImage(named: "circletab")
        circleNavigation.tabBarItem.selectedImage = UIImage(named: "circletab_select")
        
        let profileController = ProfileViewController()
        let profileNavigation = BaseNavigationViewController(rootViewController: profileController)
        profileNavigation.navigationBar.isHidden = true
        profileNavigation.tabBarItem.title = "我的"
        profileNavigation.tabBarItem.image = UIImage(named: "profile")
        profileNavigation.tabBarItem.selectedImage = UIImage(named: "profile_select")
        
        let items = [homeNavigation, channelNavigation, circleNavigation, profileNavigation]
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
