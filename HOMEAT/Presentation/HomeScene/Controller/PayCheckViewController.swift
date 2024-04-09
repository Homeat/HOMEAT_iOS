//
//  PayCheckViewController.swift
//  HOMEAT
//
//  Created by 강삼고 on 4/3/24.
//

import UIKit
import SnapKit
import Then

class PayCheckViewController : BaseViewController {
    
    //MARK: - Property
    private let eatoutIcon = UIImageView()
    private let homefoodIcon = UIImageView()
    private let eatoutTitleLabel = UILabel()
    private let homefoodTitleLabel = UILabel()
    private let calenderView = CalenderView()
    private let payCheckView = PayCheckView()
    private let checkDetailButton = UIButton()
    
    //MARK: - Function
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        setAddTarget()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setNavigationBar()
    }
    
    //MARK: - setConfigure
    override func setConfigure() {
        view.backgroundColor = UIColor(named: "homeBackgroundColor")
        
        eatoutIcon.do {
            $0.image = UIImage(named: "eatoutIcon")
        }
        
        homefoodIcon.do {
            $0.image = UIImage(named: "homefoodIcon")
        }
        
        eatoutTitleLabel.do {
            $0.text = "외식/배달"
            $0.font = UIFont(name: "NotoSansKR-Bold", size: 10)
            $0.textColor = UIColor(r: 30, g: 32, b: 33)
            $0.textAlignment = .center
            $0.layer.cornerRadius = 2
            $0.clipsToBounds = true
            $0.backgroundColor = UIColor(r: 157, g: 110, b: 255)
        }
        
        homefoodTitleLabel.do {
            $0.text = "집밥"
            $0.font = UIFont(name: "NotoSansKR-Bold", size: 10)
            $0.textColor = UIColor(r: 30, g: 32, b: 33)
            $0.textAlignment = .center
            $0.layer.cornerRadius = 2
            $0.clipsToBounds = true
            $0.backgroundColor = UIColor(named: "turquoiseGreen")
        }
        
        checkDetailButton.do {
            $0.setTitle("세부 확인", for: .normal)
            $0.titleLabel?.font = .bodyBold15
        }
    }
    
    //MARK: - setConstraints
    override func setConstraints() {
        view.addSubviews(eatoutIcon, homefoodIcon, eatoutTitleLabel, homefoodTitleLabel, calenderView, payCheckView, checkDetailButton)
        
        eatoutIcon.snp.makeConstraints {
            $0.top.equalToSuperview().offset(116)
            $0.trailing.equalToSuperview().offset(-77)
        }
        
        homefoodIcon.snp.makeConstraints {
            $0.top.equalTo(eatoutIcon.snp.bottom).offset(9)
            $0.trailing.equalTo(eatoutIcon)
        }
        
        eatoutTitleLabel.snp.makeConstraints {
            $0.top.equalTo(eatoutIcon)
            $0.leading.equalTo(eatoutIcon.snp.trailing).offset(6)
            $0.trailing.equalToSuperview().offset(-21)
        }
        
        homefoodTitleLabel.snp.makeConstraints {
            $0.top.equalTo(homefoodIcon)
            $0.leading.equalTo(homefoodIcon.snp.trailing).offset(6)
            $0.trailing.equalToSuperview().offset(-21)
        }
        
        calenderView.snp.makeConstraints {
            $0.top.equalTo(homefoodIcon.snp.bottom).offset(17)
            $0.leading.equalToSuperview().offset(19)
            $0.trailing.equalToSuperview().offset(-18)
            $0.height.equalTo(345)
        }
        
        payCheckView.snp.makeConstraints {
            $0.top.equalTo(calenderView.snp.bottom).offset(33)
            $0.leading.equalTo(calenderView)
            $0.trailing.equalTo(calenderView)
            $0.bottom.equalToSuperview().offset(-200)
        }
        
        checkDetailButton.snp.makeConstraints {
            $0.top.equalTo(payCheckView)
            $0.trailing.equalTo(payCheckView)
            $0.height.equalTo(30)
            $0.width.equalTo(60)
        }
        
    }
    
    private func setNavigationBar() {
        self.navigationItem.title = "지출확인"
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.tintColor = .white
    }
    
    private func setAddTarget() {
        checkDetailButton.addTarget(self, action: #selector(checkDetailButtonTapped), for: .touchUpInside)
    }
    
    //MARK: - @objc Func
    @objc func checkDetailButtonTapped(_ sender: UIButton) {
        self.navigationController?.pushViewController(PayCheckDetailViewController(), animated: true)
    }

}
