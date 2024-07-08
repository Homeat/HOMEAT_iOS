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
    // MARK: Property
    private let profileImageView = UIImageView()
    private let userInfoTableView = UITableView()
    var nickName: String?
    var emailAdress: String?
    var incom: Int = 0
    // MARK: - 탭바제거
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isTranslucent = true
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isTranslucent = false
        self.tabBarController?.tabBar.isHidden = false
    }
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setTapBarHidden()
        setupTableView()
        updateMyInfo()
        setNavigation()
    }
    
    override func setConfigure() {
        view.do {
            $0.backgroundColor = UIColor(r: 30, g: 32, b: 33)
        }
        
        profileImageView.do {
            $0.backgroundColor = .turquoiseGreen
            $0.layer.borderColor = UIColor.white.cgColor
            $0.layer.borderWidth = 3
            $0.layer.cornerRadius = 30
            $0.layer.masksToBounds = true
        }
    }
    
    override func setConstraints() {
        
        userInfoTableView.isScrollEnabled = false
        
        view.addSubviews(profileImageView, userInfoTableView)
        
        profileImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(35)
            $0.width.height.equalTo(140)
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
        
        self.tabBarController?.tabBar.isHidden = true
    }
    
    private func setupTableView() {
        userInfoTableView.delegate = self
        userInfoTableView.dataSource = self
        userInfoTableView.register(UserInfoTableViewCell.self, forCellReuseIdentifier: "UserInfoTableViewCell")
        
        userInfoTableView.separatorStyle = .singleLine
        userInfoTableView.separatorColor = UIColor.white
        userInfoTableView.separatorInset = .zero
    }
    private func updateMyInfo() {
        NetworkService.shared.myPageService.mypageDetail() { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let data):
                guard let data = data.data else { return }
                let url = data.profileImgUrl
                DispatchQueue.main.async {
                    guard let url = URL(string: data.profileImgUrl) else {return}
                    self.profileImageView.kf.setImage(with: url)
                    
                }
                self.nickName = data.nickname
                self.emailAdress = data.email
                self.incom = data.income
                DispatchQueue.main.async {
                    self.userInfoTableView.reloadData()
                }
                print(data)
            default:
                print("서버연동 실패")
                
            }
        }
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
            cell.descriptionLabel.text = nickName
            cell.arrowButton.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
            
        case 1:
            cell.titleLabel.text = "아이디"
            cell.arrowButton.isHidden = true
            cell.descriptionLabel.text = ""
        case 2:
            cell.titleLabel.text = "이메일 주소"
            cell.arrowButton.isHidden = true
            cell.descriptionLabel.text = emailAdress
        case 3:
            cell.titleLabel.text = "한 달 수입"
            cell.descriptionLabel.text = String(incom)
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
