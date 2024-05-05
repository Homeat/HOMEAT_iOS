//
//  FoodPostViewController.swift
//  HOMEAT
//
//  Created by 이지우 on 5/5/24.
//

import UIKit
import Then
import SnapKit

class FoodPostViewController: BaseViewController {
    
    //MARK: - Property
    private let profileIcon = UIImageView()
    private let userName = UILabel()
    private let dateLabel = UILabel()
    private let declareButton = UIButton()
    private let hashtagButton = UIButton()
    private let titleLabel = UILabel()
    private let contentLabel = UILabel()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        setAddTarget()
    }
    
    //MARK: - SetUI
    override func setConfigure() {
        view.do {
            $0.backgroundColor = UIColor(r: 30, g: 32, b: 33)
        }
        
        profileIcon.do {
            $0.backgroundColor = UIColor(named: "turquoiseGreen")
            $0.image = UIImage(named: "profileIcon")
            $0.layer.cornerRadius = 20
            $0.layer.borderWidth = 1.3
            $0.layer.borderColor = UIColor.white.cgColor
            $0.contentMode = .scaleAspectFit
        }
        
        userName.do {
            $0.text = "사용자이름"
            $0.font = .bodyMedium15
            $0.textColor = .white
        }
        
        dateLabel.do {
            $0.text = "mm월 dd일 12:00"
            $0.font = .captionMedium10
            $0.textColor = .warmgray8
        }
        
        declareButton.do {
            $0.setTitle("신고하기", for: .normal)
            $0.setTitleColor(UIColor(named: "warmgray8"), for: .normal)
            $0.titleLabel?.font = .captionMedium10
        }
        
        
    }
    
    override func setConstraints() {
        
        view.addSubviews(profileIcon, userName, dateLabel, declareButton)
        
        profileIcon.snp.makeConstraints {
            $0.top.equalToSuperview().inset(115)
            $0.leading.equalToSuperview().inset(20)
            $0.width.equalTo(37.8)
            $0.height.equalTo(37.8)
        }
        
        userName.snp.makeConstraints {
            $0.top.equalTo(profileIcon.snp.top)
            $0.leading.equalTo(profileIcon.snp.trailing).offset(11.2)
            $0.height.equalTo(22)
        }
        
        dateLabel.snp.makeConstraints {
            $0.leading.equalTo(userName.snp.leading)
            $0.bottom.equalTo(profileIcon.snp.bottom)
            $0.height.equalTo(14)
        }
        
        declareButton.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.top)
            $0.bottom.equalTo(dateLabel.snp.bottom)
            $0.trailing.equalToSuperview().inset(20)
        }
    }
    
    private func setNavigationBar() {
        navigationItem.title = "집밥토크"
        let backbutton = UIBarButtonItem()
        backbutton.tintColor = .white
        navigationController?.navigationBar.topItem?.backBarButtonItem = backbutton
    }
    
    //MARK: - SetButtonAction
    private func setAddTarget() {
        declareButton.addTarget(self, action: #selector(declareButtonTapped), for: .touchUpInside)
    }
    
    //MARK: - @objc
    @objc func declareButtonTapped() {
        let delcareVC = DeclareViewController()
        navigationController?.pushViewController(delcareVC, animated: true)
    }
    
}
