//
//  SignUpViewController.swift
//  HOMEAT
//
//  Created by 강석호 on 6/1/24.
//

import UIKit
import Alamofire
class SignUpViewController: BaseViewController, UITextFieldDelegate {
    
    private let emailLabel = UILabel()
    private let emailTextField = UITextField()
    private let approveButton = UIButton()
    private let emailApproveLabel = UILabel()
    private let emailApproveTextField = UITextField()
    private let emailApproveStatusLabel = UILabel() // 인증 상태 표시
    private let passwordLabel = UILabel()
    private let passwordTextField = UITextField()
    private let passwordApproveStatusLabel = UILabel()
    private let passwordCheckLabel = UILabel()
    private let passwordCheckTextField = UITextField()
    private let passwordCheckApproveStatusLabel = UILabel()
    private let nicknameLabel = UILabel()
    private let nicknameTextField = UITextField()
    private let signupButton = UIButton()
    private var authCode: String? // 인증 코드를 저장할 변수
    private let nicknameApproveStatusLabel = UILabel()
    private var activeTextField: UITextField?
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .white
        return indicator
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigation()
        setAddTarget()
        emailTextField.delegate = self
        emailTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        emailApproveTextField.delegate = self
        emailApproveTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        passwordTextField.delegate = self
        passwordTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        passwordCheckTextField.delegate = self
        passwordCheckTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        nicknameTextField.delegate = self
        nicknameTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        setupActivityIndicator()
        
    }
    // MARK: - 탭바제거
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let tabBarController = self.tabBarController as? HOMEATTabBarController {
            tabBarController.tabBar.isHidden = true
        }
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
        nicknameLabel.do {
            $0.text = "닉네임"
            $0.font = .bodyMedium18
            $0.textColor = .turquoiseGreen
        }
        
        nicknameTextField.do {
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
            $0.attributedPlaceholder = NSAttributedString(string: "한국어,영어 모두 가능해요.", attributes: [NSAttributedString.Key.foregroundColor: UIColor(r: 216, g: 216, b: 216)])
        }
        signupButton.do {
            $0.backgroundColor = UIColor(named: "warmgray3")
            $0.titleLabel?.font = .bodyMedium18
            $0.setTitle("회원가입", for: .normal)
            $0.setTitleColor(.black, for: .normal)
            $0.layer.cornerRadius = 10
            $0.alpha = 0.5
            $0.clipsToBounds = true
        }
        
        nicknameApproveStatusLabel.do {
            $0.text = "입력해 주세요."
            $0.font = .captionMedium13
            
            $0.textColor = UIColor(r: 30, g: 32, b: 33)
        }
    }
    
    override func setConstraints() {
        view.addSubviews(emailLabel, emailTextField, approveButton, emailApproveLabel, emailApproveTextField, passwordLabel, passwordTextField, passwordCheckLabel, passwordCheckTextField, signupButton, nicknameLabel, nicknameTextField, emailApproveStatusLabel, passwordApproveStatusLabel, passwordCheckApproveStatusLabel, nicknameApproveStatusLabel)
        
        let padding: CGFloat = 20
        let verticalSpacing: CGFloat = 7
        let buttonHeight: CGFloat = UIScreen.main.bounds.height * 0.07 // Proportional button height
        let textFieldHeight: CGFloat = UIScreen.main.bounds.height * 0.07 // Proportional text field height
        emailLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(padding)
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(padding)
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
        
        nicknameLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(padding)
            $0.top.equalTo(passwordCheckApproveStatusLabel.snp.bottom).offset(verticalSpacing)
        }
        
        nicknameTextField.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(padding)
            $0.trailing.equalToSuperview().offset(-padding)
            $0.top.equalTo(nicknameLabel.snp.bottom).offset(verticalSpacing)
            $0.height.equalTo(textFieldHeight)
        }
        
        nicknameApproveStatusLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(padding)
            $0.top.equalTo(nicknameTextField.snp.bottom).offset(verticalSpacing / 2)
        }
        
        signupButton.snp.makeConstraints {
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
        nicknameTextField.addTarget(self, action: #selector(verifyNickname), for: .editingChanged)
        approveButton.addTarget(self, action: #selector(approveButtonClicked), for: .touchUpInside)
        signupButton.addTarget(self, action: #selector(signUpButtonClicked), for: .touchUpInside)
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
        self.navigationItem.title = "회원가입"
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.tintColor = .white
    }
    // MARK: - Actions
    @objc private func textFieldDidChange(_ textField: UITextField) {
        updateSignUpButtonState()
    }
    //
    //    private func updateApproveButtonState() {
    //
    //    }
    private func updateSignUpButtonState() {
        let isAllFieldsFilled = !(emailTextField.text?.isEmpty ?? true) &&
        !(emailApproveTextField.text?.isEmpty ?? true) &&
        !(passwordTextField.text?.isEmpty ?? true) &&
        !(passwordCheckTextField.text?.isEmpty ?? true) &&
        !(nicknameTextField.text?.isEmpty ?? true)
        signupButton.isEnabled = isAllFieldsFilled
        signupButton.alpha = isAllFieldsFilled ? 1.0 : 0.5
        signupButton.backgroundColor = isAllFieldsFilled ? UIColor(named: "turquoiseGreen") : UIColor(named: "warmgray3")
    }
    @objc func approveButtonClicked() {
        guard let email = emailTextField.text, !email.isEmpty else {
            showAlert(title: "이메일을 입력해주세요", message: "")
            return
        }
        let emailCertificationRequest = EmailCertificationRequestBodyDTO(email: email)
        showLoading(true)
        
        NetworkService.shared.onboardingService.emailCertificate(bodyDTO: emailCertificationRequest) { [weak self] response in
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
        } else {
            emailApproveStatusLabel.text = "인증번호가 틀립니다"
            emailApproveStatusLabel.textColor = UIColor.turquoiseRed
        }
    }
    @objc func verifyApprovePassword() {
        if isValidPw(passwordTextField.text ?? "") {
            passwordApproveStatusLabel.textColor = UIColor(named: "turquoiseGreen")
            passwordApproveStatusLabel.text = "비밀번호 사용 가능합니다."
        } else if passwordTextField.text == "" {
            passwordApproveStatusLabel.textColor = UIColor(r: 30, g: 32, b: 33)
            
        } else {
            passwordApproveStatusLabel.text = "영어,숫자,특수문자 포함 8자리 이상입니다."
            passwordApproveStatusLabel.textColor = UIColor.turquoiseRed
        }
    }
    
    @objc func verifyApproveSamePassword() {
        if passwordCheckTextField.text == passwordTextField.text {
            if passwordCheckTextField.text == "" && passwordTextField.text == "" {
                passwordCheckApproveStatusLabel.textColor = UIColor(r: 30, g: 32, b: 33)
            } else {
                passwordCheckApproveStatusLabel.textColor = UIColor(named: "turquoiseGreen")
                passwordCheckApproveStatusLabel.text = "비밀번호가 일치합니다."
            }
        } else if passwordCheckTextField.text ==  "" {
            passwordCheckApproveStatusLabel.textColor = UIColor(r: 30, g: 32, b: 33)
            
        } else {
            passwordCheckApproveStatusLabel.text = "다시 입력해주세요."
            passwordCheckApproveStatusLabel.textColor = UIColor.turquoiseRed
        }
    }
    
    @objc func verifyNickname() {
        let nickname = nicknameTextField.text ?? ""
        let bodyDTO = NicknameRequestBodyDTO(nickname: nickname)
        NetworkService.shared.myPageService.myNicknameExist(bodyDTO: bodyDTO) { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let data):
                if data.code == "COMMON_200" {
                    nicknameApproveStatusLabel.text = "멋진 닉네임이에요!"
                    nicknameApproveStatusLabel.textColor = UIColor(named: "turquoiseGreen")
                    UserDefaults.standard.set(nickname, forKey: "userNickname")
                    
                } else if data.code == "MEMBER_4091" {
                    nicknameApproveStatusLabel.text = "이미 존재하는 닉네임 입니다."
                    nicknameApproveStatusLabel.textColor = UIColor.turquoiseRed
                    
                } else if data.code == "COMMON_400" {
                    nicknameApproveStatusLabel.text = "공백일 수 없습니다."
                    nicknameApproveStatusLabel.textColor = UIColor.turquoiseRed
                }
            default:
                print("닉네임 존재안됨 ")
                nicknameApproveStatusLabel.textColor = UIColor(r: 30, g: 32, b: 33)
            }
        }
    }
    
    @objc func signUpButtonClicked() {
        guard let email = emailTextField.text, !email.isEmpty,
              let authCodeInput = emailApproveTextField.text, !authCodeInput.isEmpty,
              let password = passwordTextField.text, !password.isEmpty,
              let passwordCheck = passwordCheckTextField.text, !passwordCheck.isEmpty,
              let nickname = nicknameTextField.text, !nickname.isEmpty else {
            print("모든 필드를 입력해주세요.")
            self.showAlert(title: "모든 필드를 입력해주세요.", message: "")
            return
        }
        
        //let emailSignUpRequest = EmailSignUpRequestBodyDTO(email: email, password: password)
        join(email: email, password: password)
        //        NetworkService.shared.onboardingService.emailJoin(bodyDTO: emailSignUpRequest) { [weak self] response in
        //            guard let self = self else { return }
        //            switch response {
        //            case .success(let data):
        //                
        //                  if let refreshToken = data.data?.refreshToken {
        //                    KeychainHandler.shared.refreshToken = refreshToken
        //                    print("회원가입이 완료되었습니다. ✅")
        //                    self.showAlert(title: "회원가입이 완료되었습니다.", message: "", isSignUpSuccess: true)
        //                } else {
        //                    self.showAlert(title: "토큰을 저장하는데 실패했습니다.", message: "")
        //                }
        //            default:
        //                self.showAlert(title: "회원가입에 실패하였습니다.", message: "")
        //            }
        //        }
    }
    private func join(email: String, password: String) {
        let parameters: [String: Any] = [
            "email": email,
            "password": password
        ]
        let url = "https://dev.homeat.site/v1/members/join/email"
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            switch response.result {
            case .success(let value):
                print("회원가입 성공: \(value)")
                if let json = value as? [String: Any],
                   let isSuccess = json["isSuccess"] as? Bool,
                   isSuccess {
                    if let headers = response.response?.allHeaderFields as? [String: String],
                       let accessToken = headers["Authorization"]?.replacingOccurrences(of: "Bearer ", with: "") {
                        // AccessToken 저장
                        KeychainHandler.shared.accessToken = accessToken
                        print("=============\(accessToken)===========")
                        print("keychain 어세스토큰\(KeychainHandler.shared.accessToken)")
                    } else {
                        print("AccessToken 저장 실패 ❌")
                    }
                    
                    if let data = json["data"] as? [String: Any],
                       let refreshToken = data["refreshToken"] as? String {
                        // RefreshToken 저장
                        KeychainHandler.shared.refreshToken = refreshToken
                        print("=============\(refreshToken)===========")
                    } else {
                        print("RefreshToken 저장 실패 ❌")
                    }
                    
                    DispatchQueue.main.async {
                        self.showAlert(title: "회원가입이 완료되었습니다.", message: "", isSignUpSuccess: true)
                    }
                } else {

                }
            case .failure(let error):
                print("회원가입 실패: \(error)")
                DispatchQueue.main.async {
                    self.showAlert(title: "회원가입 요청 중 오류 발생", message: error.localizedDescription)
                }
            }
        }
    }



    @objc func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
            return
        }
        
        let keyboardHeight = keyboardFrame.height
        let activeTextField = getActiveTextField()

        if activeTextField == passwordCheckTextField {
            UIView.animate(withDuration: 0.3) {
                self.view.frame.origin.y = -100
            }
        } else if activeTextField == nicknameTextField {
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
    func getActiveTextField() -> UITextField? {
        if emailTextField.isFirstResponder {
            return emailTextField
        } else if emailApproveTextField.isFirstResponder {
            return emailApproveTextField
        } else if passwordTextField.isFirstResponder {
            return passwordTextField
        } else if passwordCheckTextField.isFirstResponder {
            return passwordCheckTextField
        } else if nicknameTextField.isFirstResponder {
            return nicknameTextField
        } else {
            return nil
        }
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
