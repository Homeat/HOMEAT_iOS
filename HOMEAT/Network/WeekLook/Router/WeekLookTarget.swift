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
    case weekBadgeInfo
}

extension WeekLookTarget: TargetType {
    var authorization: Authorization {
        switch self {
        case .weekLook:
            return .authorization
        case .weekBadgeInfo:
            return .authorization
        }
    }
    
    var headerType: HTTPHeaderType {
        switch self {
        case .weekLook:
            return .hasToken
        case .weekBadgeInfo:
            return .hasToken
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .weekLook:
            return .get
        case .weekBadgeInfo:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .weekLook:
            return "/v1/badgeReport/BadgeImg"
        case .weekBadgeInfo:
            return "/v1/badgeReport/BadgeInfo"
        }
    }
    
    var parameters: RequestParams {
        switch self {
        case .weekLook(let queryDTO):
            return .requestQuery(queryDTO)
        case .weekBadgeInfo:
            return .requestPlain
        }
    }

}
