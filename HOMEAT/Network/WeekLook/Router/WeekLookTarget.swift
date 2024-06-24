//
//  WeekLookTarget.swift
//  HOMEAT
//
//  Created by 김민솔 on 5/11/24.
//

import Foundation
import Alamofire


enum WeekLookTarget {
    case weekLook(_ queryDTO : WeekLookRequestBodyDTO)
}

extension WeekLookTarget: TargetType {
    var authorization: Authorization {
        switch self {
        case .weekLook:
            return .authorization
        }
    }
    
    var headerType: HTTPHeaderType {
        switch self {
        case .weekLook:
            return .hasToken
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .weekLook:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .weekLook:
            return "/v1/badgeReport/Badge"
        }
    }
    
    var parameters: RequestParams {
        switch self {
        case .weekLook(let queryDTO):
            return .requestQuery(queryDTO)
        }
    }

}
