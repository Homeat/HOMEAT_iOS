//
//  OnboardingService.swift
//  HOMEAT
//
//  Created by 강석호 on 4/29/24.
//

import Foundation

protocol OnboardingServiceProtocol {
    func kakaoLogin(bodyDTO: KakaoLoginRequestBodyDTO, completion: @escaping (NetworkResult<BaseResponse<KakaoLoginResponseDTO>>) -> Void)
    func userInfo(completion: @escaping (NetworkResult<BaseResponse<UserInfoResponseDTO>>) -> Void)
    func postRefreshToken(completion: @escaping (NetworkResult<BaseResponse<TokenRefreshResponseDTO>>) -> Void)
    func emailLogin(bodyDTO: EmailLoginRequestBodyDTO, completion: @escaping (NetworkResult<BaseResponse<EmailLoginResponseDTO>>) -> Void)
}

final class OnboardingService: APIRequestLoader<OnboardingTarget>, OnboardingServiceProtocol {
    
    func kakaoLogin(bodyDTO: KakaoLoginRequestBodyDTO, completion: @escaping (NetworkResult<BaseResponse<KakaoLoginResponseDTO>>) -> Void) {
        fetchData(target: .kakaoLogin(bodyDTO),
                  responseData: BaseResponse<KakaoLoginResponseDTO>.self, completion: completion)
    }
    
    func userInfo(completion: @escaping (NetworkResult<BaseResponse<UserInfoResponseDTO>>) -> Void) {
        fetchData(target: .userInfo,
                  responseData: BaseResponse<UserInfoResponseDTO>.self, completion: completion)
    }
    
    func postRefreshToken(completion: @escaping (NetworkResult<BaseResponse<TokenRefreshResponseDTO>>) -> Void) {
        fetchData(target: .postRefreshToken, responseData: BaseResponse<TokenRefreshResponseDTO>.self, completion: completion)
    }
    
    func emailLogin(bodyDTO: EmailLoginRequestBodyDTO, completion: @escaping (NetworkResult<BaseResponse<EmailLoginResponseDTO>>) -> Void) {
        fetchData(target: .emailLogin(bodyDTO),
                  responseData: BaseResponse<EmailLoginResponseDTO>.self, completion: completion)
    }
}