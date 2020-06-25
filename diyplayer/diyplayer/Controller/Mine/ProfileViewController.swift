//
//  ProfileViewController.swift
//  diyplayer
//
//  Created by sidney on 2019/12/7.
//  Copyright © 2019 sidney. All rights reserved.
//

import UIKit
import SDWebImage

class ProfileViewController: CustomViewController {

    @IBOutlet weak var musicPlayerView: UIView!
    @IBOutlet weak var otherView: UIView!
    @IBOutlet weak var otherViewHeightConstraint: NSLayoutConstraint!
    var view1: UIView = UIView()
    var view2: UIImageView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view1.backgroundColor = UIColor.green
        otherView.addSubview(view1)
        view1.snp.makeConstraints { (maker) in
            maker.leading.trailing.top.equalToSuperview()
            maker.height.equalTo(0)
        }
        otherView.addSubview(view2)
        view2.snp.makeConstraints { (maker) in
            maker.top.equalTo(view1.snp.bottom)
            maker.leading.trailing.equalToSuperview()
            maker.height.equalTo(0)
        }
        
        
//        otherView.removeConstraint(otherViewHeightConstraint)
        
    }

    @IBAction func loadView1(_ sender: UIButton) {
        let itemCount: Int = 3
        let itemHeight: CGFloat = 100.0
        view1.snp.updateConstraints { (maker) in
            maker.height.equalTo(CGFloat(itemCount) * itemHeight)
        }
    }
    
    @IBAction func loadView2(_ sender: UIButton) {
        view2.sd_setImage(with: URL(string: "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1588007040840&di=a19a883b19989738f4f5d4c21f42de58&imgtype=0&src=http%3A%2F%2Fdingyue.ws.126.net%2F2020%2F0329%2F826dad88j00q7x2yk00dvd200m803elg00m803el.jpg")) { (image, error, cacheType, url) in
            let iHeight = image?.size.height ?? 0.0
            self.view2.snp.updateConstraints { (maker) in
                maker.height.equalTo(iHeight)
            }
            
            self.otherViewHeightConstraint.constant = self.view1.bounds.height + iHeight
        }
    }
    
    func findDisappearedNumbers(_ nums: [Int]) -> [Int] {
        var result: [Int] = []
        for index in 0..<nums.count {
            let target = index + 1
            if nums.contains(target) {
                continue
            }
            result.append(target)
        }
        return result
    }
}


public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init() { self.val = 0; self.next = nil; }
    public init(_ val: Int) { self.val = val; self.next = nil; }
    public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
}
