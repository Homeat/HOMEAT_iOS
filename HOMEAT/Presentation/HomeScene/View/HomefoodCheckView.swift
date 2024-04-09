//
//  HomefoodCheckView.swift
//  HOMEAT
//
//  Created by 강삼고 on 4/10/24.
//

import Foundation
import UIKit
import SnapKit
import Then

class HomefoodCheckView: BaseView {
    
    //MARK: - Property
    private let homefoodIcon = UIImageView()
    private let homefoodTitleLabel = UILabel()
    private let tagButton = UIButton()
    private let expenseLabel = UILabel()
    private let leftMoneyLabel = UILabel()
    private let memoLabel = UILabel()
    
    
    override func setConfigure() {
        self.backgroundColor = UIColor(r: 54, g: 56, b: 57)
        self.clipsToBounds = true
        self.layer.cornerRadius = 10
        
        homefoodIcon.do {
            $0.image = UIImage(named: "homefoodIcon")
        }
        
        homefoodTitleLabel.do {
            $0.text = "집밥"
            $0.font = .bodyMedium15
            $0.textColor = .white
        }
        
        tagButton.do {
            $0.setTitle("#장보기", for: .normal)
            $0.layer.cornerRadius = 7
            $0.clipsToBounds = true
            $0.layer.borderWidth = 1
            $0.setTitleColor(UIColor(named: "turquoiseGreen"), for: .normal)
            $0.layer.borderColor = UIColor(named: "turquoiseGreen")?.cgColor
            $0.titleLabel?.font = UIFont(name: "NotoSansKR-Medium", size: 7.3)
        }
        
        expenseLabel.do {
            $0.text = "23,800 원"
            $0.font = .bodyMedium15
            $0.textColor = UIColor(named: "turquoiseGreen")
        }
        
        leftMoneyLabel.do {
            $0.text = "429,800 원"
            $0.font = .captionMedium10
            $0.textColor = .white
        }
        
        memoLabel.do {
            $0.text = "참치김치찌개를 하기 위해 장을 봤다.\n참치김치찌개를 하기 위해 장을 봤다."
            $0.numberOfLines = 2
            $0.font = UIFont(name: "NotoSansKR-Medium", size: 11)
            $0.textColor = UIColor(r: 216, g: 216, b: 216)
        }
    }
    
    override func setConstraints() {
        self.addSubviews(homefoodIcon, homefoodTitleLabel, tagButton, expenseLabel, leftMoneyLabel, memoLabel)
        
        homefoodIcon.snp.makeConstraints {
            $0.top.equalToSuperview().offset(21)
            $0.leading.equalToSuperview().offset(15)
        }
        
        homefoodTitleLabel.snp.makeConstraints {
            $0.centerY.equalTo(homefoodIcon).offset(-1)
            $0.leading.equalTo(homefoodIcon.snp.trailing).offset(11)
        }
        
        tagButton.snp.makeConstraints {
            $0.centerY.equalTo(homefoodTitleLabel)
            $0.leading.equalTo(homefoodTitleLabel.snp.trailing).offset(12)
            $0.height.equalTo(16)
            $0.width.equalTo(43)
        }
        
        expenseLabel.snp.makeConstraints {
            $0.centerY.equalTo(tagButton).offset(-4)
            $0.trailing.equalToSuperview().offset(-17)
        }
        
        memoLabel.snp.makeConstraints {
            $0.top.equalTo(homefoodTitleLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(39)
        }
        
        leftMoneyLabel.snp.makeConstraints {
            $0.top.equalTo(memoLabel.snp.top).offset(-1)
            $0.trailing.equalToSuperview().offset(-17)
        }
    }
}
