//
//  BaseViewController.swift
//  diyplayer
//
//  Created by sidney on 2019/7/3.
//  Copyright © 2019 sidney. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setCustomNav()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        if (self.navigationController?.isNavigationBarHidden ?? false) {
//            setCustomNav()
//        }
        
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }

    func setCustomNav() {
        self.navigationController?.navigationBar.barStyle = .default
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.backgroundColor = UIColor.main
        
        let navigationBarView = UIView()
        self.view.addSubview(navigationBarView)
        navigationBarView.backgroundColor = UIColor.main
        navigationBarView.snp.makeConstraints { (maker) in
            maker.top.equalTo(self.view).offset(0)
            maker.left.equalTo(self.view).offset(0)
            maker.trailing.equalTo(self.view).offset(0)
            maker.height.equalTo(44 + 44)
        }
        
        
        let leftBarBtn = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(leftClick))
        leftBarBtn.image = UIImage(named: "leftBack")
        let spacer = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        spacer.width = 50
        self.navigationItem.leftBarButtonItems = [spacer, leftBarBtn]
//        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "leftBack")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(leftClick))
        
    }
    
    @objc func leftClick() {
        self.navigationController?.popViewController(animated: true)
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
