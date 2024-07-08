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
    case emailCertification(_ bodyDTO: EmailCertificationRequestBodyDTO)
    case emailSignUp(_ bodyDTO: EmailSignUpRequestBodyDTO)
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
        case .emailLogin, .emailCertification, .emailSignUp:
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
        case .emailLogin, .emailCertification, .emailSignUp:
            return .plain
        
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .kakaoLogin, .postRefreshToken, .emailLogin, .emailCertification, .emailSignUp:
            return .post
        case .userInfo:
            return .get
        
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
            return "/v1/members/login/email"
        case .emailCertification:
            return "/v1/members/email-cerification"
        case .emailSignUp:
            return "/v1/members/join/email"
        
        }
    }
    
    var parameters: RequestParams {
        switch self {
        case let .kakaoLogin(bodyDTO):
            return .requestWithBody(bodyDTO)
        case .userInfo, .postRefreshToken:
            return .requestPlain
        case let .emailLogin(bodyDTO):
            return .requestWithBody(bodyDTO)
        case let .emailCertification(bodyDTO):
            return .requestWithBody(bodyDTO)
        case let .emailSignUp(bodyDTO):
            return .requestWithBody(bodyDTO)
        
        }
    }
}
