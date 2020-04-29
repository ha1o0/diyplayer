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
            return 10
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
            cell.setCellContent()
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GoodRecommendedCollectionViewCell", for: indexPath)
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
//        return CGSize(width: SCREEN_WIDTH, height: 500)
//    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 10
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 10
//    }
}
