//
//  BaseNavigationViewController.swift
//  diyplayer
//
//  Created by sidney on 2019/6/29.
//  Copyright © 2019 sidney. All rights reserved.
//

import UIKit

class BaseNavigationViewController: UINavigationController, UINavigationControllerDelegate {
    var popDelegate:UIGestureRecognizerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        //navigationBar字体颜色设置
        
//        navigationBar字体颜色设置
//        self.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.green]
        self.popDelegate = self.interactivePopGestureRecognizer?.delegate
        self.delegate = self
//         Do any additional setup after loading the view.
    }

    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        if viewController == self.viewControllers[0] {
            self.interactivePopGestureRecognizer?.delegate = self.popDelegate
        } else {
            self.interactivePopGestureRecognizer?.delegate = nil;
        }
    }

//    override func popViewController(animated: Bool) -> UIViewController? {
//        
//    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
