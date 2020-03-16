//
//  ScrollTabView.swift
//  diyplayer
//
//  Created by sidney on 2019/12/8.
//  Copyright © 2019 sidney. All rights reserved.
//

import UIKit

class ScrollTabView: UIView {

    var tabTitles:[String] = []
    var hasBottomLine:Bool = true
    var titleSelectedColor:UIColor = UIColor.main
    var titleColor:UIColor = UIColor.gray
    var titleSize:CGFloat = 15.0
    var titleSelectedSize:CGFloat = 17.0
    var currentIndex = 0
    var tabScrollView = UIScrollView()
    var underLineView = UIView()
    var tabControllers:[UIViewController] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        print("initframe")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setUpView() {
        tabScrollView.backgroundColor = UIColor.white
        self.addSubview(tabScrollView)
        tabScrollView.snp_makeConstraints { (maker) in
            maker.top.equalToSuperview()
            maker.bottom.equalToSuperview()
            maker.leading.equalToSuperview()
            maker.trailing.equalToSuperview()
        }
        var contentWidth:CGFloat = 0
        for (_, title) in self.tabTitles.enumerated() {
            let titleButton = UIButton()
            let attributes = [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 17)]
            let width = (title.boundingRect(with: CGSize(width: UIScreen.main.bounds.width, height: 30), options: NSStringDrawingOptions.usesFontLeading, attributes: attributes, context: nil).size.width) + 15
            titleButton.setTitle(title, for: .normal)
//            titleButton.titleLabel?.sizeToFit()
//            titleButton.titleLabel?.adjustsFontSizeToFitWidth = true
            titleButton.setTitleColor(self.titleSelectedColor, for: .selected)
            tabScrollView.addSubview(titleButton)
            titleButton.snp_makeConstraints { (maker) in
                maker.centerY.equalToSuperview()
                maker.leading.equalToSuperview().offset(10 + contentWidth)
                maker.height.equalTo(30)
                maker.width.equalTo(width)
            }

            contentWidth += (20 + width)
        }
        self.setButtonSelected(selectedIndex: self.currentIndex)
        tabScrollView.contentSize = CGSize(width: contentWidth, height: tabScrollView.frame.size.height)
        self.setTabUnderline()
    }
    
    func setButtonSelected(selectedIndex: Int) {
        let buttons:[UIButton] = tabScrollView.subviews as! [UIButton]
        for (index, button) in buttons.enumerated() {
            let titleColor = index == selectedIndex ? self.titleSelectedColor : self.titleColor
            let titleSize = index == selectedIndex ? 20 : 17
            button.setTitleColor(titleColor, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: CGFloat(titleSize))
        }
    }
    
    func setTabUnderline() {
        underLineView.backgroundColor = self.titleSelectedColor
        underLineView.layer.cornerRadius = 1
        let buttons:[UIButton] = tabScrollView.subviews as! [UIButton]
        let currentButton = buttons[currentIndex]
        tabScrollView.addSubview(underLineView)
        underLineView.snp_makeConstraints { (maker) in
            maker.width.equalTo(30)
            maker.height.equalTo(2)
            maker.centerX.equalTo(currentButton)
            maker.top.equalTo(currentButton.snp_bottom)
        }
    }
    
    func slideUnderline() {
        
    }
    
    func setTabViewControllers() {
        
    }

}
