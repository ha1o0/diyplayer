//
//  TestAutoTableViewCell.swift
//  diyplayer
//
//  Created by sidney on 2020/5/7.
//  Copyright © 2020 sidney. All rights reserved.
//

import UIKit

class TestAutoTableViewCell: UITableViewCell {

    @IBOutlet weak var targetButton: UIButton!
    @IBOutlet weak var targetView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func fold(_ sender: UIButton) {
        targetView.isHidden = !targetView.isHidden
        let tableView = superView(of: UITableView.self)
        tableView?.setNeedsDisplay()
        tableView?.beginUpdates()
        tableView?.endUpdates()
        
    }
}
