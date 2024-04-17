//
//  WelcomeView.swift
//  HOMEAT
//
//  Created by 강석호 on 4/17/24.
//

import Foundation
import UIKit
import Then
import SnapKit

final class WelcomeView: BaseView {
    
    private let prepositionLabel = UILabel()
    private let backgroundView = UIView()
    private let homeatTextLogo = UIImageView()
    private let welcomeLabel = UILabel()
    private let logoStackView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func setConfigure() {
        backgroundView.do {
            $0.backgroundColor = .coolGray4
            $0.layer.cornerRadius = 10
        }
        
        prepositionLabel.do {
            $0.text = "에"
            $0.font = .headMedium28
            $0.textColor = .white
            $0.sizeToFit()
        }
        
        homeatTextLogo.do {
            $0.image = UIImage(named: "homeatTextLogo")
            $0.snp.makeConstraints {
                $0.width.equalTo(158)
                $0.height.equalTo(27)
            }
        }
        
        welcomeLabel.do {
            $0.text = "오신 것을 환영합니다!"
            $0.font = .headMedium28
            $0.textColor = .white
        }
        
        logoStackView.do {
            $0.axis = .horizontal
            $0.spacing = 5
            $0.alignment = .center
        }
        
        logoStackView.addArrangedSubview(homeatTextLogo)
        logoStackView.addArrangedSubview(prepositionLabel)
        
    }
    
    override func setConstraints() {
        
        addSubviews(backgroundView, welcomeLabel, logoStackView)
        
        backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        logoStackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(8)
        }
        
        welcomeLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(homeatTextLogo.snp.bottom).offset(15)
        }
        
    }
}
