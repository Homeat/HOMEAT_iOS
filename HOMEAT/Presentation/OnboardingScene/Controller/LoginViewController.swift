//
//  LoginViewController.swift
//  HOMEAT
//
//  Created by 강석호 on 4/18/24.
//

import Foundation
import UIKit
import Then
import SnapKit
import KakaoSDKUser
import KakaoSDKAuth
import KakaoSDKCommon

final class LoginViewController : BaseViewController {
    
    private let homeatTextLogo = UIImageView()
    private let emailLabel = UILabel()
    private let emailTextField = UITextField()
    private let passwordLabel = UILabel()
    private let passwordTextField = UITextField()
    private let loginButton = UIButton()
    private let kakaoButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTarget()
    }
    
    // MARK: UI
    override func setConfigure() {
        view.do {
            $0.backgroundColor = UIColor(r: 30, g: 32, b: 33)
        }
        
        homeatTextLogo.do {
            $0.image = UIImage(named: "homeatTextLogo")
            $0.snp.makeConstraints {
                $0.width.equalTo(158)
                $0.height.equalTo(27)
            }
        }
        
        emailLabel.do {
            $0.text = "이메일"
            $0.font = .bodyMedium18
            $0.textColor = .turquoiseGreen
        }
        
        emailTextField.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.backgroundColor = UIColor(r: 54, g: 56, b: 57)
            $0.font = UIFont.systemFont(ofSize: 16, weight: .bold)
            $0.layer.cornerRadius = 10
            $0.layer.masksToBounds = true
            $0.textColor = .white
            $0.clearButtonMode = .whileEditing
            let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 18, height: $0.frame.height))
            $0.leftView = leftPaddingView
            $0.leftViewMode = .always
        }
        
        passwordLabel.do {
            $0.text = "비밀번호"
            $0.font = .bodyMedium18
            $0.textColor = .turquoiseGreen
        }
        
        passwordTextField.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.backgroundColor = UIColor(r: 54, g: 56, b: 57)
            $0.font = UIFont.systemFont(ofSize: 16, weight: .bold)
            $0.layer.cornerRadius = 10
            $0.layer.masksToBounds = true
            $0.textColor = .white
            $0.clearButtonMode = .whileEditing
            let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 18, height: $0.frame.height))
            $0.leftView = leftPaddingView
            $0.leftViewMode = .always
        }
        
        kakaoButton.do {
            $0.backgroundColor = UIColor(r: 254, g: 229, b: 0)
            $0.setImage(UIImage(named: "kakaoLogo"), for: .normal)
            $0.layer.cornerRadius = 27
            $0.clipsToBounds = true
        }
    }
    
    override func setConstraints() {
        
        view.addSubviews(homeatTextLogo, emailLabel, emailTextField, passwordLabel, passwordTextField, kakaoButton)
        
        homeatTextLogo.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(175)
        }
        
        emailLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.top.equalTo(homeatTextLogo.snp.bottom).offset(64)
        }
        
        emailTextField.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.top.equalTo(emailLabel.snp.bottom).offset(12)
            $0.height.equalTo(57)
        }
        
        passwordLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.top.equalTo(emailTextField.snp.bottom).offset(21)
        }
        
        passwordTextField.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.top.equalTo(passwordLabel.snp.bottom).offset(12)
            $0.height.equalTo(57)
        }
        
        kakaoButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(passwordTextField.snp.bottom).offset(52)
            $0.height.equalTo(57)
            $0.width.equalTo(57)
        }
        
    }
    
    private func setTarget() {
        kakaoButton.addTarget(self, action: #selector(loginKakao), for: .touchUpInside)
    }
    
    @objc private func loginKakao(_ sender: Any) {
        print("loginKakao() called.")
        
        // ✅ 카카오톡 설치 여부 확인
        if (UserApi.isKakaoTalkLoginAvailable()) {
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    print(error)
                }
                else {
                    print("loginWithKakaoTalk() success.")
                    
                    // ✅ 회원가입 성공 시 oauthToken 저장가능하다
                    // _ = oauthToken
                    print("*************")
                    print(oauthToken!)
                    print("*************")
                    // ✅ 사용자정보를 성공적으로 가져오면 화면전환 한다.
//                    self.getUserInfo()
                    print("-----------------")
//                    self.isToken()
                }
            }
        }
        else {
            print("카카오톡 미설치")
        }
    }
}

extension LoginViewController {
    
    private func getUserInfo() {
        
        // ✅ 사용자 정보 가져오기
        UserApi.shared.me() {(user, error) in
            if let error = error {
                print(error)
            }
            else {
                print("me() success.")
                
                // ✅ 닉네임, 이메일 정보
                let nickname = user?.kakaoAccount?.profile?.nickname
                
                print(nickname!)
                
            }
        }
    }
    
    private func getAccessTokenInfo() {
        
        UserApi.shared.accessTokenInfo {(accessTokenInfo, error) in
            if let error = error {
                print(error)
            }
            else {
                print("accessTokenInfo() success.")
                
                //do something
                _ = accessTokenInfo
                print(accessTokenInfo!)
            }
        }
    }
    
    private func isToken() {
        if (AuthApi.hasToken()) {
            UserApi.shared.accessTokenInfo { (_, error) in
                if let error = error {
                    if let sdkError = error as? SdkError, sdkError.isInvalidTokenError() == true  {
                        //로그인 필요
                        print("로그인 필요")
                    }
                    else {
                        //기타 에러
                        print("기타 에러")
                    }
                }
                else {
                    //토큰 유효성 체크 성공(필요 시 토큰 갱신됨)
                    print("토큰 유효성 체크 성공")
                }
            }
        }
        else {
            //로그인 필요
            print("로그인 필요!")
        }
    }
    
    // MARK: 서버에 카카오톡 토큰 전달
    /*
    private func pushTokenFromKakaoLogin(_ info: TokenInfo, completion: @escaping (String?, String?, String?, Error?)->()) {
        var request = URLRequest(url: URL(string: self.urlCollections["pushKakaoToken"]!)!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(info)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                completion(nil, nil, nil, error)
            } else if let data = data {
                let jsonData = try? JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary
                // 제이슨 파싱해서 유저정보(닉네임, 이메일 가져오기)
                if let jsonObjData = jsonData?["data"] as? NSDictionary {
                    if let jsonKeyDataNickname = jsonObjData["nickname"] as? String,
                       let jsonKeyDataEmail = jsonObjData["email"] as? String,
                       let jsonKeyDataProvider = jsonObjData["provider"] as? String {
                        //print("good good \(jsonKeyDataEmail) \(jsonKeyDataNickname)")
                        completion(jsonKeyDataEmail, jsonKeyDataNickname, jsonKeyDataProvider, nil)
                    }
                }
                if let response = response {
                    print("Push Kakao token and returned response is: \(response)")
                }
            }
        }.resume()
    }
    */
}
