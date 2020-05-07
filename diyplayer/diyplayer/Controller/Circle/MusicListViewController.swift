//
//  MusicListViewController.swift
//  diyplayer
//
//  Created by sidney on 2020/4/26.
//  Copyright © 2020 sidney. All rights reserved.
//

import UIKit

class MusicListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var footerView: UIView!
    
    var musicList: [MusicPlayerModel]  = []

    override func viewDidLoad() {
        super.viewDidLoad()
//        let blurEffect = UIBlurEffect(style: .extraLight)
//        let blurEffectView = UIVisualEffectView(effect: blurEffect)
//        blurEffectView.frame = self.view.frame
//        self.view.insertSubview(blurEffectView, at: 0)
        for _ in 0...30 {
            let musicPlayerModel: MusicPlayerModel = MusicPlayerModel()
            musicList.append(musicPlayerModel)
        }
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: "TestAutoTableViewCell", bundle: nil), forCellReuseIdentifier: "TestAutoTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        setBlurEffect(targetView: self.view)
        setBlurEffect()
        setBlurEffect(targetView: headerView)
        setBlurEffect(targetView: footerView)
        let gesture = UITapGestureRecognizer(target: self, action: #selector(closeSelf))
        shadowView.addGestureRecognizer(gesture)

    }

    func setBlurEffect() {
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = tableView.frame
        tableView.backgroundView = blurEffectView
        tableView.separatorEffect = UIVibrancyEffect(blurEffect: blurEffect)
    }
    
    func setBlurEffect(targetView: UIView) {
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = targetView.frame
        targetView.insertSubview(blurEffectView, at: 0)
    }
    
    @objc func closeSelf() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func closeModal(_ sender: UIButton) {
        closeSelf()
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

// MARK: - TabelViewDelegate
extension MusicListViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        musicList.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 100
    }
}

// MARK: - TabelViewDataSource
extension MusicListViewController {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TestAutoTableViewCell", for: indexPath) as! TestAutoTableViewCell
        cell.targetButton.tag = indexPath.row
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 60))
        let titleLabel = UILabel()
        titleLabel.text = "当前播放列表"
        titleLabel.textColor = UIColor.white
        headerView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (maker) in
            maker.center.equalToSuperview()
        }
        return headerView
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 100))
        let closeButton = UIButton()
        closeButton.titleLabel?.text = "关闭"
        closeButton.titleLabel?.textColor = UIColor.white
        closeButton.addTarget(self, action: #selector(closeSelf), for: .touchUpInside)
        footerView.addSubview(closeButton)
        closeButton.snp.makeConstraints { (maker) in
            maker.center.equalToSuperview()
        }
        return footerView
    }
}

