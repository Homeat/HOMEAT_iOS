//
//  HOMEATRequestInterceptor.swift
//  HOMEAT
//
//  Created by 강석호 on 4/29/24.
//

import Foundation
import UIKit
import Alamofire

final class HOMEATRequestInterceptor: RequestInterceptor {
    
    private var isRefreshingToken = false
    private var requestsToRetry: [(RetryResult) -> Void] = []
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        print("✋ interceptor adapt 작동")
        var urlRequest = urlRequest
        urlRequest.setValue("Bearer \(KeychainHandler.shared.accessToken)", forHTTPHeaderField: "Authorization")
        completion(.success(urlRequest))
    }
    
    func retry(_ request: Request, for _: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        print("✋✋ interceptor 작동")
        guard let response = request.task?.response as? HTTPURLResponse, response.statusCode == 401 else {
            completion(.doNotRetryWithError(error))
            return
        }
        
        requestsToRetry.append(completion)
        if !isRefreshingToken {
            isRefreshingToken = true
            refreshToken { [weak self] isSuccess in
                guard let self = self else { return }
                
                self.isRefreshingToken = false
                self.requestsToRetry.forEach { $0(isSuccess ? .retry : .doNotRetry) }
                self.requestsToRetry.removeAll()
            }
        }
    }
    
    func refreshToken(completion: @escaping (Bool) -> Void) {
        print("토큰 재발급 시작")
        
        // 현재 액세스 토큰과 리프레시 토큰을 출력
        print("현재 액세스 토큰: \(KeychainHandler.shared.accessToken)")
        print("현재 리프레시 토큰: \(KeychainHandler.shared.refreshToken)")

        let url = URL(string: "https://dev.homeat.site/v1/members/reissue")!
        
        var urlRequest = URLRequest(url: url)
        urlRequest.method = .post
        
        let refreshToken = KeychainHandler.shared.refreshToken
            urlRequest.setValue("refresh=\(refreshToken)", forHTTPHeaderField: "Cookie")
            
            // URLRequest 디버깅 출력
            print("URLRequest: \(urlRequest)")
            
        AF.request(urlRequest).responseJSON { response in
               switch response.result {
               case .success(let value):
                print("토큰 재발급 성공: \(value)")
                if let json = value as? [String: Any],
                   let code = json["code"] as? String {
                    
                    switch code {
                    case "COMMON_200":
                        if let headers = response.response?.allHeaderFields as? [String: String],
                           let newAccessToken = headers["Authorization"]?.replacingOccurrences(of: "Bearer ", with: "") {
                            // AccessToken 저장
                            KeychainHandler.shared.accessToken = newAccessToken
                            
                            print("새로운 AccessToken 저장 ✅: \(newAccessToken)")
                        }
                        
                        if let data = json["data"] as? [String: Any],
                           let newRefreshToken = data["refreshToken"] as? String {
                            KeychainHandler.shared.refreshToken = newRefreshToken
                            print("새로운 RefreshToken 저장 ✅: \(newRefreshToken)")
                            
                            completion(true)
                        } else {
                            print("토큰 재발급 실패: 데이터 형식 오류 또는 새 refresh token 누락")
                            completion(false)
                        }
                    case "AUTH_4011":
                        print("토큰 재발급 실패: \(json["message"] ?? "알 수 없는 오류")")
                        completion(false)
                    default:
                        print("토큰 재발급 실패: 올바르지 않은 응답 코드")
                        completion(false)
                    }
                }
            case .failure(let error):
                print("토큰 재발급 실패: \(error)")
                completion(false)
            }
        }
    }
}

    
//    func logout() {
//        /// 토큰 초기화 이후 로그인 화면 이동
//        KeychainHandler.shared.logout()
//        DispatchQueue.main.async {
//            guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else { return }
//            sceneDelegate.window?.rootViewController = UINavigationController(rootViewController: LoginViewController())
//        }
//    }

