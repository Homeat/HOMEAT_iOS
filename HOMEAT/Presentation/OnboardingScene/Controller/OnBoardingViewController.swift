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

class OnBoardingViewController : BaseViewController {
    
    private let introTitleLabel = UILabel()
    private let welcomeView = WelcomeView()
    private let signupButton = UIButton()
    private let signinButton = UIButton()
    
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
        
        signupButton.do {
            $0.backgroundColor = UIColor(named: "turquoiseGreen")
            $0.titleLabel?.font = .bodyMedium18
            $0.setTitle("가입하기", for: .normal)
            $0.setTitleColor(.black, for: .normal)
            $0.layer.cornerRadius = 10
            $0.clipsToBounds = true
        }
        
        signinButton.do {
            $0.backgroundColor = UIColor(r: 30, g: 32, b: 33)
            $0.titleLabel?.font = .bodyMedium18
            $0.setTitle("계정이 이미 있어요", for: .normal)
            $0.setTitleColor(.turquoiseGreen, for: .normal)
            $0.layer.cornerRadius = 10
            $0.clipsToBounds = true
            $0.layer.borderColor = UIColor.turquoiseGreen.cgColor
            $0.layer.borderWidth = 1
        }
        
    }
    
    override func setConstraints() {
        view.addSubviews(introTitleLabel, welcomeView, signupButton, signinButton)
        
        introTitleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(280)
        }
        
        welcomeView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.top.equalTo(introTitleLabel.snp.bottom).offset(15)
        }
        
        signupButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.bottom.equalTo(signinButton.snp.top).offset(-25)
            $0.height.equalTo(57)
        }
        
        signinButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.bottom.equalToSuperview().offset(-76)
            $0.height.equalTo(57)
        }
    }
    
    private func setTarget() {
        signupButton.addTarget(self, action: #selector(signupButtonTapped), for: .touchUpInside)
        signinButton.addTarget(self, action: #selector(signinButtonTapped), for: .touchUpInside)
    }
    
    //MARK: - @objc Func
    @objc private func signupButtonTapped(_ sender: Any) {
        let nextVC = SetNicknameViewController()
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @objc private func signinButtonTapped() {
        let tabBarVC = HOMEATTabBarController()
        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
            sceneDelegate.changeRootViewController(to: tabBarVC)
        }
    }
    
}
