//
//  FinalLeaveViewController.swift
//  HOMEAT
//
//  Created by 김민솔 on 7/8/24.
//

import UIKit

class FinalLeaveViewController: BaseViewController {
    private let checkLabel = UILabel()
    private let contentLabel = UILabel()
    private let logoIcon = UIImageView()
    private let button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        view.backgroundColor = UIColor(r: 30, g: 32, b: 33)

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 커스텀 탭바를 숨깁니다.
        if let tabBarController = self.tabBarController as? HOMEATTabBarController {
            tabBarController.tabBar.isHidden = true
        }
        tabBarController?.tabBar.isTranslucent = true
    }
    //MARK: - setConfigure
    override func setConfigure() {
        let userName = UserDefaults.standard.string(forKey: "userNickname") ?? "사용자"
        let checkText = "\(userName) 님,\n탈퇴하기 전에 확인해주세요"
            logoIcon.do {
                $0.image = UIImage(named: "final")
            }
            
            button.do {
                $0.setTitle("탈퇴하기", for: .normal)
                $0.titleLabel?.font = UIFont.bodyMedium15
                $0.setTitleColor(UIColor.black, for: .normal)
                $0.backgroundColor = UIColor.turquoiseGreen
                $0.layer.cornerRadius = 10
                $0.layer.masksToBounds = true
                $0.addTarget(self, action: #selector(tappedLeave), for: .touchUpInside)
            }
            
            checkLabel.do {
                $0.text = checkText
                $0.textColor = .white
                $0.textAlignment = .left
                $0.font = UIFont.bodyBold18
                $0.numberOfLines = 0
                $0.textAlignment = .center
            }
            
            contentLabel.do {
                $0.text = "Homeat에서 관리했던\n회원님의 모든 개인정보를 다시 볼 수 없어요."
                $0.textColor = .white
                $0.font = UIFont.bodyMedium15
                $0.numberOfLines = 0
                $0.textAlignment = .left
            }
        }
    
    override func setConstraints() {
        view.addSubviews(logoIcon,button,checkLabel,contentLabel)
        logoIcon.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        button.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(50)
            $0.height.equalTo(60)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        checkLabel.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.leading.equalTo(10)
            
        }
        contentLabel.snp.makeConstraints {
            $0.top.equalTo(checkLabel.snp.bottom).offset(20)
            $0.leading.equalTo(checkLabel.snp.leading)
        }
    }
    @objc private func tappedLeave() {
        updateServer()
        let nextVC = LoginViewController()
        navigationController?.pushViewController(nextVC, animated: true)
    }
    private func updateServer() {
        NetworkService.shared.myPageService.myPageWithDraw() { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let data):
                print("탈퇴 하기")
            default:
                print("탈퇴 실패")
                
            }
        }
    }
    private func setNavigationBar() {
        self.navigationItem.title = "탈퇴하기"
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.tintColor = .white
    }
    
}

