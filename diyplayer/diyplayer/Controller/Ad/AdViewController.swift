//
//  AdViewController.swift
//  diyplayer
//
//  Created by sidney on 2019/6/29.
//  Copyright © 2019 sidney. All rights reserved.
//

import UIKit

class AdViewController: UIViewController {
    @IBOutlet weak var switchButton: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigation()
        switchButton.addTarget(self, action: #selector(switchDidChange), for: .valueChanged)
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigation()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.switchButton.isOn = false
    }
    
    @objc func switchDidChange(){
        if (self.switchButton.isOn) {
            self.navigationController?.pushViewController(HomeViewController(), animated: true)
        }
    }
    
    func setNavigation() {
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(),for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
}
