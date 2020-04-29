//
//  GoodIntroduceCollectionViewCell.swift
//  diyplayer
//
//  Created by sidney on 2020/4/29.
//  Copyright © 2020 sidney. All rights reserved.
//

import UIKit

class GoodIntroduceCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var cellContentView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setCellContent() {
        cellContentView.snp.makeConstraints { (maker) in
            maker.height.equalTo(500)
        }
    }
    @IBAction func addHeight(_ sender: UIButton) {
        self.cellContentView.layoutSubviews()
        self.cellContentView.layoutIfNeeded()
        cellContentView.snp.updateConstraints { (maker) in
            maker.height.equalTo(800)
        }
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        let autoLayoutAttributes = super.preferredLayoutAttributesFitting(layoutAttributes)
        let targetSize = CGSize(width: SCREEN_WIDTH, height: 0)
        let autoLayoutSize = contentView.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: UILayoutPriority.required, verticalFittingPriority: UILayoutPriority.defaultLow)
        let autoLayoutFrame = CGRect(origin: autoLayoutAttributes.frame.origin, size: autoLayoutSize)
        autoLayoutAttributes.frame = autoLayoutFrame
        return autoLayoutAttributes
    }
}
