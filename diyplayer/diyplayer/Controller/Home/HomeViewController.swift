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
        let jumpBtn = UIButton()
        jumpBtn.setTitle("进入视频播放页", for: .normal)
        jumpBtn.setTitleColor(UIColor.black, for: .normal)
        jumpBtn.setTitleColor(UIColor.blue, for: .highlighted)
        jumpBtn.addTarget(self, action: #selector(toPlayView), for: .touchUpInside)
        self.view.addSubview(jumpBtn)
        jumpBtn.snp.makeConstraints { (maker) in
            maker.centerX.equalTo(self.view)
            maker.centerY.equalTo(self.view)
        }
        
        // Do any additional setup after loading the view.
    }

    @objc func toPlayView() {
        self.navigationController?.pushViewController(PlayViewController(), animated: true)
    }

    override func viewWillDisappear(_ animated:Bool) {
        super.viewWillDisappear(animated)
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    override func viewDidAppear(_ animated:Bool) {
        super.viewDidAppear(animated)
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
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
