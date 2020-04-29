//
//  GoodDetailCollectionViewCell.swift
//  diyplayer
//
//  Created by sidney on 2020/4/29.
//  Copyright © 2020 sidney. All rights reserved.
//

import UIKit

class GoodDetailCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var cellContentView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.contentMode = .scaleAspectFit
        // Initialization code
    }
    
    func setCellContent() {
//        let url = "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1588183768575&di=01a77fb970ea7359433b132c046ed89d&imgtype=0&src=http%3A%2F%2Fwx4.sinaimg.cn%2Forj360%2F005RkZ3rly1frpmmimj64j30zb3guww9.jpg"
        let url = "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1588183768574&di=855cdff5fae277ec5ee85686c31577a4&imgtype=0&src=http%3A%2F%2F5b0988e595225.cdn.sohucs.com%2Fimages%2F20200329%2F3d4d95336af74c7db6940e71b0946565.jpeg"
        imageView.sd_setImage(with: URL(string: url)) { (image, error, cacheType, url) in
            var vheight = image?.size.height ?? 0.0
            let vwidth = image?.size.width ?? 0.0
            if vwidth > 0.0 {
                vheight = vheight / vwidth * SCREEN_WIDTH
                self.layoutIfNeeded()
                self.cellContentView.layoutIfNeeded()
                self.imageView.layoutIfNeeded()
                self.layoutSubviews()
                self.cellContentView.layoutSubviews()
                self.imageView.layoutSubviews()
                self.contentView.layoutSubviews()
                self.contentView.layoutIfNeeded()
                self.imageView.snp.makeConstraints { (maker) in
                    maker.height.equalTo(vheight)
                }
            }
            
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
