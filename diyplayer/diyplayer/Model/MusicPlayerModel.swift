//
//  MusicPlayerModel.swift
//  diyplayer
//
//  Created by sidney on 2020/4/26.
//  Copyright © 2020 sidney. All rights reserved.
//

import Foundation

struct MusicPlayerModel {
    var id: Int
    var title: String
    var subtitle: String
    var posterImage: UIImage
    var posterUrl: String
    var musicUrl: String
    
    init() {
        id = -1
        title = ""
        subtitle = ""
        posterImage = UIImage()
        posterUrl = ""
        musicUrl = ""
    }
    
    mutating func mapping(id: Int, title: String, subtitle: String, posterImage: UIImage, musicUrl: String, posterUrl: String) {
        self.id = id
        self.title = title
        self.subtitle = subtitle
        self.posterImage = posterImage
        self.musicUrl = musicUrl
        self.posterUrl = posterUrl
    }
}
