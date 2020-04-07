//
//  LiveListView.swift
//  diyplayer
//
//  Created by sidney on 2020/4/6.
//  Copyright © 2020 sidney. All rights reserved.
//

import UIKit
import SnapKit

class LiveListView: UIView, UICollectionViewDataSource, UICollectionViewDelegate {
    
    private var collectionView: UICollectionView?
    private var pageViewList: [UIView]?
    private var callback : ((_ offset: CGFloat) -> ())?
    private var currentIndex: Int?
    
    @IBOutlet weak var testButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    
    // MARK: dataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count  = self.pageViewList?.count {
            return count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(indexPath.row)", for: indexPath)
        let scrollView = UIScrollView()
        scrollView.snp.makeConstraints { (maker) in
            maker.top.equalToSuperview()
            maker.bottom.equalToSuperview()
            maker.leading.equalToSuperview()
            maker.trailing.equalToSuperview()
        }
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.bounces = true
        if let view = self.pageViewList?[indexPath.row] {
            scrollView.addSubview(view)
            scrollView.contentSize = CGSize(width: view.bounds.width, height: view.bounds.height)
        }
        cell.contentView.addSubview(scrollView)
        return cell
    }
    
    // MARK: delegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if let contentOffset = collectionView?.contentOffset {
            if contentOffset.x == 0 {
                callback?(0)
            } else {
                callback?(contentOffset.x / self.frame.width)
            }
        }
    }
    
    func setPage(index: Int) {
        let point = CGPoint(x: CGFloat(index) * collectionView!.frame.size.width, y: collectionView!.frame.origin.y)
        collectionView?.setContentOffset(point, animated: true)
        currentIndex = index
    }

}
