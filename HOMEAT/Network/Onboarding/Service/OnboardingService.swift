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
    func emailLoginWithHeader(bodyDTO: EmailLoginRequestBodyDTO, completion: @escaping (NetworkResult<BaseResponse<EmailLoginResponseDTO>>, [AnyHashable: Any]) -> Void)
    func emailCertificate(bodyDTO: EmailCertificationRequestBodyDTO, completion: @escaping (NetworkResult<BaseResponse<AuthCodeResponseDTO>>) -> Void)
    func myOnboarding(bodyDTO: MyOnboardingRequestBodyDTO, completion: @escaping (NetworkResult<BaseResponse<Data>>)-> Void)
    func emailJoin(bodyDTO: EmailSignUpRequestBodyDTO, completion: @escaping (NetworkResult<BaseResponse<EmailJoinResponseDTO>>)-> Void)
}

final class OnboardingService: APIRequestLoader<OnboardingTarget>, OnboardingServiceProtocol {
    func emailCertificate(bodyDTO: EmailCertificationRequestBodyDTO, completion: @escaping (NetworkResult<BaseResponse<AuthCodeResponseDTO>>) -> Void) {
        fetchData(target: .emailCertification(bodyDTO), responseData: BaseResponse<AuthCodeResponseDTO>.self, completion: completion)
    }
    
    func myOnboarding(bodyDTO: MyOnboardingRequestBodyDTO, completion: @escaping (NetworkResult<BaseResponse<Data>>) -> Void) {
        fetchData(target: .myOnboarding(bodyDTO), responseData: BaseResponse<Data>.self, completion: completion)
    }
    
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
        fetchDataWithHeader(target: .emailLogin(bodyDTO),
                            responseData: BaseResponse<EmailLoginResponseDTO>.self) { (result, headers) in
            completion(result)
            print(headers)
        }
    }
    
    func emailLoginWithHeader(bodyDTO: EmailLoginRequestBodyDTO, completion: @escaping (NetworkResult<BaseResponse<EmailLoginResponseDTO>>, [AnyHashable: Any]) -> Void) {
        fetchDataWithHeader(target: .emailLogin(bodyDTO), responseData: BaseResponse<EmailLoginResponseDTO>.self, completion: completion)
    }
    
    func emailJoin(bodyDTO: EmailSignUpRequestBodyDTO, completion: @escaping (NetworkResult<BaseResponse<EmailJoinResponseDTO>>) -> Void) {
        fetchData(target: .emailSignUp(bodyDTO), responseData: BaseResponse<EmailJoinResponseDTO>.self, completion: completion)
    }
}
