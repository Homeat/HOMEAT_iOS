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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateProgressBar(progress: 6/6)
        setTitleLabel(title: "한 주 목표 식비는\n얼마인가요?")
        setSubTitleLabel(subtitle: "외식, 배달비 모두 포함이에요!")
        setDetailLabel(detail: "한 주 목표 식비")
    }
    
    override func setConfigure() {
        super.setConfigure()
    
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
}

extension SetExpenseViewController {
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
