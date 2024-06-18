//
//  EmailApproveViewController.swift
//  HOMEAT
//
//  Created by 강석호 on 6/1/24.
//

import UIKit

class EmailApproveViewController: BaseViewController {

    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let emailLabel = UILabel()
    private let emailTextField = UITextField()
    private let sendButton = UIButton()
    private let emailApproveLabel = UILabel()
    private let emailApproveTextField = UITextField()
    private let approveButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setTarget()
    }
    
    override func setConfigure() {
        
        view.do {
            $0.backgroundColor = UIColor(r: 30, g: 32, b: 33)
        }
        
        titleLabel.do {
            $0.text = "등록된 이메일로 찾기"
            $0.font = .headMedium28
            $0.textColor = .white
        }
        
        descriptionLabel.do {
            $0.text = "가입 당시 입력한 이메일을 통해 인증 후\n새 비밀번호를 등록해주세요. "
            $0.font = .bodyMedium18
            $0.textColor = .white
            $0.numberOfLines = 0
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
        
        sendButton.do {
            $0.backgroundColor = UIColor(named: "turquoiseGreen")
            $0.titleLabel?.font = .bodyMedium18
            $0.setTitle("전송", for: .normal)
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
        
        approveButton.do {
            $0.backgroundColor = UIColor(named: "turquoiseGreen")
            $0.titleLabel?.font = .bodyMedium18
            $0.setTitle("인증하기", for: .normal)
            $0.setTitleColor(.black, for: .normal)
            $0.layer.cornerRadius = 10
            $0.clipsToBounds = true
        }
    }
    
    override func setConstraints() {
        
        view.addSubviews(titleLabel, descriptionLabel, emailLabel, emailTextField, sendButton, emailApproveLabel, emailApproveTextField, approveButton)
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.top.equalToSuperview().offset(120)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
        }
        
        emailLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(30)
        }
        
        emailTextField.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-110)
            $0.top.equalTo(emailLabel.snp.bottom).offset(12)
            $0.height.equalTo(57)
        }
        
        sendButton.snp.makeConstraints {
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
        
        approveButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.bottom.equalToSuperview().offset(-100)
            $0.height.equalTo(57)
        }
    }
    
    private func setTarget() {
        approveButton.addTarget(self, action: #selector(approveButtonTapped), for: .touchUpInside)
    }
    
    @objc private func approveButtonTapped(_ sender: Any) {
        let nextVC = ChangePasswordViewController()
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}
