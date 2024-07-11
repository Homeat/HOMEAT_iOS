//
//  FinishIncomeViewController.swift
//  HOMEAT
//
//  Created by 김민솔 on 7/11/24.
//

import UIKit
import SnapKit
import Then

class FinishIncomeViewController : BaseViewController {
    
    //MARK: - Property
    private let titleLabel = UILabel()
    private let messageLabel = UILabel()
    private let backButton = UIButton()
    private let doneIcon = UIImageView()
    
    //MARK: - Function
    override func viewDidLoad() {
        super.viewDidLoad()
        setAddTarget()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setTapBarHidden()
        
    }
    
    // MARK: - setConfigure
    override func setConfigure() {
        view.backgroundColor = UIColor(named: "homeBackgroundColor")
        self.navigationItem.hidesBackButton = true
        
        titleLabel.do {
            $0.text = StringLiterals.Home.editDone.title
            $0.font = .bodyMedium18
            $0.textColor = .white
        }
        
        messageLabel.do {
            $0.text = "수입 변경이 완료되었습니다."
            $0.font = .headBold24
            $0.textColor = .white
        }
        
        doneIcon.do {
            $0.image = UIImage(named: "editDoneIcon")
        }
        
        backButton.do {
            $0.backgroundColor = UIColor(r: 216, g: 216, b: 216)
            $0.titleLabel?.font = .bodyBold18
            $0.setTitle(StringLiterals.Home.editDone.button, for: .normal)
            $0.setTitleColor(.black, for: .normal)
            $0.layer.cornerRadius = 10
            $0.clipsToBounds = true
        }
    }
    
    //MARK: - setConstraints
    override func setConstraints() {
        view.addSubviews(titleLabel, doneIcon, messageLabel, backButton)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(62)
            $0.centerX.equalToSuperview()
        }
        
        doneIcon.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(150)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(129)
            $0.height.equalTo(129)
        }
        
        messageLabel.snp.makeConstraints {
            $0.top.equalTo(doneIcon.snp.bottom).offset(45)
            $0.centerX.equalToSuperview()
        }
        
        backButton.snp.makeConstraints {
            $0.top.equalTo(messageLabel.snp.bottom).offset(279)
            $0.centerX.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(57)
        }
    }
    
    private func setTapBarHidden() {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    //MARK: - setButtonAction
    private func setAddTarget() {
        backButton.addTarget(self, action: #selector(isBackButtonTapped), for: .touchUpInside)
    }
    
    //MARK: - @objc Func
    @objc func isBackButtonTapped(_ sender: Any) {
        let myPageVC = MyPageViewController()
        self.navigationController?.pushViewController(myPageVC, animated: true)
    }
}
