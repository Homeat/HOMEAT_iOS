//
//  ChangePasswordViewController.swift
//  HOMEAT
//
//  Created by 강석호 on 6/1/24.
//

import UIKit
import SnapKit
import Then

class ChangePasswordViewController: BaseViewController {
    
    private let passwordLabel = UILabel()
    private let passwordTextField = UITextField()
    private let newPasswordLabel = UILabel()
    private let newPasswordCheckTextField = UITextField()
    private let passwordCheckLabel = UILabel()
    private let passwordCheckTextField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigation()
    }
    
    // MARK: - 탭바제거
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isTranslucent = true
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isTranslucent = false
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func setConfigure() {
        
        view.do {
            $0.backgroundColor = UIColor(r: 30, g: 32, b: 33)
        }
        
        passwordLabel.do {
            $0.text = "현재 비밀번호"
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
            $0.isSecureTextEntry = true
            let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 18, height: $0.frame.height))
            $0.leftView = leftPaddingView
            $0.leftViewMode = .always
            $0.attributedPlaceholder = NSAttributedString(string: "현재 비밀번호를 입력해주세요", attributes: [NSAttributedString.Key.foregroundColor: UIColor(r: 216, g: 216, b: 216)])
        }
        
        newPasswordLabel.do {
            $0.text = "새 비밀번호"
            $0.font = .bodyMedium18
            $0.textColor = .turquoiseGreen
        }
        
        newPasswordCheckTextField.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.backgroundColor = UIColor(r: 54, g: 56, b: 57)
            $0.font = UIFont.systemFont(ofSize: 16, weight: .bold)
            $0.layer.cornerRadius = 10
            $0.layer.masksToBounds = true
            $0.textColor = .white
            $0.clearButtonMode = .whileEditing
            $0.isSecureTextEntry = true
            let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 18, height: $0.frame.height))
            $0.leftView = leftPaddingView
            $0.leftViewMode = .always
            $0.attributedPlaceholder = NSAttributedString(string: "비밀번호를 한 번 더 입력해주세요. ", attributes: [NSAttributedString.Key.foregroundColor: UIColor(r: 216, g: 216, b: 216)])
        }
        
        passwordCheckLabel.do {
            $0.text = "비밀번호 확인"
            $0.font = .bodyMedium18
            $0.textColor = .turquoiseGreen
        }
        
        passwordCheckTextField.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.backgroundColor = UIColor(r: 54, g: 56, b: 57)
            $0.font = UIFont.systemFont(ofSize: 16, weight: .bold)
            $0.layer.cornerRadius = 10
            $0.layer.masksToBounds = true
            $0.textColor = .white
            $0.clearButtonMode = .whileEditing
            $0.isSecureTextEntry = true
            let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 18, height: $0.frame.height))
            $0.leftView = leftPaddingView
            $0.leftViewMode = .always
            $0.attributedPlaceholder = NSAttributedString(string: "비밀번호를 한 번 더 입력해주세요.", attributes: [NSAttributedString.Key.foregroundColor: UIColor(r: 216, g: 216, b: 216)])
        }
        
    }
    
    override func setConstraints() {
        
        view.addSubviews(passwordLabel, passwordTextField, passwordCheckLabel,passwordCheckTextField, newPasswordLabel, newPasswordCheckTextField)
        
        passwordLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(40)
        }
        
        passwordTextField.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.top.equalTo(passwordLabel.snp.bottom).offset(12)
            $0.height.equalTo(57)
        }
        
        passwordCheckLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.top.equalTo(newPasswordCheckTextField.snp.bottom).offset(21)
        }
        
        passwordCheckTextField.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.top.equalTo(passwordCheckLabel.snp.bottom).offset(12)
            $0.height.equalTo(57)
        }
        
        newPasswordLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.top.equalTo(passwordTextField.snp.bottom).offset(21)
        }
        
        newPasswordCheckTextField.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.top.equalTo(newPasswordLabel.snp.bottom).offset(12)
            $0.height.equalTo(57)
        }
    }
    
    private func setNavigation() {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.title = "비밀번호 변경"
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "수정", style: .plain, target: self, action: #selector(saveButtonTapped))
        self.navigationItem.rightBarButtonItem?.tintColor = .turquoiseGreen
    }
    
    private func updatePassword(originPassword: String, newPassword: String) {
        let bodyDTO = MyPasswordRequestBodyDTO(originPassword: originPassword, newPassword: newPassword)
        NetworkService.shared.myPageService.changePassword(bodyDTO: bodyDTO) { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let data):
                let alert = UIAlertController(title: "비밀번호 변경 완료", message: "비밀번호가 성공적으로 변경되었습니다.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "확인", style: .default, handler: { [weak self] _ in
                    let loginViewController = LoginViewController()
                    self?.navigationController?.pushViewController(loginViewController, animated: true)
                }))
                self.present(alert, animated: true, completion: nil)
                print("서버 연동 성공")
            default:
                print("서버 연동 실패")
                let alert = UIAlertController(title: "비밀번호 변경 실패", message: "비밀번호 변경 중 오류가 발생했습니다.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    @objc func saveButtonTapped() {
        guard let originPassword = passwordTextField.text, !originPassword.isEmpty,
              let newPassword = passwordCheckTextField.text, !newPassword.isEmpty else {
            return
        }
        updatePassword(originPassword: originPassword, newPassword: newPassword)
    }
}
