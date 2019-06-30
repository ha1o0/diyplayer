//
//  BaseNavigationViewController.swift
//  diyplayer
//
//  Created by sidney on 2019/6/29.
//  Copyright © 2019 sidney. All rights reserved.
//

import UIKit

class BaseNavigationViewController: UINavigationController,UINavigationControllerDelegate {
    var popDelegate:UIGestureRecognizerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        //navigationBar字体颜色设置
        navigationBar.isHidden = true
        self.navigationBar.barTintColor = UIColor.green
        self.navigationBar.tintColor = UIColor.green
        //navigationBar字体颜色设置
        self.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.green]
        self.popDelegate = self.interactivePopGestureRecognizer?.delegate
        self.delegate = self
        // Do any additional setup after loading the view.
    }

    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        //实现滑动返回的功能
        //清空滑动返回手势的代理就可以实现
        if viewController == self.viewControllers[0] {
            self.interactivePopGestureRecognizer?.delegate = self.popDelegate
        } else {
            self.interactivePopGestureRecognizer?.delegate = nil;
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
