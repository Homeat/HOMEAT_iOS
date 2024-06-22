//
//  SignUpViewController.swift
//  HOMEAT
//
//  Created by 강석호 on 6/1/24.
//

import UIKit

class SignUpViewController: BaseViewController {
    
    private let emailLabel = UILabel()
    private let emailTextField = UITextField()
    private let approveButton = UIButton()
    private let emailApproveLabel = UILabel()
    private let emailApproveTextField = UITextField()
    private let passwordLabel = UILabel()
    private let passwordTextField = UITextField()
    private let passwordCheckLabel = UILabel()
    private let passwordCheckTextField = UITextField()
    private let continueButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setAddTarget()
    }
    
    // MARK: UI
    override func setConfigure() {
        view.do {
            $0.backgroundColor = UIColor(r: 30, g: 32, b: 33)
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
        
        approveButton.do {
            $0.backgroundColor = UIColor(named: "turquoiseGreen")
            $0.titleLabel?.font = .bodyMedium18
            $0.setTitle("인증", for: .normal)
            $0.setTitleColor(.black, for: .normal)
            $0.layer.cornerRadius = 10
            $0.clipsToBounds = true
        }
        
        emailApproveLabel.do {
            $0.text = "이메일 인증"
            $0.font = .bodyMedium18
            $0.textColor = .turquoiseGreen
        }
        
        emailApproveTextField.do {
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
            $0.attributedPlaceholder = NSAttributedString(string: "이메일에 전송된 번호를 입력해주세요. ", attributes: [NSAttributedString.Key.foregroundColor: UIColor(r: 216, g: 216, b: 216)])
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
            $0.attributedPlaceholder = NSAttributedString(string: "비밀번호는 8~20자로 입력해주세요.", attributes: [NSAttributedString.Key.foregroundColor: UIColor(r: 216, g: 216, b: 216)])
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
            let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 18, height: $0.frame.height))
            $0.leftView = leftPaddingView
            $0.leftViewMode = .always
            $0.attributedPlaceholder = NSAttributedString(string: "비밀번호를 한 번 더 입력해주세요. ", attributes: [NSAttributedString.Key.foregroundColor: UIColor(r: 216, g: 216, b: 216)])
        }
        
        continueButton.do {
            $0.backgroundColor = UIColor(named: "turquoiseGreen")
            $0.titleLabel?.font = .bodyMedium18
            $0.setTitle("회원가입", for: .normal)
            $0.setTitleColor(.black, for: .normal)
            $0.layer.cornerRadius = 10
            $0.clipsToBounds = true
        }
    }
    
    override func setConstraints() {
        
        view.addSubviews(emailLabel, emailTextField, approveButton, emailApproveLabel, emailApproveTextField, passwordLabel, passwordTextField, passwordCheckLabel, passwordCheckTextField, continueButton)
        
        emailLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.top.equalToSuperview().offset(120)
        }
        
        emailTextField.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-110)
            $0.top.equalTo(emailLabel.snp.bottom).offset(12)
            $0.height.equalTo(57)
        }
        
        approveButton.snp.makeConstraints {
            $0.leading.equalTo(emailTextField.snp.trailing).offset(10)
            $0.trailing.equalToSuperview().offset(-20)
            $0.top.equalTo(emailLabel.snp.bottom).offset(12)
            $0.height.equalTo(57)
        }
        
        emailApproveLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.top.equalTo(emailTextField.snp.bottom).offset(21)
        }
        
        emailApproveTextField.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.top.equalTo(emailApproveLabel.snp.bottom).offset(12)
            $0.height.equalTo(57)
        }
        
        passwordLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.top.equalTo(emailApproveTextField.snp.bottom).offset(21)
        }
        
        passwordTextField.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.top.equalTo(passwordLabel.snp.bottom).offset(12)
            $0.height.equalTo(57)
        }
        
        passwordCheckLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.top.equalTo(passwordTextField.snp.bottom).offset(21)
        }
        
        passwordCheckTextField.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.top.equalTo(passwordCheckLabel.snp.bottom).offset(12)
            $0.height.equalTo(57)
        }
        
        continueButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.bottom.equalToSuperview().offset(-100)
            $0.height.equalTo(57)
        }
    }
    
    func setAddTarget() {
        approveButton.addTarget(self, action: #selector(approveButtonClicked), for: .touchUpInside)
    }
    
    @objc func approveButtonClicked() {
        guard let email = emailTextField.text, !email.isEmpty else {
            showAlert(title: "이메일을 입력해주세요", message: "")
            return
        }
        
        let emailCertificationRequest = EmailCertificationRequestBodyDTO(email: email)
        let apiLoader = APIRequestLoader<OnboardingTarget>(apiLogger: APIEventLogger())
        
        apiLoader.fetchData(target: .emailCertification(emailCertificationRequest), responseData: EmailCertificationResponseDTO.self) { result in
            switch result {
            case .success(let response):
                if response.isSuccess {
                    self.showAlert(title: "이메일 인증번호가 발송되었습니다.", message: "")
                } else {
                    self.showAlert(title: "이메일 형식을 올바르게 해주세요", message: "")
                }
            default :
                print("Network error")
            }
        }
    }
    
    func showAlert(title: String, message: String) {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
        }
}
