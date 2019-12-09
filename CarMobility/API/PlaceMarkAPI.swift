//
//  PlaceMarkAPI.swift
//  CarMobility
//
//  Created by Jesus Alberto on 12/8/19.
//  Copyright © 2019 Jesus. All rights reserved.
//

import Foundation
import Moya

var url = "https://wunder-test-case.s3-eu-west-1.amazonaws.com/"

enum PlaceMarkAPI {
    case placeMarkList
}

extension PlaceMarkAPI: TargetType {
    var baseURL: URL {
        guard let url = URL(string: url) else {
            fatalError("base url not configured")
        }
        return url
    }
    
    var path: String {
        switch self {
        case .placeMarkList:
            return "ios/locations.json"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .placeMarkList:
            return .get
        }
    }
    
    var sampleData: Data {
        switch self {
        case .placeMarkList:
            guard let url = Bundle.main.url(forResource: "data", withExtension: "json"),
                let data = try? Data(contentsOf: url) else {
                    return Data()
            }
            return data
        }
    }
    
    var task: Task {
        switch self {
        case .placeMarkList:
            let params: [String: Any] = [:]
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
         return ["Content-type": "application/json"]
    }
}
