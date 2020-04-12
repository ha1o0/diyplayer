//
//  BaseDataModel.swift
//  diyplayer
//
//  Created by sidney on 2020/4/12.
//  Copyright © 2020 sidney. All rights reserved.
//

import Foundation
import SwiftyJSON


class BaseDataModel: Mapable {
    
    var success: Bool?
    
    required init(jsonData: JSON) {
        self.success = jsonData["success"].bool
    }
}
