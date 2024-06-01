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

final class LoginViewController : BaseViewController {
    
    private let homeatTextLogo = UIImageView()
    private let emailLabel = UILabel()
    private let emailTextField = UITextField()
    private let passwordLabel = UILabel()
    private let passwordTextField = UITextField()
    private let loginButton = UIButton()
    private let signupButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigation()
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
            $0.attributedPlaceholder = NSAttributedString(string: "이메일 입력", attributes: [NSAttributedString.Key.foregroundColor: UIColor(r: 216, g: 216, b: 216)])
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
            $0.attributedPlaceholder = NSAttributedString(string: "비밀번호 입력", attributes: [NSAttributedString.Key.foregroundColor: UIColor(r: 216, g: 216, b: 216)])
        }
        
        loginButton.do {
            $0.backgroundColor = UIColor(named: "turquoiseGreen")
            $0.titleLabel?.font = .bodyMedium18
            $0.setTitle("로그인", for: .normal)
            $0.setTitleColor(.black, for: .normal)
            $0.layer.cornerRadius = 10
            $0.clipsToBounds = true
        }
        
        signupButton.do {
            $0.backgroundColor = .clear
            $0.titleLabel?.font = .captionMedium13
            $0.setTitle("회원가입", for: .normal)
            $0.setTitleColor(.white, for: .normal)
        }
    }
    
    override func setConstraints() {
        
        view.addSubviews(homeatTextLogo, emailLabel, emailTextField, passwordLabel, passwordTextField, loginButton, signupButton)
        
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
        
        loginButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.top.equalTo(passwordTextField.snp.bottom).offset(72)
            $0.height.equalTo(57)
        }
        
        signupButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(passwordTextField.snp.bottom).offset(10)
            $0.height.equalTo(30)
            $0.width.equalTo(70)
        }
        
    }
    
    private func setTarget() {
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        signupButton.addTarget(self, action: #selector(signupButtonTapped), for: .touchUpInside)
    }
    
    @objc private func loginButtonTapped(_ sender: Any) {
        self.login(data: EmailLoginRequestBodyDTO(email: "rkdtnlzl@naver.com", password: "abcd1234!"))
    }
    
    @objc private func signupButtonTapped(_ sender: Any) {
        let nextVC = SignUpViewController()
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func login(data: EmailLoginRequestBodyDTO) {
        NetworkService.shared.onboardingService.emailLogin(bodyDTO: data) { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let data):
                guard let data = data.data else { return }
                print(data)
                let tabBarVC = HOMEATTabBarController()
                if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
                    sceneDelegate.changeRootViewController(to: tabBarVC)
                }
                print("로그인 성공!!")
            default:
                print("login error!!")
            }
        }
    }
    
    func setNavigation() {
        self.navigationItem.title = "로그인"
    }
}

