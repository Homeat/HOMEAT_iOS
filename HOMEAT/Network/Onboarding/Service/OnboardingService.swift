//
//  OnboardingService.swift
//  HOMEAT
//
//  Created by 강석호 on 4/29/24.
//

import Foundation

protocol OnboardingServiceProtocol {
    func login(bodyDTO: KakaoLoginRequestBodyDTO, completion: @escaping (NetworkResult<BaseResponse<KakaoLoginResponseDTO>>) -> Void)
    func userInfo(completion: @escaping (NetworkResult<BaseResponse<UserInfoResponseDTO>>) -> Void)
    func postRefreshToken(completion: @escaping (NetworkResult<BaseResponse<TokenRefreshResponseDTO>>) -> Void)
}

final class OnboardingService: APIRequestLoader<OnboardingTarget>, OnboardingServiceProtocol {
    
    func login(bodyDTO: KakaoLoginRequestBodyDTO, completion: @escaping (NetworkResult<BaseResponse<KakaoLoginResponseDTO>>) -> Void) {
        fetchData(target: .login(bodyDTO),
                  responseData: BaseResponse<KakaoLoginResponseDTO>.self, completion: completion)
    }
    
    func userInfo(completion: @escaping (NetworkResult<BaseResponse<UserInfoResponseDTO>>) -> Void) {
        fetchData(target: .userInfo,
                  responseData: BaseResponse<UserInfoResponseDTO>.self, completion: completion)
    }
    
    func postRefreshToken(completion: @escaping (NetworkResult<BaseResponse<TokenRefreshResponseDTO>>) -> Void) {
        fetchData(target: .postRefreshToken, responseData: BaseResponse<TokenRefreshResponseDTO>.self, completion: completion)
    }
}
