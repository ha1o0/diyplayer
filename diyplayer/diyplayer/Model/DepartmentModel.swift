//
//  DepartmentModel.swift
//  diyplayer
//
//  Created by sidney on 2020/4/12.
//  Copyright © 2020 sidney. All rights reserved.
//

import Foundation
import SwiftyJSON

class DepartmentModel: BaseDataModel {
    
    var departments: [DepartmentDataModel]?
    
    required init(jsonData: JSON) {
        super.init(jsonData: jsonData)
        self.departments = jsonData["departments"].array?.map { DepartmentDataModel(jsonData: $0) }
    }
}

class DepartmentDataModel: Mapable {
    var name: String?
    var type: String?
    var departmentId: Int?
    
    required init(jsonData: JSON) {
        self.name = jsonData["name"].stringValue
        self.type = jsonData["type"].stringValue
        self.departmentId = jsonData["departmentId"].intValue
    }
}
