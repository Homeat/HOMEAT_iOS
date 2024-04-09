//
//  PayCheckView.swift
//  HOMEAT
//
//  Created by 강삼고 on 4/10/24.
//

import Foundation
import UIKit
import SnapKit
import Then

class PayCheckView: BaseView {
    
    //MARK: - Property
    private let dateLabel = UILabel()
    private let homefoodIcon = UIImageView()
    private let eatoutIcon = UIImageView()
    private let leftMoneyIcon = UIImageView()
    private let homefoodLineView = UIView()
    private let eatoutLineView = UIView()
    private let leftMoneyLineView = UIView()
    private let homefoodTitleLabel = UILabel()
    private let eatoutTitleLabel = UILabel()
    private let leftMoneyTitleLabel = UILabel()
    private let homefoodSpentLabel = UILabel()
    private let eatoutSpentLabel = UILabel()
    private let leftMoneyAmountLabel = UILabel()
    
    override func setConfigure() {
        self.backgroundColor = UIColor(named: "homeBackgroundColor")
        
        dateLabel.do {
            $0.text = "11월 1일 수요일"
            $0.textColor = .white
            $0.textAlignment = .center
            $0.font = .bodyBold15
        }
        eatoutIcon.do {
            $0.image = UIImage(named: "eatoutIcon")
        }
        
        homefoodIcon.do {
            $0.image = UIImage(named: "homefoodIcon")
        }
        
        leftMoneyIcon.do {
            $0.image = UIImage(named: "leftMoneyIcon")
        }
        
        homefoodLineView.do {
            $0.backgroundColor = UIColor(named: "turquoiseGreen")
            $0.layer.cornerRadius = 3
            $0.clipsToBounds = true
        }
        
        eatoutLineView.do {
            $0.backgroundColor = UIColor(r: 157, g: 110, b: 255)
            $0.layer.cornerRadius = 3
            $0.clipsToBounds = true
        }
        
        leftMoneyLineView.do {
            $0.backgroundColor = UIColor(r: 216, g: 216, b: 216)
            $0.layer.cornerRadius = 3
            $0.clipsToBounds = true
        }
        
        homefoodTitleLabel.do {
            $0.text = "집밥"
            $0.font = .bodyMedium15
            $0.textColor = .white
        }
        
        eatoutTitleLabel.do {
            $0.text = "배달/외식"
            $0.font = .bodyMedium15
            $0.textColor = .white
        }
        
        leftMoneyTitleLabel.do {
            $0.text = "남은 금액"
            $0.font = .bodyMedium15
            $0.textColor = .white
        }
        
        homefoodSpentLabel.do {
            $0.text = "23,800원"
            $0.font = .bodyMedium15
            $0.textColor = UIColor(named: "turquoiseGreen")
        }
        
        eatoutSpentLabel.do {
            $0.text = "79,800원"
            $0.font = .bodyMedium15
            $0.textColor = UIColor(r: 157, g: 110, b: 255)
        }
        
        leftMoneyAmountLabel.do {
            $0.text = "350,000원"
            $0.font = .bodyMedium15
            $0.textColor = .white
        }
    }
    
    override func setConstraints() {
        self.addSubviews(dateLabel, homefoodIcon, eatoutIcon, leftMoneyIcon, homefoodLineView, eatoutLineView, leftMoneyLineView, homefoodTitleLabel, eatoutTitleLabel, leftMoneyTitleLabel, homefoodSpentLabel, eatoutSpentLabel, leftMoneyAmountLabel)
        
        dateLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
        }
        
        homefoodIcon.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(5)
        }
        
        eatoutIcon.snp.makeConstraints {
            $0.top.equalTo(homefoodIcon.snp.bottom).offset(14)
            $0.leading.equalTo(homefoodIcon).offset(-1)
        }
        
        leftMoneyIcon.snp.makeConstraints {
            $0.top.equalTo(eatoutIcon.snp.bottom).offset(10)
            $0.leading.equalTo(eatoutIcon).offset(-1)
        }
        
        homefoodLineView.snp.makeConstraints {
            $0.centerY.equalTo(homefoodIcon)
            $0.leading.equalTo(homefoodIcon.snp.trailing).offset(7)
            $0.height.equalTo(18)
            $0.width.equalTo(4)
        }
        
        eatoutLineView.snp.makeConstraints {
            $0.centerY.equalTo(eatoutIcon)
            $0.leading.equalTo(homefoodLineView)
            $0.height.equalTo(18)
            $0.width.equalTo(4)
        }
        
        leftMoneyLineView.snp.makeConstraints {
            $0.centerY.equalTo(leftMoneyIcon)
            $0.leading.equalTo(eatoutLineView)
            $0.height.equalTo(18)
            $0.width.equalTo(4)
        }
        
        homefoodTitleLabel.snp.makeConstraints {
            $0.centerY.equalTo(homefoodLineView).offset(-1)
            $0.leading.equalTo(homefoodLineView.snp.trailing).offset(7)
        }
        
        eatoutTitleLabel.snp.makeConstraints {
            $0.centerY.equalTo(eatoutLineView).offset(-1)
            $0.leading.equalTo(homefoodTitleLabel)
        }
        
        leftMoneyTitleLabel.snp.makeConstraints {
            $0.centerY.equalTo(leftMoneyLineView).offset(-1)
            $0.leading.equalTo(eatoutTitleLabel)
        }
        
        homefoodSpentLabel.snp.makeConstraints {
            $0.centerY.equalTo(homefoodTitleLabel)
            $0.trailing.equalToSuperview()
        }
        
        homefoodSpentLabel.snp.makeConstraints {
            $0.centerY.equalTo(homefoodTitleLabel).offset(-4)
            $0.trailing.equalToSuperview()
        }
        
        eatoutSpentLabel.snp.makeConstraints {
            $0.centerY.equalTo(eatoutTitleLabel).offset(-2)
            $0.trailing.equalToSuperview()
        }
        
        leftMoneyAmountLabel.snp.makeConstraints {
            $0.centerY.equalTo(leftMoneyTitleLabel).offset(-2)
            $0.trailing.equalToSuperview()
        }
    }
}
