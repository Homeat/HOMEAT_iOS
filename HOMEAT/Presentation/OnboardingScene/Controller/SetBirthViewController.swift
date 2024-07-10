//
//  SetBirthViewController.swift
//  HOMEAT
//
//  Created by 강삼고 on 5/9/24.
//

import Foundation
import UIKit
import Then
import SnapKit

class SetBirthViewController: ProgressViewController {
    
    private let yearTextField = UITextField()
    private let monthTextField = UITextField()
    private let dayTextField = UITextField()
    private let yearPickerView = UIPickerView()
    private let monthPickerView = UIPickerView()
    private let dayPickerView = UIPickerView()
    private let currentYear = Calendar.current.component(.year, from: Date())
    
    private let userDefaultsKey = "userBirthDate"

    override func viewDidLoad() {
        super.viewDidLoad()
        updateProgressBar(progress: 2/5)
        setTitleLabel(title: "생년월일을\n입력해주세요.")
        setDetailLabel(detail: "생년월일")
        setNextVC(nextVC: SetGenderViewController())
        setupKeyboardDismissal()
    }
    
    override func setConfigure() {
        super.setConfigure()
        yearTextField.do {
            $0.backgroundColor = UIColor(r: 54, g: 56, b: 57)
            $0.attributedPlaceholder = NSAttributedString(string: "YYYY", attributes: [NSAttributedString.Key.foregroundColor: UIColor(r: 216, g: 216, b: 216)])
            $0.makeCornerRound(radius: 10)
            let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 18, height: $0.frame.height))
            $0.leftView = leftPaddingView
            $0.leftViewMode = .always
            $0.delegate = self
            $0.inputView = yearPickerView
        }
        
        monthTextField.do {
            $0.backgroundColor = UIColor(r: 54, g: 56, b: 57)
            $0.makeCornerRound(radius: 10)
            $0.attributedPlaceholder = NSAttributedString(string: "MM", attributes: [NSAttributedString.Key.foregroundColor: UIColor(r: 216, g: 216, b: 216)])
            let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 18, height: $0.frame.height))
            $0.leftView = leftPaddingView
            $0.leftViewMode = .always
            $0.delegate = self
            $0.inputView = monthPickerView
        }
        
        dayTextField.do {
            $0.backgroundColor = UIColor(r: 54, g: 56, b: 57)
            $0.makeCornerRound(radius: 10)
            $0.attributedPlaceholder = NSAttributedString(string: "DD", attributes: [NSAttributedString.Key.foregroundColor: UIColor(r: 216, g: 216, b: 216)])
            let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 18, height: $0.frame.height))
            $0.leftView = leftPaddingView
            $0.leftViewMode = .always
            $0.delegate = self
            $0.inputView = dayPickerView
        }
        
        yearPickerView.do {
            $0.delegate = self
            $0.dataSource = self
        }
        
        monthPickerView.do {
            $0.delegate = self
            $0.dataSource = self
        }
        
        dayPickerView.do {
            $0.delegate = self
            $0.dataSource = self
        }

    }
    
    override func setConstraints() {
        super.setConstraints()
        view.addSubviews(yearTextField, monthTextField, dayTextField)
        
        yearTextField.snp.makeConstraints {
            $0.top.equalToSuperview().offset(369)
            $0.leading.equalToSuperview().offset(20)
            $0.height.equalTo(57)
            $0.width.equalTo(163)
        }
        
        monthTextField.snp.makeConstraints {
            $0.top.equalTo(yearTextField)
            $0.leading.equalTo(yearTextField.snp.trailing).offset(11)
            $0.height.equalTo(57)
            $0.width.equalTo(85)
        }
        
        dayTextField.snp.makeConstraints {
            $0.top.equalTo(yearTextField)
            $0.leading.equalTo(monthTextField.snp.trailing).offset(11)
            $0.height.equalTo(57)
            $0.width.equalTo(85)
        }
    }
    
    private func setupKeyboardDismissal() {
        // 키보드가 활성화된 상태에서 화면을 터치했을 때 키보드가 사라지도록 설정합니다.
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func dismissKeyboard() {
        // 키보드를 숨깁니다.
        view.endEditing(true)
    }
}

extension SetBirthViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView {
        case yearPickerView:
            let maxYear = currentYear
            let minYear = 1900
            return maxYear - minYear + 1
        case monthPickerView:
            return 12
        default:
            return 31
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView {
            case yearPickerView:
                let maxYear = currentYear
                let selectedYear = maxYear - row
                return "\(selectedYear)"
            case monthPickerView:
                return String(format: "%02d", row + 1)
            default:
                return String(format: "%02d", row + 1)
            }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView {
            case yearPickerView:
            let maxYear = currentYear
            let selectedYear = maxYear - row
            yearTextField.text = "\(selectedYear)"
            case monthPickerView:
            let month = String(format: "%02d", row + 1)
            monthTextField.text = "\(month)"
            default:
            let day = String(format: "%02d", row + 1)
            dayTextField.text = "\(day)"
            }
    }
}

//MARK: - Extension
extension SetBirthViewController {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor(named: "turquoiseGreen")?.cgColor
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderWidth = 0
        
        guard let yearFilled = yearTextField.text,
              let monthFilled = monthTextField.text,
              let dayFilled = dayTextField.text else {
            continueButton.isEnabled = false
            return
        }
        
        if yearFilled.isEmpty || monthFilled.isEmpty || dayFilled.isEmpty {
            continueButton.isEnabled = false
        } else {
            continueButton.isEnabled = true
            
            let birthDateString = "\(yearFilled)-\(monthFilled)-\(dayFilled)"
            UserDefaults.standard.set(birthDateString, forKey: userDefaultsKey)
            print("Birthdate saved to UserDefaults: \(birthDateString)")
        }
    }

}
