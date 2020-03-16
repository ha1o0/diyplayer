//
//  ScrollTabViewController.swift
//  diyplayer
//
//  Created by sidney on 2019/12/25.
//  Copyright © 2019 sidney. All rights reserved.
//

import UIKit
import SnapKit


class ScrollTabViewController: UIViewController, UIScrollViewDelegate {

    var contentScrollView = UIScrollView()
    var contentScrollViewHeight = SCREEN_HEIGHT - 68
    var contentScrollViewWidth = SCREEN_WIDTH
    var contentViewControllers:[UIViewController] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setScrollview()
        setContentViewControllers()
        // Do any additional setup after loading the view.
    }

    
    func setScrollview() {
        view.addSubview(contentScrollView)
        contentScrollView.snp.makeConstraints { (maker) in
            maker.width.equalTo(SCREEN_WIDTH)
            maker.height.equalTo(SCREEN_HEIGHT)
            maker.center.equalToSuperview()
        }
        contentScrollView.delegate = self
        contentScrollView.isPagingEnabled = true
        contentScrollView.bounces = false
        contentScrollView.showsHorizontalScrollIndicator = false
    }

    func setContentViewControllers() {
        for (index, child) in self.contentViewControllers.enumerated() {
            contentScrollView.addSubview(child.view)
            child.view.snp.makeConstraints { (maker) in
                maker.top.equalToSuperview()
                maker.bottom.equalToSuperview()
                maker.width.equalToSuperview()
                maker.leading.equalToSuperview().offset(CGFloat(index) * self.contentScrollViewWidth)
            }
            child.view.backgroundColor = index == 0 ? UIColor.red : UIColor.yellow
        }
    }
}
