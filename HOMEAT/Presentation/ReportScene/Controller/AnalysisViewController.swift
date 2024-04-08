//
//  AnalysisViewController.swift
//  HOMEAT
//
//  Created by 김민솔 on 4/3/24.
// 소비분석 UI

import UIKit
import Then
import SnapKit
import Charts

//MARK: - Property
private let scrollView = UIScrollView()
private let contentView = UIView()
private let deliveryImage = UIImageView()
private let mealImage = UIImageView()
private let deliveryLabel = UILabel()
private let mealLabel = UILabel()
private let monthView = MonthView()
private let ageButton = UIButton()
private let incomeMoneyButton = UIButton()
private let weakView = WeakView()

class AnalysisViewController: BaseViewController {
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setConfigure()
    }
    
    override func setConfigure() {
        view.do {
            $0.backgroundColor = UIColor(r: 30, g: 32, b: 33)
        }
        
        deliveryImage.do {
            $0.image = UIImage(named: "deliveryLogo")
            $0.contentMode = .scaleAspectFit
            $0.clipsToBounds = true
        }
        
        mealImage.do {
            $0.image = UIImage(named: "homefoodLogo")
            $0.contentMode = .scaleAspectFit
            $0.clipsToBounds = true
        }
        
        deliveryLabel.do {
            $0.text = "외식/배달"
            $0.textColor = .black
            $0.textAlignment = .center
            $0.layer.cornerRadius = 2
            $0.layer.masksToBounds = true
            $0.font = .captionMedium10
            $0.backgroundColor = UIColor(named: "turquoisePurple")
        }
        
        mealLabel.do {
            $0.text = "집밥"
            $0.textColor = .black
            $0.textAlignment = .center
            $0.layer.cornerRadius = 2
            $0.layer.masksToBounds = true
            $0.font = .captionMedium10
            $0.backgroundColor = UIColor(named: "turquoiseGreen")
        }
        
        monthView.do {
            $0.layer.cornerRadius = 14
            $0.layer.masksToBounds = true
            $0.backgroundColor = UIColor(named: "turquoiseGray")
        }
        
        ageButton.do {
            $0.setTitle("20대 초반", for: .normal)
            $0.layer.cornerRadius = 16
            $0.clipsToBounds = true
            $0.setTitleColor(UIColor(named: "turquoiseGreen"), for: .normal)
            $0.layer.borderColor = UIColor(named: "turquoiseGreen")?.cgColor
            $0.layer.borderWidth = 1.6
            $0.titleLabel?.font = .captionMedium13
        }
        
        incomeMoneyButton.do {
            $0.setTitle("소득 100만원 이하", for: .normal)
            $0.layer.cornerRadius = 16.3
            $0.clipsToBounds = true
            $0.setTitleColor(UIColor(named: "turquoiseGreen"), for: .normal)
            $0.layer.borderColor = UIColor(named: "turquoiseGreen")?.cgColor
            $0.layer.borderWidth = 1.6
            $0.titleLabel?.font = .captionMedium13
        }
        
        weakView.do {
            $0.layer.cornerRadius = 14
            $0.layer.masksToBounds = true
            $0.backgroundColor = UIColor(named: "turquoiseGray")
        }
    }
    
    override func setConstraints() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubviews(deliveryImage,deliveryLabel,mealImage,mealLabel,monthView,ageButton,incomeMoneyButton,weakView)
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(40)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalTo(scrollView.frameLayoutGuide)
            $0.height.equalTo(1130)
        }
        
        deliveryImage.snp.makeConstraints {
            $0.width.equalTo(15)
            $0.top.equalTo(deliveryLabel.snp.top)
            $0.bottom.equalTo(deliveryLabel.snp.bottom)
            $0.leading.equalToSuperview().inset(302)
        }
        
        deliveryLabel.snp.makeConstraints {
            $0.height.equalTo(15)
            $0.top.equalToSuperview().inset(20)
            $0.leading.equalTo(deliveryImage.snp.trailing).offset(6)
            $0.trailing.equalToSuperview().inset(21)
        }
        
        mealImage.snp.makeConstraints {
            $0.width.equalTo(15)
            $0.top.equalTo(mealLabel.snp.top)
            $0.bottom.equalTo(mealLabel.snp.bottom)
            $0.leading.equalTo(deliveryImage.snp.leading)
        }
        
        mealLabel.snp.makeConstraints {
            $0.height.equalTo(15)
            $0.top.equalTo(deliveryLabel.snp.bottom).offset(9)
            $0.leading.equalTo(deliveryLabel.snp.leading)
            $0.trailing.equalToSuperview().inset(21)
        }
        
        monthView.snp.makeConstraints {
            $0.height.equalTo(345)
            $0.top.equalTo(mealImage.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(19)
        }
        
        ageButton.snp.makeConstraints {
            $0.top.equalTo(monthView.snp.bottom).offset(46)
            $0.leading.equalToSuperview().inset(21)
            $0.width.equalTo(81.7)
            $0.height.equalTo(31.1)
        }
        
        incomeMoneyButton.snp.makeConstraints {
            $0.top.equalTo(ageButton.snp.top)
            $0.leading.equalTo(ageButton.snp.trailing).offset(11.7)
            $0.width.equalTo(120.6)
            $0.height.equalTo(31.1)
        }
        
        weakView.snp.makeConstraints {
            $0.top.equalTo(ageButton.snp.bottom).offset(18.9)
            $0.leading.trailing.equalToSuperview().inset(19)
            $0.height.equalTo(570)
            
        }
    }
}
