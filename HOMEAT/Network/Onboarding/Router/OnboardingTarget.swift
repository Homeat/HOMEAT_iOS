//
//  OnboardingTarget.swift
//  HOMEAT
//
//  Created by 강석호 on 4/29/24.
//

import Foundation
import Alamofire


enum OnboardingTarget {
    case login(_ bodyDTO: KakaoLoginRequestBodyDTO)
    case userInfo
    case postRefreshToken
}

extension OnboardingTarget: TargetType {
    
    var authorization: Authorization {
        switch self {
        case .login:
            return .socialAuthorization
        case .userInfo:
            return .authorization
        case .postRefreshToken:
            return .reAuthorization
        }
    }
    
    var headerType: HTTPHeaderType {
        switch self {
        case .login:
            return .providerToken
        case .userInfo:
            return .hasToken
        case .postRefreshToken:
            return .refreshToken
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .login:
            return .post
        case .userInfo:
            return .get
        case .postRefreshToken:
            return .post
        }
    }
    
    var path: String {
        switch self {
        case .login:
            return "/v1/auth/login"
        case .userInfo:
            return "/v1/users/me"
        case .postRefreshToken:
            return "/v1/auth/reissue"
        }
    }
    
    var parameters: RequestParams {
        switch self {
        case let .login(bodyDTO):
            return .requestWithBody(bodyDTO)
        case .userInfo:
            return .requestPlain
        case .postRefreshToken:
            return .requestPlain
        }
    }
    
}
