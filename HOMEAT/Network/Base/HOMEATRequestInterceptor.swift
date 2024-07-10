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
        print("✋interceptor adapt 작동")
        /// request 될 때마다 실행됨
        let accessToken = KeychainHandler.shared.accessToken
        var urlRequest = urlRequest
        urlRequest.setValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")
        completion(.success(urlRequest))
    }
    
    func retry(_ request: Request, for _: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        print("✋✋ interceptor 작동")
        guard let response = request.task?.response as? HTTPURLResponse else {
            completion(.doNotRetryWithError(error))
            return
        }
        
        switch response.statusCode {
        case 401:
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
        default:
            completion(.doNotRetry)
        }
    }
    
    func refreshToken(completion: @escaping (Bool) -> Void) {
        print("토큰 재발급 시작")
        
        let url = URL(string: "https://dev.homeat.site/v1/members/reissue")!
        
        var urlRequest = URLRequest(url: url)
        urlRequest.method = .post
        urlRequest.setValue("Bearer \(KeychainHandler.shared.accessToken)", forHTTPHeaderField: "Authorization")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Include refresh token in the Cookie header
        let refreshToken = KeychainHandler.shared.refreshToken
        urlRequest.setValue("refreshToken=\(refreshToken)", forHTTPHeaderField: "Cookie")
        
        AF.request(urlRequest).responseJSON { response in
            switch response.result {
            case .success(let value):
                print("토큰 재발급 성공: \(value)")
                if let json = value as? [String: Any],
                   let data = json["data"] as? [String: Any] {
                    
                    if let newAccessToken = data["accessToken"] as? String {
                        KeychainHandler.shared.accessToken = newAccessToken
                        print("새로운 AccessToken 저장 ✅: \(newAccessToken)")
                    }
                    
                    if let newRefreshToken = data["refreshToken"] as? String {
                        KeychainHandler.shared.refreshToken = newRefreshToken
                        print("새로운 RefreshToken 저장 ✅: \(newRefreshToken)")
                    }
                    
                    completion(true)
                } else {
                    completion(false)
                }
            case .failure(let error):
                print("토큰 재발급 실패: \(error)")
                completion(false)
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
}
