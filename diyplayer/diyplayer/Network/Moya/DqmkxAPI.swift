//
//  DqmkxAPI.swift
//  diyplayer
//
//  Created by sidney on 2020/4/11.
//  Copyright © 2020 sidney. All rights reserved.
//

import Foundation
import Moya

let host = [
    "dev": "http://192.168.22.123",
    "stage": "https://api-staging003.mokahr.com",
    "prod": "https://api.dqmkx.com"
]

let env = "stage"

enum DqmkxAPI {
    case login
    case getUserInfo
    case getDepartment
}

extension DqmkxAPI: TargetType {
    
    var baseURL: URL {
        return URL(string: host[env]!)!
    }
    
    var path: String {
        switch self {
        case .login:
            return ""
        case .getDepartment:
            return "/v1/departments"
        default:
            return ""
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getDepartment:
            return .get
        default:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getDepartment:
            return .requestPlain
        default:
            return .requestPlain
        }
    }
    
    var sampleData: Data {
        return getMockDataResponse("\(self)") ?? Data()
    }
    
    var headers: [String : String]? {
        return ["Authorization" : "Basic T3Y4RnpzU3FzZ3J3OGFCempiZVg1TFlyd3o3T1hzc0E6", "Content-type" : "application/json"]
    }

}

// MARK: - Get mock data from json file
private func getMockDataResponse(_ filename: String) -> Data? {
    @objc class EmptyClass: NSObject { }
    let bundle = Bundle(for: EmptyClass.self)
    let pathOptional = bundle.path(forResource: filename, ofType: "json")
    guard let path = pathOptional else { return nil }
    do {
        return try Data(contentsOf: URL(fileURLWithPath: path))
    } catch {
        return nil
    }
}
