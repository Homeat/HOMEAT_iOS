//
//  HomeSceneTarget.swift
//  HOMEAT
//
//  Created by 강삼고 on 5/26/24.
//

import Foundation
import Alamofire


enum HomeSceneTarget {
    case homeInfo
}

extension HomeSceneTarget: TargetType {
    
    var authorization: Authorization {
        switch self {
        case .homeInfo:
            return .authorization
        }
    }
    
    var headerType: HTTPHeaderType {
        switch self {
        case .homeInfo:
            return .hasToken
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .homeInfo:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .homeInfo:
            return "/v1/home/"
        }
    }
    
    var parameters: RequestParams {
        switch self {
        case .homeInfo:
            return .requestPlain
        }
    }
}

    
