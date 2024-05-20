//
//  SetNicknameViewController.swift
//  HOMEAT
//
//  Created by 강삼고 on 5/8/24.
//

import Foundation
import UIKit
import Then
import SnapKit

class SetNicknameViewController: ProgressViewController {
    
    private let nameTextField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateProgressBar(progress: 1/6)
        setTitleLabel(title: "사용할 닉네임을\n입력해주세요!")
        setDetailLabel(detail: "닉네임")
        setNextVC(nextVC: SetBirthViewController())
        setNavigationBar()
    }
    
    override func setConfigure() {
        super.setConfigure()
    
        nameTextField.do {
            $0.backgroundColor = UIColor(r: 54, g: 56, b: 57)
            $0.makeCornerRound(radius: 10)
            let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 18, height: $0.frame.height))
            $0.leftView = leftPaddingView
            $0.leftViewMode = .always
            $0.delegate = self
        }

    }
    
    override func setConstraints() {
        super.setConstraints()
        view.addSubviews(nameTextField)
        
        nameTextField.snp.makeConstraints {
            $0.top.equalToSuperview().offset(369)
            $0.leading.equalToSuperview().offset(20)
            $0.height.equalTo(57)
            $0.trailing.equalToSuperview().offset(-20)
        }
    }
}
