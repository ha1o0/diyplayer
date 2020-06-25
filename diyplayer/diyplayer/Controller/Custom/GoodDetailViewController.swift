//
//  GoodDetailViewController.swift
//  diyplayer
//
//  Created by sidney on 2020/4/29.
//  Copyright © 2020 sidney. All rights reserved.
//

import UIKit

class GoodDetailViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    

    @IBOutlet weak var collectionView: UICollectionView!
    
    var dataSource: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.estimatedItemSize = UICollectionViewFlowLayoutAutomaticSize
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 20
        collectionView.collectionViewLayout = layout
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.contentInsetAdjustmentBehavior = .always
        registerCells()
        dataSource = ["XIAOMI", "HUAWEI", "APPLE", "MEIZU"]
        // Do any additional setup after loading the view.
    }
    
    func registerCells() {
        collectionView.register(UINib(nibName: "GoodIntroduceCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "GoodIntroduceCollectionViewCell")
        collectionView.register(UINib(nibName: "GoodDetailCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "GoodDetailCollectionViewCell")
        collectionView.register(UINib(nibName: "GoodRecommendedCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "GoodRecommendedCollectionViewCell")
    }

}

extension GoodDetailViewController {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 2 {
            return dataSource.count
        } else {
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GoodIntroduceCollectionViewCell", for: indexPath) as! GoodIntroduceCollectionViewCell
            cell.setCellContent()
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GoodDetailCollectionViewCell", for: indexPath) as! GoodDetailCollectionViewCell
            cell.setCellContent(collectionView: self.collectionView, indexPath: indexPath)
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GoodRecommendedCollectionViewCell", for: indexPath) as! GoodRecommendedCollectionViewCell
            cell.setCell(name: dataSource[indexPath.row])
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GoodRecommendedCollectionViewCell", for: indexPath)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 2 {
            return UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        }
        return .zero
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        if indexPath.section == 1 {
//            return CGSize(width: SCREEN_WIDTH, height: 500)
//        }
//        return .zero
//    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 10
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 10
//    }
}

extension GoodDetailViewController {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        print(indexPath)
        if indexPath.section == 2 && indexPath.row == dataSource.count - 1 {
            let new: [String] = ["XIAOMI", "HUAWEI", "APPLE", "MEIZU"]
            dataSource.append(contentsOf: new)
            self.collectionView.reloadData()
        }
    }
}
