//
//  ErrorModel.swift
//  iOS-dqmkx
//
//  Created by sidney on 4/17/20.
//

import Foundation
import SwiftyJSON

class ErrorModel: Mapable {
    var code: Int?
    var message: String?

    init() {}

    required init(jsonData: JSON) {
        self.code = jsonData["code"].intValue
        self.message = jsonData["message"].stringValue
    }
}
