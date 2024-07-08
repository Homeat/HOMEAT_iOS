//
//  AnalysisTarget.swift
//  HOMEAT
//
//  Created by 김민솔 on 5/3/24.
//

import Foundation
import Alamofire


enum AnalysisTarget {
    case Month(_ bodyDTO: AnalysisMonthRequestBodyDTO)
    case Week(_ bodyDTO: AnalysisWeekRequestBodyDTO)
    case Detail(_ bodyDTO: AnalysisDetailRequestBodyDTO)
    case WeekInfo
}

extension AnalysisTarget: TargetType {
    var authorization: Authorization {
        switch self {
        case .Month:
            return .authorization
        case .Week:
            return .authorization
        case .Detail:
            return .authorization
        case .WeekInfo:
            return .authorization
        }
    }
    
    var headerType: HTTPHeaderType {
        switch self {
        case .Month:
            return .hasToken
        case .Week:
            return .hasToken
        case .Detail:
            return .hasToken
        case .WeekInfo:
            return .hasToken
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .Month:
            return .get
        case .Week:
            return .get
        case .Detail:
            return .get
        case .WeekInfo:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .Month:
            return "/v1/homeatReport/ofMonth"
        case .Week:
            return "/v1/homeatReport/ofWeekResult"
        case .Detail:
            return "/v1/home/calendar/daily/details"
        case .WeekInfo:
            return "/v1/homeatReport/ofWeekInfo"
        }
    }
    
    var parameters: RequestParams {
        switch self {
        case .Month(let bodyDTO):
            return .requestQuery(bodyDTO)
        case .Week(let bodyDTO):
            return .requestQuery(bodyDTO)
        case .Detail(let bodyDTO):
            return .requestQuery(bodyDTO)
        case .WeekInfo:
            return .requestPlain
        }
    }

}
