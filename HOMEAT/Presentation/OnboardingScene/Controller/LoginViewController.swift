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
import SwiftKeychainWrapper
import Alamofire

final class LoginViewController : BaseViewController {
    
    private let homeatTextLogo = UIImageView()
    private let emailLabel = UILabel()
    private let emailTextField = UITextField()
    private let passwordLabel = UILabel()
    private let passwordTextField = UITextField()
    private let loginButton = UIButton()
    private let signupButton = UIButton()
    private let findPasswordButton = UIButton()
    private let buttonStackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigation()
        setConfigure()
        setTarget()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let tabBarController = self.tabBarController as? HOMEATTabBarController {
            tabBarController.tabBar.isHidden = true
        }
        tabBarController?.tabBar.isTranslucent = true
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
            $0.isSecureTextEntry = true
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
        
        findPasswordButton.do {
            $0.backgroundColor = .clear
            $0.titleLabel?.font = .captionMedium13
            $0.setTitle("비밀번호 찾기", for: .normal)
            $0.setTitleColor(.white, for: .normal)
        }
        
        buttonStackView.do {
            $0.axis = .horizontal
            $0.spacing = 10
            $0.distribution = .fillEqually
        }
    }
    
    override func setConstraints() {
        
        view.addSubviews(homeatTextLogo, emailLabel, emailTextField, passwordLabel, passwordTextField, loginButton, buttonStackView)
        
        buttonStackView.addArrangedSubview(signupButton)
        buttonStackView.addArrangedSubview(findPasswordButton)
        
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
        
        buttonStackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(passwordTextField.snp.bottom).offset(30)
            $0.height.equalTo(30)
        }
        
        loginButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.top.equalTo(buttonStackView.snp.bottom).offset(40)
            $0.height.equalTo(57)
        }
    }
    
    private func setTarget() {
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        signupButton.addTarget(self, action: #selector(signupButtonTapped), for: .touchUpInside)
        findPasswordButton.addTarget(self, action: #selector(findPasswordButtonTapped), for: .touchUpInside)
    }
    
    @objc private func loginButtonTapped(_ sender: UIButton) {
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            print("이메일과 비밀번호를 입력해주세요.")
            DispatchQueue.main.async {
                self.showAlertWith(message: "이메일과 비밀번호를 입력해주세요.")
            }
            return
        }
        
        login(email: email, password: password)
    }
    
    private func login(email: String, password: String) {
        let parameters: [String: Any] = [
            "email": email,
            "password": password
        ]
        let url = "https://dev.homeat.site/v1/members/login/email"
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            switch response.result {
            case .success(let value):
                print("로그인 성공: \(value)")
                if let json = value as? [String: Any],
                   let code = json["code"] as? String,
                   code == "COMMON_200" {
                    if let headers = response.response?.allHeaderFields as? [String: String],
                       let accessToken = headers["Authorization"]?.replacingOccurrences(of: "Bearer ", with: "") {
                        // AccessToken 저장
                        KeychainWrapper.standard.set(accessToken, forKey: "accessToken")
                        
                        print("=============\(accessToken)===========")
                    }
                    
                    if let data = json["data"] as? [String: Any],
                       let refreshToken = data["refreshToken"] as? String {
                        // RefreshToken 저장
                        KeychainWrapper.standard.set(refreshToken, forKey: "refreshToken")
                        print("=============\(refreshToken)===========")
                    }
                    
                    DispatchQueue.main.async {
                        let tabBarVC = HOMEATTabBarController()
                        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
                            sceneDelegate.changeRootViewController(to: tabBarVC)
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        self.showAlertWith(message: "로그인 실패. 다시 시도해주세요.")
                    }
                }
            case .failure(let error):
                print("로그인 실패: \(error)")
                DispatchQueue.main.async {
                    self.showAlertWith(message: "로그인 요청 중 문제가 발생했습니다.")
                }
            }
        }
    }
    
    @objc private func signupButtonTapped(_ sender: Any) {
        // 이용약관
        let nextVC = TermsViewController()
        self.navigationController?.pushViewController(nextVC, animated: true)
    }

    @objc private func closeButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func findPasswordButtonTapped(_ sender: Any) {
        let nextVC = FindPasswordViewController()
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    private func showAlertWith(message: String) {
        let alert = UIAlertController(title: "로그인 실패", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        self.present(alert, animated: true, completion: nil)
    }
    
    func setNavigation() {
        self.navigationItem.hidesBackButton = true
        self.navigationItem.title = "로그인"
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
}
