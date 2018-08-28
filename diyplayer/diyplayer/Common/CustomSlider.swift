//
//  CustomSlider.swift
//  diyplayer
//
//  Created by sidney on 2018/8/27.
//  Copyright © 2018年 sidney. All rights reserved.
//

import Foundation
import UIKit

class CustomSlider: UISlider {
    
    @IBInspectable var height: CGFloat = 5
    
    var valueImageView = UIImageView()
    var valueLabel = UILabel()
    var rounds = 0
    
    private var thumbFrame: CGRect {
        return thumbRect(forBounds: bounds, trackRect: trackRect(forBounds: bounds), value: value)
    }
    
    override func trackRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(origin: bounds.origin, size: CGSize(width: bounds.width, height: height))
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}

