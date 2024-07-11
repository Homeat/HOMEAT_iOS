//
//  EmailApproveViewController.swift
//  HOMEAT
//
//  Created by 강석호 on 6/1/24.
//

import UIKit

class FindPasswordViewController: BaseViewController, UITextFieldDelegate {

    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let emailLabel = UILabel()
    private let emailTextField = UITextField()
    private let emailApproveLabel = UILabel()
    private let emailApproveTextField = UITextField()
    private let emailApproveStatusLabel = UILabel() // 인증 상태 표시
    private let passwordLabel = UILabel()
    private let passwordTextField = UITextField()
    private let passwordApproveStatusLabel = UILabel()
    private let passwordCheckLabel = UILabel()
    private let passwordCheckTextField = UITextField()
    private let passwordCheckApproveStatusLabel = UILabel()
    private let sendButton = UIButton()
    private let approveButton = UIButton()
    private var activeTextField: UITextField?
    private var authCode: String? // 인증 코드를 저장할 변수
    var isAuthCodeValid: Bool = false
    var isPasswordValid: Bool = false
    var isPasswordMatched: Bool = false
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .white
        return indicator
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupActivityIndicator()
        setAddTarget()
        emailTextField.delegate = self
        emailTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        emailApproveTextField.delegate = self
        emailApproveTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        passwordTextField.delegate = self
        passwordTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        passwordCheckTextField.delegate = self
        passwordCheckTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        setNavigation()
    }
    // MARK: - 탭바제거
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let tabBarController = self.tabBarController as? HOMEATTabBarController {
            tabBarController.tabBar.isHidden = true
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let tabBarController = self.tabBarController as? HOMEATTabBarController {
            tabBarController.tabBar.isHidden = false
        }
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
            $0.backgroundColor = UIColor(named: "warmgray3")
            $0.titleLabel?.font = .bodyMedium18
            $0.setTitle("인증", for: .normal)
            $0.setTitleColor(.black, for: .normal)
            $0.alpha = 0.5
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
            $0.keyboardType = .numberPad
        }
        
        emailApproveStatusLabel.do {
            $0.text = "입력해 주세요."
            $0.font = .captionMedium13
            $0.textColor = UIColor(r: 30, g: 32, b: 33)
        }
        
        passwordLabel.do {
            $0.text = "비밀번호"
            $0.font = .bodyMedium18
            $0.textColor = .turquoiseGreen
        }
        
        passwordTextField.do {
            $0.backgroundColor = UIColor(r: 54, g: 56, b: 57)
            $0.font = UIFont.bodyBold15
            $0.layer.cornerRadius = 10
            $0.layer.masksToBounds = true
            $0.textColor = .white
            $0.clearButtonMode = .whileEditing
            $0.isSecureTextEntry = true
            let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 18, height: $0.frame.height))
            $0.leftView = leftPaddingView
            $0.leftViewMode = .always
            $0.attributedPlaceholder = NSAttributedString(string: "영어,숫자,특수문자 포함 8자리 이상입니다.", attributes: [NSAttributedString.Key.foregroundColor: UIColor(r: 216, g: 216, b: 216)])
        }
        passwordApproveStatusLabel.do {
            $0.text = "입력해 주세요."
            $0.font = .captionMedium13
            $0.textColor = UIColor(r: 30, g: 32, b: 33)
        }
        
        passwordCheckLabel.do {
            $0.text = "비밀번호 확인"
            $0.font = .bodyMedium18
            $0.textColor = .turquoiseGreen
        }
        
        passwordCheckTextField.do {
            $0.backgroundColor = UIColor(r: 54, g: 56, b: 57)
            $0.font = UIFont.systemFont(ofSize: 16, weight: .bold)
            $0.layer.cornerRadius = 10
            $0.layer.masksToBounds = true
            $0.textColor = .white
            $0.isSecureTextEntry = true
            $0.clearButtonMode = .whileEditing
            let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 18, height: $0.frame.height))
            $0.leftView = leftPaddingView
            $0.leftViewMode = .always
            $0.attributedPlaceholder = NSAttributedString(string: "비밀번호를 한 번 더 입력해주세요. ", attributes: [NSAttributedString.Key.foregroundColor: UIColor(r: 216, g: 216, b: 216)])
        }
        
        passwordCheckApproveStatusLabel.do {
            $0.text = "입력해 주세요."
            $0.font = .captionMedium13
            $0.textColor = UIColor(r: 30, g: 32, b: 33)
        }
        
        
        sendButton.do {
            $0.titleLabel?.font = .bodyMedium18
            $0.setTitle("변경하기", for: .normal)
            $0.backgroundColor = UIColor(named: "warmgray3")
            $0.alpha = 0.5
            $0.setTitleColor(.black, for: .normal)
            $0.layer.cornerRadius = 10
            $0.clipsToBounds = true
        }
    }
    
    override func setConstraints() {
        let padding: CGFloat = 20
        let verticalSpacing: CGFloat = 7
        let buttonHeight: CGFloat = UIScreen.main.bounds.height * 0.07
        let textFieldHeight: CGFloat = UIScreen.main.bounds.height * 0.07
        view.addSubviews(titleLabel, descriptionLabel, emailLabel, emailTextField, emailApproveLabel, emailApproveTextField,emailApproveStatusLabel, approveButton)
        view.addSubviews(passwordLabel,passwordTextField,passwordCheckLabel,passwordCheckTextField,passwordApproveStatusLabel,passwordCheckApproveStatusLabel,sendButton)
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(padding)
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(30)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(padding)
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
        }
        
        emailLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(padding)
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(padding)
        }
        
        emailTextField.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(padding)
            $0.trailing.equalTo(approveButton.snp.leading).offset(-padding)
            $0.top.equalTo(emailLabel.snp.bottom).offset(verticalSpacing)
            $0.height.equalTo(textFieldHeight)
        }
        
        approveButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-padding)
            $0.width.equalToSuperview().multipliedBy(0.25)
            $0.top.equalTo(emailLabel.snp.bottom).offset(verticalSpacing)
            $0.height.equalTo(buttonHeight)
        }
        
        emailApproveLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(padding)
            $0.top.equalTo(emailTextField.snp.bottom).offset(verticalSpacing)
        }
        
        emailApproveTextField.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(padding)
            $0.trailing.equalToSuperview().offset(-padding)
            $0.top.equalTo(emailApproveLabel.snp.bottom).offset(verticalSpacing)
            $0.height.equalTo(textFieldHeight)
        }
        
        emailApproveStatusLabel.snp.makeConstraints {
            $0.top.equalTo(emailApproveTextField.snp.bottom).offset(verticalSpacing / 2)
            $0.leading.equalToSuperview().offset(padding)
            $0.trailing.equalToSuperview().offset(-padding)
        }
        
        passwordLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(padding)
            $0.top.equalTo(emailApproveStatusLabel.snp.bottom).offset(verticalSpacing)
        }
        
        passwordTextField.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(padding)
            $0.trailing.equalToSuperview().offset(-padding)
            $0.top.equalTo(passwordLabel.snp.bottom).offset(verticalSpacing)
            $0.height.equalTo(textFieldHeight)
        }
        
        passwordApproveStatusLabel.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(verticalSpacing / 2)
            $0.leading.equalToSuperview().offset(padding)
        }
        
        passwordCheckLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(padding)
            $0.top.equalTo(passwordApproveStatusLabel.snp.bottom).offset(verticalSpacing)
        }
        
        passwordCheckTextField.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(padding)
            $0.trailing.equalToSuperview().offset(-padding)
            $0.top.equalTo(passwordCheckLabel.snp.bottom).offset(verticalSpacing)
            $0.height.equalTo(textFieldHeight)
        }
        
        passwordCheckApproveStatusLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(padding)
            $0.top.equalTo(passwordCheckTextField.snp.bottom).offset(verticalSpacing / 2)
        }
        
        sendButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(padding)
            $0.trailing.equalToSuperview().offset(-padding)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-padding)
            $0.height.equalTo(buttonHeight)
        }
    }
    private func setupActivityIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    private func setAddTarget() {
        emailTextField.addTarget(self, action: #selector(verifyEmail), for: .editingChanged)
        emailApproveTextField.addTarget(self, action: #selector(verifyApproveButtonClicked), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(verifyApprovePassword), for: .editingChanged)
        passwordCheckTextField.addTarget(self, action: #selector(verifyApproveSamePassword), for: .editingChanged)
        approveButton.addTarget(self, action: #selector(approveButtonClicked), for: .touchUpInside)
        sendButton.addTarget(self, action: #selector(sendButtonClicked), for: .touchUpInside)
    }
    private func showLoading(_ show: Bool) {
        if show {
            activityIndicator.startAnimating()
            view.isUserInteractionEnabled = false
        } else {
            activityIndicator.stopAnimating()
            view.isUserInteractionEnabled = true
        }
    }
    
    private func setNavigation() {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.title = "비밀번호 찾기"
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.tintColor = .white
    }
    // MARK: - Actions
    @objc private func textFieldDidChange(_ textField: UITextField) {
        updateSendButtonState()
    }
    
    private func updateSendButtonState() {
        let isAllFieldsFilled = !(emailTextField.text?.isEmpty ?? true) &&
        !(emailApproveTextField.text?.isEmpty ?? true) &&
        !(passwordTextField.text?.isEmpty ?? true) &&
        !(passwordCheckTextField.text?.isEmpty ?? true) &&
        isAuthCodeValid &&
        isPasswordValid &&
        isPasswordMatched
        sendButton.isEnabled = isAllFieldsFilled
        sendButton.alpha = isAllFieldsFilled ? 1.0 : 0.5
        sendButton.backgroundColor = isAllFieldsFilled ? UIColor(named: "turquoiseGreen") : UIColor(named: "warmgray3")
    }

    func showAlert(title: String, message: String, isSignUpSuccess: Bool = false) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default) { _ in
            if isSignUpSuccess {
                let newViewController = CompleteSignupViewController()
                self.navigationController?.pushViewController(newViewController, animated: true)
            }
        }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    @objc func verifyEmail() {
        let isEmailFilled = !(emailTextField.text?.isEmpty ?? true)
        approveButton.isEnabled = isEmailFilled
        approveButton.alpha = isEmailFilled ? 1.0 : 0.5
        approveButton.backgroundColor = isEmailFilled ? UIColor(named: "turquoiseGreen") : UIColor(named: "warmgray3")
    }
    @objc func verifyApproveButtonClicked() {
        guard let inputCode = emailApproveTextField.text, !inputCode.isEmpty else {
            emailApproveStatusLabel.textColor = UIColor(r: 30, g: 32, b: 33)
            return
        }
        
        if inputCode == authCode {
            emailApproveStatusLabel.text = "인증번호가 맞습니다"
            emailApproveStatusLabel.textColor = UIColor(named: "turquoiseGreen")
            isAuthCodeValid = true
        } else {
            emailApproveStatusLabel.text = "인증번호가 틀립니다"
            emailApproveStatusLabel.textColor = UIColor.turquoiseRed
            isAuthCodeValid = false
        }
    }
    @objc func verifyApprovePassword() {
        if isValidPw(passwordTextField.text ?? "") {
            passwordApproveStatusLabel.textColor = UIColor(named: "turquoiseGreen")
            passwordApproveStatusLabel.text = "비밀번호 사용 가능합니다."
            isPasswordValid = true
        } else if passwordTextField.text == "" {
            passwordApproveStatusLabel.textColor = UIColor(r: 30, g: 32, b: 33)
            isPasswordValid = false
            
        } else {
            passwordApproveStatusLabel.text = "영어,숫자,특수문자 포함 8자리 이상입니다."
            passwordApproveStatusLabel.textColor = UIColor.turquoiseRed
            isPasswordValid = false
        }
    }
    @objc func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
            return
        }
        
        let keyboardHeight = keyboardFrame.height
        let activeTextField = getActiveTextField()

        if activeTextField == passwordTextField {
            UIView.animate(withDuration: 0.3) {
                self.view.frame.origin.y = -100
            }
        } else if activeTextField == passwordCheckTextField {
            UIView.animate(withDuration: 0.3) {
                self.view.frame.origin.y = -120
            }
        }
        else {
            UIView.animate(withDuration: 0.3) {
                self.view.frame.origin.y = 0
            }
        }
    }
    @objc func keyboardWillHide(_ notification: Notification) {
        UIView.animate(withDuration: 0.3) {
            self.view.frame.origin.y = 0
        }
    }
    @objc func approveButtonClicked() {
        guard let email = emailTextField.text, !email.isEmpty else {
            showAlert(title: "이메일을 입력해주세요", message: "")
            return
        }
        let emailVerificationRequest = EmailVerificationRequestBodyDTO(email: email)
        showLoading(true)
        
        NetworkService.shared.onboardingService.emailVerification(bodyDTO: emailVerificationRequest) { [weak self] response in
            guard let self = self else { return }
            self.showLoading(false)
            
            switch response {
            case .success(let data):
                if data.code == "COMMON_200" {
                    showAlert(title: "이메일 인증번호가 발송되었습니다.", message: "")
                    self.authCode = data.data?.authCode
                } else if data.code == "MEMBER_4090" {
                    showAlert(title: "이미 존재하는 이메일 입니다.", message: "")
                }
            default:
                showAlert(title: "이메일 형식을 올바르게 해주세요", message: "")
                print("이메일인증실패")
                
            }
        }
    }
    @objc func sendButtonClicked() {
        guard let email = emailTextField.text, !email.isEmpty,
              let authCodeInput = emailApproveTextField.text, !authCodeInput.isEmpty,
              let password = passwordTextField.text, !password.isEmpty,
              let passwordCheck = passwordCheckTextField.text, !passwordCheck.isEmpty else {
            print("모든 필드를 입력해주세요.")
            self.showAlert(title: "모든 필드를 입력해주세요.", message: "")
            return
        }
        myPasswordEdit(email: email, password: password)
    }
    @objc func verifyApproveSamePassword() {
        if passwordCheckTextField.text == passwordTextField.text {
            if passwordCheckTextField.text == "" && passwordTextField.text == "" {
                passwordCheckApproveStatusLabel.textColor = UIColor(r: 30, g: 32, b: 33)
                isPasswordMatched = false
            } else {
                passwordCheckApproveStatusLabel.textColor = UIColor(named: "turquoiseGreen")
                passwordCheckApproveStatusLabel.text = "비밀번호가 일치합니다."
                isPasswordMatched = true
            }
        } else if passwordCheckTextField.text ==  "" {
            passwordCheckApproveStatusLabel.textColor = UIColor(r: 30, g: 32, b: 33)
            isPasswordMatched = false
            
        } else {
            passwordCheckApproveStatusLabel.text = "다시 입력해주세요."
            passwordCheckApproveStatusLabel.textColor = UIColor.turquoiseRed
            isPasswordMatched = false
        }
    }

    
    private func myPasswordEdit(email: String,password: String ) {
        let bodyDTO = FindPasswordRequestBodyDTO(email: email, newPassword: password)
        NetworkService.shared.onboardingService.findPassword(bodyDTO: bodyDTO) { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let data):
                print("비밀번호 찾기 성공")
                let finishVC =  FinishPasswordViewController()
                navigationController?.pushViewController(finishVC, animated: true)
            default:
                print("비밀번호 찾기 실패")
            }
            
        }
    }
    func getActiveTextField() -> UITextField? {
        if emailTextField.isFirstResponder {
            return emailTextField
        } else if emailApproveTextField.isFirstResponder {
            return emailApproveTextField
        } else if passwordTextField.isFirstResponder {
            return passwordTextField
        } else if passwordCheckTextField.isFirstResponder {
            return passwordCheckTextField
        }  else {
            return nil
        }
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTextField = textField
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        activeTextField = nil
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    func isValidPw(_ pw: String) -> Bool {
        let pwRegex = "^(?=.*[A-Za-z])(?=.*[0-9])(?=.*[!@#$%^&*()_+=-]).{8,20}"
        let pwPredicate = NSPredicate(format: "SELF MATCHES %@", pwRegex)
        return pwPredicate.evaluate(with: pw)
    }
}
