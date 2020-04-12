//
//  Mapable.swift
//  diyplayer
//
//  Created by sidney on 2020/4/12.
//  Copyright © 2020 sidney. All rights reserved.
//

import Foundation
import SwiftyJSON

public protocol Mapable {
    init(jsonData: JSON)
}
