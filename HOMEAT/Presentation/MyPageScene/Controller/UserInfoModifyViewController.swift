//
//  UserInfoModifyViewController.swift
//  HOMEAT
//
//  Created by 강석호 on 4/5/24.
//

import Foundation
import UIKit


class UserInfoModifyViewController : BaseViewController {
    
    // MARK: Property
    private let presentNickNameLabel = UILabel()
    private let presentInfoView = PresentInfoView()
    private let checkNickNameLabel = UILabel()
    private let duplicationCheckButton = UIButton()
    private let confirmButton = UIButton()
    private let NickNameField = UITextField()
    
    // MARK: Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setTapBarHidden()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigation()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // MARK: UI
    override func setConfigure() {
        view.do {
            $0.backgroundColor = UIColor(r: 30, g: 32, b: 33)
        }
        
        presentNickNameLabel.do {
            $0.text = "현재 닉네임"
            $0.font = .bodyMedium18
            $0.textColor = .turquoiseGreen
        }
        
        checkNickNameLabel.do {
            $0.text = "변경할 닉네임"
            $0.font = .bodyMedium18
            $0.textColor = .turquoiseGreen
        }
        
        NickNameField.do {
            let attributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: UIColor.gray
            ]
            $0.attributedPlaceholder = NSAttributedString(string: "변경할 닉네임을 작성하세요", attributes: attributes)
            $0.font = .bodyMedium16
            $0.textColor = .white
            $0.layer.cornerRadius = 10
            $0.clipsToBounds = true
            $0.backgroundColor = .coolGray4
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: $0.frame.height))
            $0.leftViewMode = .always
        }
        
        duplicationCheckButton.do {
            $0.setTitle("중복확인", for: .normal)
            $0.setTitleColor(UIColor.black, for: .normal)
            $0.layer.cornerRadius = 10
            $0.layer.masksToBounds = true
            $0.backgroundColor = .white
            $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        confirmButton.do {
            $0.setTitle("변경하기", for: .normal)
            $0.setTitleColor(UIColor.black, for: .normal)
            $0.layer.cornerRadius = 10
            $0.layer.masksToBounds = true
            $0.backgroundColor = .white
            $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
    }
    
    override func setConstraints() {
        
        view.addSubviews(presentNickNameLabel, presentInfoView, checkNickNameLabel, NickNameField,duplicationCheckButton, confirmButton)
        
        presentNickNameLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(35)
            $0.leading.equalToSuperview().offset(20)
        }
        
        presentInfoView.snp.makeConstraints {
            $0.top.equalTo(presentNickNameLabel.snp.bottom).offset(12)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(57)
        }
        
        checkNickNameLabel.snp.makeConstraints {
            $0.top.equalTo(presentInfoView.snp.bottom).offset(35)
            $0.leading.equalToSuperview().offset(20)
        }
        
        NickNameField.snp.makeConstraints {
            $0.top.equalTo(checkNickNameLabel.snp.bottom).offset(12)
            $0.leading.equalToSuperview().offset(20)
            $0.height.equalTo(57)
            $0.width.equalTo(250)
        }
        
        duplicationCheckButton.snp.makeConstraints {
            $0.top.equalTo(checkNickNameLabel.snp.bottom).offset(12)
            $0.leading.equalTo(NickNameField.snp.trailing).offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(57)
        }
        
        confirmButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-32)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(57)
        }
        
    }
    
    private func setNavigation() {
        self.navigationItem.title = "닉네임 변경"
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.tintColor = .white
    }
    
    private func setTapBarHidden() {
        self.tabBarController?.tabBar.isHidden = true
    }
}
