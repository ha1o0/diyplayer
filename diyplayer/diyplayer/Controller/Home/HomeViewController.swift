//
//  HomeViewController.swift
//  diyplayer
//
//  Created by sidney on 2019/6/29.
//  Copyright © 2019 sidney. All rights reserved.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        navigationController?.isNavigationBarHidden = false
        setNavigation()
        let jumpBtn = UIButton()
        jumpBtn.setTitle("进入视频播放页", for: .normal)
        jumpBtn.setTitleColor(UIColor.black, for: .normal)
        jumpBtn.setTitleColor(UIColor.blue, for: .highlighted)
        jumpBtn.addTarget(self, action: #selector(toPlayView), for: .touchUpInside)
        self.view.addSubview(jumpBtn)
        jumpBtn.snp.makeConstraints { (maker) in
            maker.centerX.equalTo(self.view)
            maker.top.equalTo(self.view).offset(200)
        }
        
        let jumpBtn1 = UIButton()
        jumpBtn1.setTitle("进入普通页", for: .normal)
        jumpBtn1.setTitleColor(UIColor.black, for: .normal)
        jumpBtn1.setTitleColor(UIColor.blue, for: .highlighted)
        jumpBtn1.addTarget(self, action: #selector(toCustomView), for: .touchUpInside)
        self.view.addSubview(jumpBtn1)
        jumpBtn1.snp.makeConstraints { (maker) in
            maker.centerX.equalTo(self.view)
            maker.top.equalTo(self.view).offset(300)
        }
        // Do any additional setup after loading the view.
    }

    @objc func toPlayView() {
        self.navigationController?.pushViewController(PlayViewController(), animated: true)
    }
    
    @objc func toCustomView() {
        self.navigationController?.pushViewController(CustomViewController(), animated: true)
    }

    @objc func toProfile() {
        self.navigationController?.pushViewController(CustomViewController(), animated: true)
    }
    
    override func viewWillDisappear(_ animated:Bool) {
        super.viewWillDisappear(animated)
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = .lightContent
//        navigationController?.navigationBar.backgroundColor = UIColor.main
//        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidAppear(_ animated:Bool) {
        super.viewDidAppear(animated)
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    func setNavigation() {
        let statusView = UIView()
        self.view.addSubview(statusView)
        statusView.backgroundColor = UIColor.main
        statusView.snp.makeConstraints { (maker) in
            maker.top.equalTo(self.view).offset(0)
            maker.left.equalTo(self.view).offset(0)
            maker.trailing.equalTo(self.view).offset(0)
            maker.height.equalTo(44)
        }
        
        let navigationView = UIView()
        self.view.addSubview(navigationView)
        navigationView.backgroundColor = UIColor.main
        navigationView.snp.makeConstraints { (maker) in
            maker.top.equalTo(statusView.snp.bottom).offset(0)
            maker.left.equalTo(self.view).offset(0)
            maker.trailing.equalTo(self.view).offset(0)
            maker.height.equalTo(44)
        }
        
        let avatarImageView = UIImageView()
        avatarImageView.isUserInteractionEnabled = true
        navigationView.addSubview(avatarImageView)
        avatarImageView.snp.makeConstraints { (maker) in
            maker.left.equalToSuperview().offset(15)
            maker.centerY.equalToSuperview()
            maker.width.equalTo(33)
            maker.height.equalTo(33)
        }

        let avatarGesture = UITapGestureRecognizer(target: self, action: #selector(toProfile))
        avatarImageView.addGestureRecognizer(avatarGesture)
//        let avatarUrl = "https://upload.jianshu.io/users/upload_avatars/1228248/5db9890584a6?imageMogr2/auto-orient/strip|imageView2/1/w/240/h/240"
        let avatarUrl = "http://b-ssl.duitang.com/uploads/item/201809/24/20180924092018_zjgut.jpg"
        avatarImageView.loadFrom(link: avatarUrl, isCircle: true)
        navigationView.bringSubview(toFront: avatarImageView)
        
    }

}
