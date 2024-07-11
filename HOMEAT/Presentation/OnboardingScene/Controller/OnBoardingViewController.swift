//
//  LoginViewController.swift
//  HOMEAT
//
//  Created by 강석호 on 4/17/24.
//

import Foundation
import UIKit
import Then
import SnapKit
import KakaoSDKUser
import KakaoSDKAuth
import KakaoSDKCommon

class OnBoardingViewController : BaseViewController {
    
    private let introTitleLabel = UILabel()
    private let welcomeView = WelcomeView()
    private let continueEmailButton = UIButton()
    private let continueKakaoButton = UIButton()
    private let continueAppleButton = UIButton()
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTarget()
    }
    
    override func setConfigure() {
        view.do {
            $0.backgroundColor = UIColor(r: 30, g: 32, b: 33)
        }
        
        introTitleLabel.do {
            $0.text = "1인 가구를 위한 식비 첼린지 커뮤니티"
            $0.font = .bodyMedium18
            $0.textColor = .turquoiseGreen
        }
        
        continueEmailButton.do {
            $0.backgroundColor = UIColor(named: "turquoiseGreen")
            $0.titleLabel?.font = .bodyMedium18
            $0.setTitle("이메일로 계속하기", for: .normal)
            $0.setTitleColor(.black, for: .normal)
            $0.layer.cornerRadius = 10
            $0.clipsToBounds = true
        }
        
//        continueKakaoButton.do {
//            $0.backgroundColor = UIColor(r: 30, g: 32, b: 33)
//            $0.titleLabel?.font = .bodyMedium18
//            $0.setTitle("카카오로 계속하기", for: .normal)
//            $0.setTitleColor(.turquoiseGreen, for: .normal)
//            $0.layer.cornerRadius = 10
//            $0.clipsToBounds = true
//            $0.layer.borderColor = UIColor.turquoiseGreen.cgColor
//            $0.layer.borderWidth = 1
//        }
//        
//        continueAppleButton.do {
//            $0.backgroundColor = UIColor(r: 30, g: 32, b: 33)
//            $0.titleLabel?.font = .bodyMedium18
//            $0.setTitle("Apple로 계속하기", for: .normal)
//            $0.setTitleColor(.turquoiseGreen, for: .normal)
//            $0.layer.cornerRadius = 10
//            $0.clipsToBounds = true
//            $0.layer.borderColor = UIColor.turquoiseGreen.cgColor
//            $0.layer.borderWidth = 1
//        }
    }
    
    override func setConstraints() {
        view.addSubviews(introTitleLabel, welcomeView, continueEmailButton, continueKakaoButton, continueAppleButton)
        
        introTitleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(280)
        }
        
        welcomeView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.top.equalTo(introTitleLabel.snp.bottom).offset(15)
        }
        
        continueEmailButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.bottom.equalToSuperview().inset(96)
            $0.height.equalTo(57)
        }
        
//        continueKakaoButton.snp.makeConstraints {
//            $0.leading.equalToSuperview().offset(20)
//            $0.trailing.equalToSuperview().offset(-20)
//            $0.bottom.equalTo(continueAppleButton.snp.top).offset(-25)
//            $0.height.equalTo(57)
//        }
//        
//        continueAppleButton.snp.makeConstraints {
//            $0.leading.equalToSuperview().offset(20)
//            $0.trailing.equalToSuperview().offset(-20)
//            $0.bottom.equalToSuperview().offset(-76)
//            $0.height.equalTo(57)
//        }
    }
    
    private func setTarget() {
        continueEmailButton.addTarget(self, action: #selector(emailButtonTapped), for: .touchUpInside)
//        continueKakaoButton.addTarget(self, action: #selector(kakaoButtonTapped), for: .touchUpInside)
//        continueAppleButton.addTarget(self, action: #selector(appleButtonTapped), for: .touchUpInside)
    }
    
    //MARK: - @objc Func
    @objc private func emailButtonTapped(_ sender: Any) {
        let nextVC = LoginViewController()
        if let navigationController = self.navigationController {
            navigationController.pushViewController(nextVC, animated: true)
        } else {
            print("Navigation controller is nil")
        }//        let tabBarVC = HOMEATTabBarController()
//                if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
//                    sceneDelegate.changeRootViewController(to: tabBarVC)
//                }
    }
    
//    @objc private func kakaoButtonTapped(_ sender: Any) {
//        print("loginKakao() called.")
//        // ✅ 카카오톡 설치 여부 확인
//        if (UserApi.isKakaoTalkLoginAvailable()) {
//            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
//                if let error = error {
//                    print(error)
//                }
//                else {
//                    print("loginWithKakaoTalk() success.")
//                    
//                    // ✅ 회원가입 성공 시 oauthToken 저장가능하다
//                    // _ = oauthToken
//                    print("-------------------------------------")
//                    print(oauthToken!)
//                    print("-------------------------------------")
//                }
//            }
//        }
//        else {
//            print("카카오톡 미설치")
//        }
//    }
//    
//    @objc private func appleButtonTapped() {
//        let tabBarVC = HOMEATTabBarController()
//        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
//            sceneDelegate.changeRootViewController(to: tabBarVC)
//        }
//    }
}
