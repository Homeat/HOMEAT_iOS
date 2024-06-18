//
//  SetGenderViewController.swift
//  HOMEAT
//
//  Created by 강삼고 on 5/25/24.
//

import Foundation
import UIKit
import Then
import SnapKit

class SetGenderViewController: ProgressViewController {
    
    private let maleButton = UIButton()
    private let femaleButton = UIButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateProgressBar(progress: 3/6)
        setTitleLabel(title: "성별을\n선택해주세요.")
        setNextVC(nextVC: SetDistrictViewController())
        setAddTaget()
    }
    
    override func setConfigure() {
        super.setConfigure()
        
        maleButton.do {
            var config = UIButton.Configuration.plain()
            var attributedTitle = AttributedString("남")
            attributedTitle.font = .headBold24
            config.attributedTitle = attributedTitle
            config.cornerStyle = .small
            config.background.backgroundColor = UIColor(r: 54, g: 56, b: 57)
            config.baseForegroundColor = .white
            config.background.strokeWidth = 2
            $0.configuration = config
            $0.configurationUpdateHandler = { button in
                switch button.state {
                case .selected:
                    button.configuration?.background.strokeColor = UIColor(named: "turquoiseGreen")
                default:
                    button.configuration?.background.strokeColor = UIColor(r: 83, g: 85, b: 86)
                }
            }
        }
        
        femaleButton.do {
            var config = UIButton.Configuration.plain()
            var attributedTitle = AttributedString("여")
            attributedTitle.font = .headBold24
            config.attributedTitle = attributedTitle
            config.cornerStyle = .small
            config.background.backgroundColor = UIColor(r: 54, g: 56, b: 57)
            config.baseForegroundColor = .white
            config.background.strokeColor = UIColor(r: 83, g: 85, b: 86)
            config.background.strokeWidth = 2
            $0.configuration = config
            $0.configurationUpdateHandler = { button in
                switch button.state {
                case .selected:
                    button.configuration?.background.strokeColor = UIColor(named: "turquoiseGreen")
                    self.continueButton.isEnabled = true
                default:
                    button.configuration?.background.strokeColor = UIColor(r: 83, g: 85, b: 86)
                }
            }
        }
    }
    
    override func setConstraints() {
        super.setConstraints()
        view.addSubviews(maleButton, femaleButton)
        
        maleButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(344)
            $0.leading.equalToSuperview().offset(20)
            $0.height.equalTo(96)
            $0.width.equalTo(166)
        }
        
        femaleButton.snp.makeConstraints {
            $0.top.equalTo(maleButton)
            $0.leading.equalTo(maleButton.snp.trailing).offset(21)
            $0.height.equalTo(96)
            $0.width.equalTo(166)
        }
    }
    
    private func setAddTaget() {
        maleButton.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        femaleButton.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
    }
    
    private func setContinueButtonState() {
        if femaleButton.isSelected || maleButton.isSelected {
            continueButton.isEnabled = true
        }else {
            continueButton.isEnabled = false
        }
    }
    
    //MARK: - @objc Func
    @objc func buttonClicked(_ sender: UIButton) {
        sender.isSelected.toggle()
        if sender == maleButton {
            femaleButton.isSelected = false
        }else{
            maleButton.isSelected = false
        }
        setContinueButtonState()
    }
}
