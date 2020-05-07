//
//  UIView+Extension.swift
//  diyplayer
//
//  Created by sidney on 2020/5/7.
//  Copyright © 2020 sidney. All rights reserved.
//

import Foundation

extension UIView {
    //返回该view所在的父view
    func superView<T: UIView>(of: T.Type) -> T? {
        for view in sequence(first: self.superview, next: { $0?.superview }) {
            if let father = view as? T {
                return father
            }
        }
        return nil
    }
}
