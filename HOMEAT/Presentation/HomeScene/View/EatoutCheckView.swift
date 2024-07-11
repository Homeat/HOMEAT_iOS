//
//  EatoutCheckView.swift
//  HOMEAT
//
//  Created by 강삼고 on 4/10/24.
//

import Foundation
import UIKit
import SnapKit
import Then

class EatoutCheckView: BaseView {
    
    //MARK: - Property
    private let eatoutIcon = UIImageView()
    private let eatoutTitleLabel = UILabel()
    private let tagButton = UIButton()
    private let expenseLabel = UILabel()
    private let leftMoneyLabel = UILabel()
    private let memoLabel = UILabel()
    
    
    override func setConfigure() {
        self.backgroundColor = UIColor(r: 54, g: 56, b: 57)
        self.clipsToBounds = true
        self.layer.cornerRadius = 10
        
        eatoutIcon.do {
            $0.image = UIImage(named: "eatoutIcon")
        }
        
        eatoutTitleLabel.do {
            $0.text = "배달/외식"
            $0.font = .bodyMedium15
            $0.textColor = .white
        }
        
        tagButton.do {
            $0.setTitle("#외식비", for: .normal)
            $0.layer.cornerRadius = 7
            $0.clipsToBounds = true
            $0.layer.borderWidth = 1
            $0.setTitleColor(UIColor(named: "turquoisePurple"), for: .normal)
            $0.layer.borderColor = UIColor(named: "turquoisePurple")?.cgColor
            $0.titleLabel?.font = UIFont(name: "NotoSansKR-Medium", size: 7.3)
        }
        
        expenseLabel.do {
            $0.text = "79,800 원"
            $0.font = .bodyMedium15
            $0.textColor = UIColor(named: "turquoisePurple")
        }
        
        leftMoneyLabel.do {
            $0.text = "350,000 원"
            $0.font = .captionMedium10
            $0.textColor = .white
        }
        
        memoLabel.do {
            $0.text = "월급기념 부모님과 외식했다."
            $0.font = UIFont(name: "NotoSansKR-Medium", size: 11)
            $0.textColor = UIColor(r: 216, g: 216, b: 216)
        }
    }
    
    override func setConstraints() {
        self.addSubviews(eatoutIcon, eatoutTitleLabel, tagButton, expenseLabel, leftMoneyLabel, memoLabel)
        
        eatoutIcon.snp.makeConstraints {
            $0.top.equalToSuperview().offset(21)
            $0.leading.equalToSuperview().offset(15)
        }
        
        eatoutTitleLabel.snp.makeConstraints {
            $0.centerY.equalTo(eatoutIcon).offset(-1)
            $0.leading.equalTo(eatoutIcon.snp.trailing).offset(11)
        }
        
        tagButton.snp.makeConstraints {
            $0.centerY.equalTo(eatoutTitleLabel)
            $0.leading.equalTo(eatoutTitleLabel.snp.trailing).offset(12)
            $0.height.equalTo(16)
            $0.width.equalTo(43)
        }
        
        expenseLabel.snp.makeConstraints {
            $0.centerY.equalTo(tagButton).offset(-4)
            $0.trailing.equalToSuperview().offset(-17)
        }
        
        memoLabel.snp.makeConstraints {
            $0.top.equalTo(eatoutTitleLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(39)
        }
        
        leftMoneyLabel.snp.makeConstraints {
            $0.top.equalTo(memoLabel.snp.top).offset(-1)
            $0.trailing.equalToSuperview().offset(-17)
        }
    }
}
