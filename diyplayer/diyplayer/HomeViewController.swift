//
//  HomeViewController.swift
//  diyplayer
//
//  Created by sidney on 2018/8/26.
//  Copyright © 2018年 sidney. All rights reserved.
//

import UIKit
import SnapKit

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
        let playerView = DiyPlayerView(frame: CGRect(x: 0, y: 20, width: 375, height: 250))
        playerView.commonInit()
        self.view.addSubview(playerView)
    }

}
