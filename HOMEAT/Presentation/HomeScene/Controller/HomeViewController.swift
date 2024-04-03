//
//  ViewController.swift
//  HOMEAT
//
//  Created by 강석호 on 3/27/24.
//

import UIKit
import SnapKit
import Then

class HomeViewController: BaseViewController, HomeViewDelegate {
    
    //MARK: - Component
    private let HomeatLogo = UIImageView()
    private let welcomeLabel = UILabel()
    private let savingLabel = UILabel()
    private let payAddButton = UIButton()
    private let payCheckButton = UIButton()
    private let mainView = HomeView()
    private let editAlert = UIAlertController(title: "", message: "", preferredStyle: .alert)
    //MARK: - Function
    override func viewDidLoad() {
        super.viewDidLoad()
        setAddTarget()
        //delegate 설정
        mainView.delegate = self
    }
    
    // MARK: - setConfigure
    override func setConfigure() {
        view.backgroundColor = UIColor(named: "homeBackgroundColor")
        
        HomeatLogo.do {
            $0.image = UIImage(named: "homeatTextLogo")
        }
        
        welcomeLabel.do {
            $0.text = StringLiterals.Home.main.welcome
            $0.font = .headBold24
            $0.textColor = .white
        }
        
        savingLabel.do {
            $0.text = StringLiterals.Home.main.saving
            $0.font = .bodyBold18
            $0.textColor = .white
        }
        
        payAddButton.do {
            $0.backgroundColor = UIColor(named: "turquoiseGreen")
            $0.titleLabel?.font = .bodyBold18
            $0.setImage(UIImage(named: "plusIcon"), for: .normal)
            $0.setTitle(StringLiterals.Home.main.mainButton.add, for: .normal)
            $0.setTitleColor(.black, for: .normal)
            $0.layer.cornerRadius = 10
            $0.clipsToBounds = true
            $0.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 20)
        }
        
        payCheckButton.do {
            $0.backgroundColor = UIColor(named: "turquoiseGreen")
            $0.titleLabel?.font = .bodyBold18
            $0.setImage(UIImage(named: "checkIcon"), for: .normal)
            $0.setTitle(StringLiterals.Home.main.mainButton.check, for: .normal)
            $0.setTitleColor(.black, for: .normal)
            $0.layer.cornerRadius = 10
            $0.clipsToBounds = true
            $0.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 20)
        }
        
        editAlert.do {
            let confirm = UIAlertAction(title: StringLiterals.Home.main.Alert.yes, style: .default){ action in
                self.navigationController?.pushViewController(EditDoneViewController(), animated: true)
            }
            let cancle = UIAlertAction(title: StringLiterals.Home.main.Alert.no, style: .destructive, handler: nil)
            $0.title = StringLiterals.Home.main.Alert.title
            $0.message = StringLiterals.Home.main.Alert.message
            $0.addTextField() { TextField in
                TextField.placeholder = StringLiterals.Home.main.Alert.textField
            }
            editAlert.addAction(confirm)
            editAlert.addAction(cancle)
        }
    }

    //MARK: - setConstraints
    override func setConstraints() {
        view.addSubviews(HomeatLogo, welcomeLabel, savingLabel, payAddButton, payCheckButton, mainView)
        
        HomeatLogo.snp.makeConstraints {
            $0.top.equalToSuperview().offset(72)
            $0.leading.equalToSuperview().offset(20)
            
        }
        welcomeLabel.snp.makeConstraints {
            $0.top.equalTo(HomeatLogo.snp.bottom).offset(27.7)
            $0.leading.equalTo(HomeatLogo)
        }
        
        savingLabel.snp.makeConstraints {
            $0.top.equalTo(welcomeLabel.snp.bottom).offset(10)
            $0.leading.equalTo(HomeatLogo)
        }
        
        mainView.snp.makeConstraints {
            $0.top.equalTo(savingLabel.snp.bottom).offset(20)
            $0.leading.equalTo(HomeatLogo)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(353)
        }
        
        payAddButton.snp.makeConstraints {
            $0.top.equalTo(mainView.snp.bottom).offset(37)
            $0.leading.equalTo(HomeatLogo)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(49)
        }
        
        payCheckButton.snp.makeConstraints {
            $0.top.equalTo(payAddButton.snp.bottom).offset(18)
            $0.leading.equalTo(HomeatLogo)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(49)
        }
    }
    
    //MARK: - setButtonAction
    private func setAddTarget() {
        payAddButton.addTarget(self, action: #selector(isPayAddButtonTapped), for: .touchUpInside)
        
        payCheckButton.addTarget(self, action: #selector(isPayCheckButtonTapped), for: .touchUpInside)
    }
    
    //MARK: - @objc Func
    @objc func isPayAddButtonTapped(_ sender: Any) {
        let nextVC = PayAddViewController()
        self.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @objc func isPayCheckButtonTapped(_ sender: Any) {
        let nextVC = PayCheckViewController()
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func editButtonTapped() {
        present(editAlert, animated: true)
    }
}
