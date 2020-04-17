//
//  DqmAPI.swift
//  iOS-dqmkx
//
//  Created by sidney on 4/10/20.
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
    case login(username: String, password: String)
    case getUserInfo(userId: Int)
    case getDepartments
}

extension DqmkxAPI: TargetType {
    
    var baseURL: URL {
        return URL(string: host[env]!)!
    }
    
    var path: String {
        switch self {
        case .login:
            return "/"
        case .getDepartments:
            return "/v1/departments"
        default:
            return "/"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .login:
            return .post
        default:
            return .get
        }
    }
    
    var task: Task {
        if method == .get {
            return .requestParameters(parameters: urlParams, encoding: URLEncoding.default)
        } else if method == .post {
            return .requestCompositeParameters(bodyParameters: bodyParams, bodyEncoding: JSONEncoding.default, urlParameters: urlParams)
        }
        return .requestPlain
    }
    
    var sampleData: Data {
        return getMockDataResponse("\(self)") ?? Data()
    }
    
    var headers: [String : String]? {
        return ["Authorization" : "Basic T3Y4RnpzU3FzZ3J3OGFCempiZVg1TFlyd3o3T1hzc0E6", "Content-type" : "application/json"]
    }

}

extension DqmkxAPI {
    var urlParams: [String: Any] {
        var param: [String: Any] = [:]
        switch self {
        case .getUserInfo(let userId):
            param["userId"] = userId
            break
        default:
            break
        }
        return param
    }
    
    var bodyParams: [String: Any] {
        var param: [String: Any] = [:]
        switch self {
        case .login(let username, let password):
            param["username"] = username
            param["password"] = password
            break
        default:
            break
        }
        return param
    }
    
}

extension DqmkxAPI {
    @discardableResult
    func request<T: Mapable>(successClosure: @escaping (T) -> Void,
                             failureClosure: @escaping (ErrorModel) -> Void) -> Cancellable? {
        return DqmkxAPIProvider.sharedInstance.request(self, successClosure: successClosure, failureClosure: failureClosure)
    }
}

// MARK: - Get mock data from json file
func getMockDataResponse(_ filename: String) -> Data? {
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
