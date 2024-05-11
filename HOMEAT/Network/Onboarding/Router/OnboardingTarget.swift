//
//  OnboardingTarget.swift
//  HOMEAT
//
//  Created by 강석호 on 4/29/24.
//

import Foundation
import Alamofire


enum OnboardingTarget {
    case kakaoLogin(_ bodyDTO: KakaoLoginRequestBodyDTO)
    case emailLogin(_ bodyDTO: EmailLoginRequestBodyDTO)
    case userInfo
    case postRefreshToken
}

extension OnboardingTarget: TargetType {
    
    var authorization: Authorization {
        switch self {
        case .kakaoLogin:
            return .socialAuthorization
        case .userInfo:
            return .authorization
        case .postRefreshToken:
            return .reAuthorization
        case .emailLogin:
            return .emailAuthorization
        }
    }
    
    var headerType: HTTPHeaderType {
        switch self {
        case .kakaoLogin:
            return .providerToken
        case .userInfo:
            return .hasToken
        case .postRefreshToken:
            return .refreshToken
        case .emailLogin:
            return .plain
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .kakaoLogin:
            return .post
        case .userInfo:
            return .get
        case .postRefreshToken:
            return .post
        case .emailLogin:
            return .post
        }
    }
    
    var path: String {
        switch self {
        case .kakaoLogin:
            return "/v1/auth/login"
        case .userInfo:
            return "/v1/users/me"
        case .postRefreshToken:
            return "/v1/auth/reissue"
        case .emailLogin:
            return "/v1/members/login"
        }
    }
    
    var parameters: RequestParams {
        switch self {
        case let .kakaoLogin(bodyDTO):
            return .requestWithBody(bodyDTO)
        case .userInfo:
            return .requestPlain
        case .postRefreshToken:
            return .requestPlain
        case let .emailLogin(bodyDTO):
            return .requestWithBody(bodyDTO)
        }
    }
    
}
