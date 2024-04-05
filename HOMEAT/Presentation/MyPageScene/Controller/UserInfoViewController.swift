//
//  UserInfoViewController.swift
//  HOMEAT
//
//  Created by 강석호 on 4/3/24.
//

import Foundation
import UIKit
import Then
import SnapKit

class UserInfoViewController: BaseViewController {
    
    // MARK: DummyData
    private let userDummyData = ["예진", "yejin_woo","yejin_woo@naver.com", "100,000원" ]
    
    // MARK: Property
    private let profileImageView = UIView()
    private let userInfoTableView = UITableView()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigation()
    }
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTapBarHidden()
        setupTableView()
    }
    
    override func setConfigure() {
        view.do {
            $0.backgroundColor = UIColor(r: 30, g: 32, b: 33)
        }
        
        profileImageView.do {
            $0.backgroundColor = .blue
            $0.layer.cornerRadius = 40
            $0.layer.masksToBounds = true
        }
    }
    
    override func setConstraints() {
        
        userInfoTableView.isScrollEnabled = false
        
        view.addSubviews(profileImageView, userInfoTableView)
        
        profileImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(35)
            $0.width.height.equalTo(86)
        }
        
        userInfoTableView.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(240)
        }
    }
    
    private func setNavigation() {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.title = "회원 정보 수정"
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "수정", style: .plain, target: self, action: #selector(editButtonTapped))
        self.navigationItem.rightBarButtonItem?.tintColor = .turquoiseGreen
    }
    
    private func setTapBarHidden() {
        self.hidesBottomBarWhenPushed = true
    }
    
    private func setupTableView() {
        userInfoTableView.delegate = self
        userInfoTableView.dataSource = self
        userInfoTableView.register(UserInfoTableViewCell.self, forCellReuseIdentifier: "UserInfoTableViewCell")
        
        userInfoTableView.separatorStyle = .singleLine
        userInfoTableView.separatorColor = UIColor.white
        userInfoTableView.separatorInset = .zero
    }
    
    @objc private func editButtonTapped() {
        
    }
}

extension UserInfoViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserInfoTableViewCell", for: indexPath) as! UserInfoTableViewCell
        cell.selectionStyle = .none
        switch indexPath.row {
        case 0:
            cell.titleLabel.text = "닉네임"
            cell.descriptionLabel.text = userDummyData[0]
            cell.arrowButton.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
            
        case 1:
            cell.titleLabel.text = "아이디"
            cell.arrowButton.isHidden = true
            cell.descriptionLabel.text = userDummyData[1]
        case 2:
            cell.titleLabel.text = "이메일 주소"
            cell.arrowButton.isHidden = true
            cell.descriptionLabel.text = userDummyData[2]
        case 3:
            cell.titleLabel.text = "한 달 수입"
            cell.descriptionLabel.text = userDummyData[3]
            cell.arrowButton.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        default:
            break
        }
        cell.bringSubviewToFront(cell.arrowButton)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    @objc func buttonClicked(sender: UIButton) {
        let userInfoModifyViewController = UserInfoModifyViewController()
        self.navigationController?.pushViewController(userInfoModifyViewController, animated: true)
    }
}
