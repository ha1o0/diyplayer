//
//  HomeViewController.swift
//  diyplayer
//
//  Created by sidney on 2018/8/26.
//  Copyright © 2018年 sidney. All rights reserved.
//

import UIKit
import SnapKit
import Alamofire
import SwiftyJSON

class HomeViewController: UIViewController {

    var diyPlayerView = DiyPlayerView()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let playerView = DiyPlayerView(frame: CGRect(x: 0, y: 40, width: UIScreen.main.bounds.width, height: 250))
        playerView.commonInit()
        self.view.addSubview(playerView)
        let uiView = UIView()
        uiView.backgroundColor = UIColor.gray
        self.view.addSubview(uiView)
        uiView.snp.makeConstraints { (maker) in
            maker.left.equalToSuperview().offset(0)
            maker.trailing.equalToSuperview().offset(0)
            maker.top.equalTo(playerView.snp.bottom).offset(20)
            maker.height.equalTo(50)
        }

        let requestBtn = UIButton()
        requestBtn.setTitle("请求数据", for: .normal)
        requestBtn.setTitleColor(UIColor.white, for: .normal)
        uiView.addSubview(requestBtn)
        requestBtn.snp.makeConstraints { (maker) in
            maker.center.equalToSuperview()
        }
        requestBtn.addTarget(self, action: #selector(getNetData), for: .touchUpInside)
    }

    @objc func getNetData() {
        let url = "https://www.sojson.com/api/beian/sojson.com"
        Alamofire.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                let nowIcp = json["nowIcp"].stringValue
                print(nowIcp)
            case .failure(let error):
                print(error)
            }
        }
        print("00000")
    }

}
