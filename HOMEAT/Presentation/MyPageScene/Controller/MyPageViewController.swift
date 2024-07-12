//
//  MyPageViewController.swift
//  HOMEAT
//
//  Created by 강석호 on 4/1/24.
//

import Foundation
import UIKit
import Then
import Kingfisher
class MyPageViewController: BaseViewController {
    
    // MARK: DummyData
    private let nicknameDummyLabel = UILabel()
    private let profileview = UIView()
    // MARK: Property
    private let mypageTitleLabel = UILabel()
    private let horizonView = UIView()
    private let profileImageView = UIImageView()
    private let sirLabel = UILabel()
    private let infoModifyButton = UIButton()
    private let mypageTableView = UITableView()
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigation()
        setupTableView()
        setTarget()
        updateUser()
    }

    // MARK: UI
    override func setConfigure() {
        view.do {
            $0.backgroundColor = UIColor(r: 30, g: 32, b: 33)
        }
        
        mypageTitleLabel.do {
            $0.text = "마이페이지"
            $0.font = .bodyMedium18
            $0.textColor = .white
        }
        
        horizonView.do {
            $0.backgroundColor = UIColor(r: 54, g: 56, b: 57)
        }
        profileview.do {
            $0.backgroundColor = .turquoiseGreen
            $0.layer.cornerRadius = 40
            $0.layer.borderColor = UIColor.white.cgColor
            $0.layer.borderWidth = 3
            $0.layer.masksToBounds = true
        }
        profileImageView.do {
            $0.image = UIImage(named: "Icon")
            
        }
        
        nicknameDummyLabel.do {
            $0.font = .headBold24
            $0.textColor = .white
        }
        
        sirLabel.do {
            $0.text = "님"
            $0.font = .headBold24
            $0.textColor = .white
        }
        
        infoModifyButton.do {
            $0.setTitle("회원 정보 수정", for: .normal)
            $0.setTitleColor(.white, for: .normal)
            $0.titleLabel?.font = .bodyBold16
            $0.backgroundColor = UIColor(r: 54, g: 56, b: 57)
            $0.layer.cornerRadius = 15
            $0.layer.masksToBounds = true
        }
        
    }
    
    override func setConstraints() {
        
        mypageTableView.isScrollEnabled = false
        
        view.addSubviews(mypageTitleLabel, horizonView,profileview, nicknameDummyLabel, sirLabel, infoModifyButton, mypageTableView)
        profileview.addSubview(profileImageView)
        
        mypageTitleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(62)
        }
        
        horizonView.snp.makeConstraints {
            $0.top.equalTo(mypageTitleLabel.snp.bottom).offset(25)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        profileview.snp.makeConstraints {
            $0.top.equalTo(horizonView.snp.bottom).offset(32)
            $0.leading.equalToSuperview().offset(22)
            $0.width.height.equalTo(90)
        }
        profileImageView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(10)
        }
        nicknameDummyLabel.snp.makeConstraints {
            $0.top.equalTo(horizonView.snp.bottom).offset(38)
            $0.leading.equalTo(profileview.snp.trailing).offset(18)
        }
        
        sirLabel.snp.makeConstraints {
            $0.top.equalTo(horizonView.snp.bottom).offset(38)
            $0.leading.equalTo(nicknameDummyLabel.snp.trailing).offset(2)
        }

        infoModifyButton.snp.makeConstraints {
            $0.top.equalTo(profileview.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(22)
            $0.trailing.equalToSuperview().offset(-22)
            $0.height.equalTo(51)
        }
        
        mypageTableView.snp.makeConstraints {
            $0.top.equalTo(infoModifyButton.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(180)
        }
    }
    
    private func setupTableView() {
        mypageTableView.delegate = self
        mypageTableView.dataSource = self
        mypageTableView.register(MyPageTableViewCell.self, forCellReuseIdentifier: "MyPageTableViewCell")
        
        mypageTableView.separatorStyle = .singleLine
        mypageTableView.separatorColor = UIColor.white
        mypageTableView.separatorInset = .zero
    }
    
    private func setNavigation() {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    private func setTarget() {
        infoModifyButton.addTarget(self, action: #selector(infoModifyButtonTapped), for: .touchUpInside)
    }
    
    @objc private func infoModifyButtonTapped() {
        let userInfoViewController = UserInfoViewController()
        self.navigationController?.pushViewController(userInfoViewController, animated: true)
    }
    @objc func logoutClicked() {
        let alert = UIAlertController(title: nil, message: "로그아웃 하시겠습니까?", preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "예", style: .destructive) { _ in
            self.performLogout()
        }
        let noAction = UIAlertAction(title: "아니오", style: .cancel, handler: nil)
        
        alert.addAction(yesAction)
        alert.addAction(noAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    private func performLogout() {

        NetworkService.shared.myPageService.myPageLogout() { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let data):
                print("연결성공")
                KeychainHandler.shared.accessToken = ""
                let loginViewController = LoginViewController()
                self.navigationController?.pushViewController(loginViewController, animated: true)
            default:
                print("연결실패")
                
            }
            print("User logged out")
        }
    }
    private func updateUser() {
        NetworkService.shared.myPageService.mypage() { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let data):
                guard let data = data.data else { return }
                nicknameDummyLabel.text =  data.nickname
                let url = data.profileImgUrl
                DispatchQueue.main.async {
                    guard let url = URL(string: data.profileImgUrl) else {return}
                    self.profileImageView.kf.setImage(with: url)
                }
                
                print(data)
            default:
                print("서버연동 실패")
                
            }
        }
    }
}


extension MyPageViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyPageTableViewCell", for: indexPath) as! MyPageTableViewCell
        cell.selectionStyle = .none
        switch indexPath.row {
        case 0:
            cell.titleLabel.text = "비밀번호 변경"
        case 1:
            cell.titleLabel.text = "로그아웃"
            cell.arrowButton.isHidden = true
        case 2:
            cell.titleLabel.text = "탈퇴하기"
            cell.arrowButton.isHidden = true
        default:
            break
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let changeViewController = ChangePasswordViewController()
            self.navigationController?.pushViewController(changeViewController, animated: true)
        case 1:
            self.logoutClicked()
        case 2:
            let leaveViewController = LeaveViewController()
            self.navigationController?.pushViewController(leaveViewController, animated: true)
        default:
            break
        }
    }
}
