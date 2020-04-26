//
//  MusicItemTableViewCell.swift
//  diyplayer
//
//  Created by sidney on 2020/4/26.
//  Copyright © 2020 sidney. All rights reserved.
//

import UIKit

class MusicItemTableViewCell: UITableViewCell {

    @IBOutlet weak var playingImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
//        let loadingGif = UIImage.gifImageWithName("juhua")
//        playingImageView.image = loadingGif
        // Initialization code
    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
