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
}

extension AnalysisTarget: TargetType {
    var authorization: Authorization {
        switch self {
        case .Month:
            return .authorization
        case .Week:
            return .authorization
        }
    }
    
    var headerType: HTTPHeaderType {
        switch self {
        case .Month:
            return .hasToken
        case .Week:
            return .hasToken
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .Month:
            return .get
        case .Week:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .Month:
            return "/v1/homeatReport/ofMonth"
        case .Week:
            return "/v1/homeatReport/ofWeek"
        }
    }
    
    var parameters: RequestParams {
        switch self {
        case .Month(let bodyDTO):
            return .requestQuery(bodyDTO)
        case .Week(let bodyDTO):
            return .requestQuery(bodyDTO)
        }
    }

}
