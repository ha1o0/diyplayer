//
//  DqmkxProvider.swift
//  diyplayer
//
//  Created by sidney on 2020/4/11.
//  Copyright © 2020 sidney. All rights reserved.
//

import Foundation
import Alamofire
import Moya
import SwiftyJSON

let useMockData = true
let requestTimeout = TimeInterval(60)

class DqmkxAPIProvider: MoyaProvider<DqmkxAPI> {
    static let sharedInstance = DqmkxAPIProvider(useMockData)
    
    private static let endpointClosure = {
        (target: DqmkxAPI) -> Endpoint in
        return Endpoint(url: URL(target: target).absoluteString,
                                  sampleResponseClosure: { .networkResponse(200, target.sampleData) },
                                  method: target.method,
                                  task: target.task,
                                  httpHeaderFields: target.headers)
    }
    
    private static let customMockClosure = {
        (target: DqmkxAPI) -> Moya.StubBehavior in
        // set delay to mock network request and response time
        return .delayed(seconds: 0.2)
    }
    
    init(_ useMockData: Bool) {
        if useMockData {
            super.init(endpointClosure: DqmkxAPIProvider.endpointClosure, stubClosure: DqmkxAPIProvider.customMockClosure)
        } else {
            let configuration = URLSessionConfiguration.default
            configuration.timeoutIntervalForRequest = requestTimeout
            configuration.timeoutIntervalForResource = requestTimeout
            super.init(endpointClosure: DqmkxAPIProvider.endpointClosure, stubClosure: MoyaProvider.neverStub, manager: Alamofire.SessionManager(configuration: configuration), plugins: [], trackInflights: false)
        }
    }
    
    @discardableResult
    func request<T: Mapable>(_ target: DqmkxAPI,
                    successClosure: @escaping (T) -> Void,
                    failureClosure: @escaping (String) -> Void) -> Cancellable {
        return super.request(target) {result in
            switch result {
            case .success(let response):
                let httpStatusCode = response.statusCode
                let data = response.data
                let errorInfo = ""
                switch httpStatusCode {
                case 200:
                    do {
                        let jsonDic = try JSON(data: data)
                        let result = T(jsonData: jsonDic)
                        successClosure(result)
                    } catch {
                        failureClosure(errorInfo)
                    }
                case 401:
                    failureClosure(errorInfo)
                default:
                    failureClosure(errorInfo)
                }
            case .failure(_):
                failureClosure("")
            }
        }
    }
}


