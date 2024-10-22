//
//  SetExpenseViewController.swift
//  HOMEAT
//
//  Created by 강삼고 on 5/15/24.
//

import Foundation
import UIKit
import Then
import SnapKit

class SetExpenseViewController: ProgressViewController {
    
    private let expenseTextField = UITextField()
    private let unitLabel = UILabel()
    private let goalUserDefaultsKey = "userGoalPrice"

    override func viewDidLoad() {
        super.viewDidLoad()
        updateProgressBar(progress: 4/4)
        setTitleLabel(title: "한 주 목표 식비는\n얼마인가요?")
        setSubTitleLabel(subtitle: "외식, 배달비 모두 포함이에요!")
        setDetailLabel(detail: "한 주 목표 식비")
        // 탭 제스처 인식기 추가
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    override func setConfigure() {
        super.setConfigure()
        
        continueButton.configuration?.attributedTitle = AttributedString("완료하기")
    
        expenseTextField.do {
            $0.backgroundColor = UIColor(r: 54, g: 56, b: 57)
            $0.makeCornerRound(radius: 10)
            let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 18, height: $0.frame.height))
            $0.leftView = leftPaddingView
            $0.leftViewMode = .always
            $0.delegate = self
            $0.keyboardType = .numberPad
        }
        
        unitLabel.do {
            $0.backgroundColor = UIColor(r: 54, g: 56, b: 57)
            $0.text = "원"
            $0.textColor = UIColor(r: 216, g: 216, b: 216)
            $0.font = .bodyMedium16
        }

    }
    override func setConstraints() {
        super.setConstraints()
        view.addSubviews(expenseTextField)
        expenseTextField.addSubview(unitLabel)
        
        expenseTextField.snp.makeConstraints {
            $0.top.equalToSuperview().offset(369)
            $0.leading.equalToSuperview().offset(20)
            $0.height.equalTo(57)
            $0.trailing.equalToSuperview().offset(-20)
        }
        
        unitLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(18)
            $0.trailing.equalToSuperview().offset(-18.2)
        }
    }
    
    @objc override func isContinueButtonTapped(_ sender: UIButton) {
        guard let nickname = UserDefaults.standard.string(forKey: "userNickname"),
              let gender = UserDefaults.standard.string(forKey: "Gender"),
              let birth = UserDefaults.standard.string(forKey: "userBirthDate"),
              let income = UserDefaults.standard.object(forKey: "userIncome") as? Int,
              let goalPrice = UserDefaults.standard.object(forKey: "userGoalPrice") as? Int else {
            
            print("Error: One or more required UserDefaults values are nil")
            return
        }
    
        let bodyDTO = MyOnboardingRequestBodyDTO(nickname: nickname, gender: gender, birth: birth, adderessId: 1, income: income, goalPrice: goalPrice)
        print("Request Body DTO: \(bodyDTO)")
        NetworkService.shared.onboardingService.myOnboarding(bodyDTO: bodyDTO) { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let data):
                print("연결 성공 ")
                let alertController = UIAlertController(title: nil, message: "추가정보입력이 완료되었습니다", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "확인", style: .default) { _ in
                    let loginVC = HOMEATTabBarController() // 원하는 새로운 뷰 컨트롤러로 변경
                    if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
                        sceneDelegate.changeRootViewController(to: loginVC)
                    }
                }
                alertController.addAction(okAction)
                present(alertController, animated: true, completion: nil)
            default:
                print("연결 실패 ")
                
            }
        }
        
    }
    // 키보드를 숨기는 함수
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension SetExpenseViewController {
    func textFieldDidEndEditing(_ textField: UITextField) {
        handleExpenseTextFieldEditing(textField.text)
    }
    private func handleExpenseTextFieldEditing(_ text: String?) {
        guard let text = text, let income = Int(text) else { return }
        let formattedText = income.formattedWithSeparator
        expenseTextField.text = formattedText
        UserDefaults.standard.set(income, forKey: goalUserDefaultsKey)
        UserDefaults.standard.synchronize()
        print(goalUserDefaultsKey)
        }

    override func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        super.textField(textField, shouldChangeCharactersIn: range, replacementString: string)
        if let char = string.cString(using: String.Encoding.utf8) {
            let isBackSpace = strcmp(char, "\\b")
            if (isBackSpace == -92) {
                return true
            }
        }
        if textField.text?.isEmpty ?? true && string == "0" { return false }
        guard textField.text!.count < 9 else { return false }
        guard Int(string) != nil || string == "" else { return false }
        return true
    }
}
