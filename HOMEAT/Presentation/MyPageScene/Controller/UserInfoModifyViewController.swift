//
//  UserInfoModifyViewController.swift
//  HOMEAT
//
//  Created by 강석호 on 4/5/24.
//

import Foundation
import UIKit


class UserInfoModifyViewController : BaseViewController, UITextFieldDelegate {
    
    // MARK: Property
    private let presentNickNameLabel = UILabel()
    private let presentInfoView = PresentInfoView()
    private let checkNickNameLabel = UILabel()
    private let duplicationCheckButton = UIButton()
    private let confirmButton = UIButton()
    private let nickNameField = UITextField()
    private var userName: String = ""
    var isNicknameValid: Bool = false
    private var newName: String = ""
    // MARK: Life Cycle
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigation()
        nickNameField.delegate = self
        nickNameField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        userName = UserDefaults.standard.string(forKey: "userNickname") ?? "사용자"
        confirmButton.addTarget(self, action: #selector(confirmButtonTapped), for: .touchUpInside)

    }
    
    // MARK: UI
    override func setConfigure() {
        view.do {
            $0.backgroundColor = UIColor(r: 30, g: 32, b: 33)
        }
        
        presentNickNameLabel.do {
            $0.text = "현재 닉네임"
            $0.font = .bodyMedium18
            $0.textColor = .turquoiseGreen
        }
        
        checkNickNameLabel.do {
            $0.text = "변경할 닉네임"
            $0.font = .bodyMedium18
            $0.textColor = .turquoiseGreen
        }
        
        nickNameField.do {
            let attributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: UIColor.gray
            ]
            $0.attributedPlaceholder = NSAttributedString(string: "변경할 닉네임을 작성하세요", attributes: attributes)
            $0.font = .bodyMedium16
            $0.textColor = .white
            $0.layer.cornerRadius = 10
            $0.clipsToBounds = true
            $0.backgroundColor = .coolGray4
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: $0.frame.height))
            $0.leftViewMode = .always
        }
        
        duplicationCheckButton.do {
            $0.setTitle("중복확인", for: .normal)
            $0.setTitleColor(UIColor.black, for: .normal)
            $0.layer.cornerRadius = 10
            $0.layer.masksToBounds = true
            $0.backgroundColor = UIColor(named: "warmgray3")
            $0.alpha = 0.5
            $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
            $0.addTarget(self, action: #selector(duplicationCheckButtonTapped), for: .touchUpInside)
        }
        
        confirmButton.do {
            $0.setTitle("변경하기", for: .normal)
            $0.setTitleColor(UIColor.black, for: .normal)
            $0.layer.cornerRadius = 10
            $0.layer.masksToBounds = true
            $0.backgroundColor = UIColor(named: "warmgray3")
            $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
    }
    
    override func setConstraints() {
        
        view.addSubviews(presentNickNameLabel, presentInfoView, checkNickNameLabel, nickNameField,duplicationCheckButton, confirmButton)
        
        presentNickNameLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(35)
            $0.leading.equalToSuperview().offset(20)
        }
        
        presentInfoView.snp.makeConstraints {
            $0.top.equalTo(presentNickNameLabel.snp.bottom).offset(12)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(57)
        }
        
        checkNickNameLabel.snp.makeConstraints {
            $0.top.equalTo(presentInfoView.snp.bottom).offset(35)
            $0.leading.equalToSuperview().offset(20)
        }
        
        nickNameField.snp.makeConstraints {
            $0.top.equalTo(checkNickNameLabel.snp.bottom).offset(12)
            $0.leading.equalToSuperview().offset(20)
            $0.height.equalTo(57)
            $0.width.equalTo(250)
        }
        
        duplicationCheckButton.snp.makeConstraints {
            $0.top.equalTo(checkNickNameLabel.snp.bottom).offset(12)
            $0.leading.equalTo(nickNameField.snp.trailing).offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(57)
        }
        
        confirmButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-32)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(57)
        }
        
    }
    private func setNavigation() {
        self.navigationItem.title = "닉네임 변경"
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.tintColor = .white
    }
    
    private func updateServer() {
        let bodyDTO = NicknameRequestBodyDTO(nickname: newName)
        NetworkService.shared.myPageService.myPageNickNameEdit(bodyDTO: bodyDTO) { [weak self] response in
                guard let self = self else { return }
                switch response {
                case .success(let data):
                    print("닉네임 수정 완료")
                    let nextVC = FinishNicknameViewController()
                    navigationController?.pushViewController(nextVC, animated: true)
                default:
                    print("닉네임 수정 실패")
                    
                }
            }
        }
    

    @objc private func duplicationCheckButtonTapped() {
        guard let newName = nickNameField.text, !newName.isEmpty else {
            showAlert(message: "변경할 닉네임을 입력해주세요.")
            return
        }
        checkNicknameDuplication(nickname: newName)
    }
    private func setTapBarHidden() {
        self.tabBarController?.tabBar.isHidden = true
    }
    
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        guard let text = textField.text else { return true }
//        let newLength = text.count + string.count - range.length
//        if newLength > 10 {
//            return false
//        }
//        let allowedCharacters = CharacterSet(charactersIn: "!@#")
//        let characterSet = CharacterSet(charactersIn: string)
//        return !allowedCharacters.isSuperset(of: characterSet)
//    }
//    
    private func isValidNickname(nickname: String) -> Bool {
        return nickname.count <= 10 && !nickname.contains("!") && !nickname.contains("@") && !nickname.contains("#")
    }
    
    private func checkNicknameDuplication(nickname: String) {
            let nickname = nickNameField.text ?? ""
            let bodyDTO = NicknameRequestBodyDTO(nickname: nickname)
            NetworkService.shared.myPageService.myNicknameExist(bodyDTO: bodyDTO) { [weak self] response in
                guard let self = self else { return }
                switch response {
                case .success(let data):
                    if data.code == "COMMON_200" {
                        isNicknameValid = true
                        showAlert(message: "사용 가능한 닉네임입니다.")
                        UserDefaults.standard.set(nickname, forKey: "userNickname")
                        self.confirmButton.backgroundColor = .turquoiseGreen
                        self.confirmButton.isEnabled = true
                        
                    } else if data.code == "MEMBER_4091" {
                        showAlert(message: "이미 사용 중인 닉네임입니다.")
                        isNicknameValid = false
                    } else if data.code == "COMMON_400" {
                        showAlert(message: "공백일 수 없습니다.")
                        isNicknameValid = false
                    }
                default:
                    print("닉네임 존재안됨 ")
                    isNicknameValid = false

                }
                
            }
     }
    private func showAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    private func showSuccessAlert() {
            let alert = UIAlertController(title: "닉네임 변경 완료", message: "닉네임이 성공적으로 변경되었습니다.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .default, handler: { [weak self] _ in
                self?.navigationController?.popViewController(animated: true) // Navigate back to previous screen
            }))
            present(alert, animated: true, completion: nil)
        }
        
        private func showFailureAlert() {
            let alert = UIAlertController(title: "닉네임 변경 실패", message: "닉네임 변경 중 오류가 발생했습니다.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    @objc private func textFieldDidChange(_ textField: UITextField) {
        if let text = textField.text, !text.isEmpty {
            duplicationCheckButton.backgroundColor = .turquoiseGreen
            duplicationCheckButton.alpha = 1.0
        } else {
            duplicationCheckButton.backgroundColor = UIColor(named: "warmgray3")
            duplicationCheckButton.alpha = 0.5
        }
    }
    @objc private func confirmButtonTapped() {
        guard isNicknameValid, let newName = nickNameField.text, !newName.isEmpty else {
            showAlert(message: "유효한 닉네임을 입력해주세요.")
            return
        }
        self.newName = newName
        updateServer()
    }
}
