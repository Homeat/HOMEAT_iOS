//
//  LeaveViewController.swift
//  HOMEAT
//
//  Created by 김민솔 on 7/8/24.
//

import UIKit
import Then

class LeaveViewController: BaseViewController {
    private var selectedOptionButton: UIButton?
    private let confirmButton = UIButton().then {
        $0.setTitle("선택하기", for: .normal)
        $0.setTitleColor(UIColor.black, for: .normal)
        $0.layer.cornerRadius = 10
        $0.layer.masksToBounds = true
        $0.backgroundColor = UIColor.turquoiseGreen
        $0.alpha = 0.5
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.addTarget(self, action: #selector(confirmAction), for: .touchUpInside)
    }
    private let WhyLabel = UILabel().then {
        $0.text = "탈퇴하는 이유가 무엇인가요?"
        $0.textColor = UIColor.white
        $0.textAlignment = .center
        $0.font = UIFont.boldSystemFont(ofSize: 24)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    private let optionButton1: UIButton = {
        let button = UIButton()
        button.setTitle("쓰지 않는 앱이에요", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.layer.borderColor = UIColor(r: 187, g: 187, b: 187).cgColor
        button.contentHorizontalAlignment = .left
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        button.addTarget(self, action: #selector(option1Acttion), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private let optionButton2: UIButton = {
        let button = UIButton()
        button.setTitle("오류가 생겨서 쓸 수 없어요", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.layer.borderColor = UIColor(r: 187, g: 187, b: 187).cgColor
        button.contentHorizontalAlignment = .left
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        button.addTarget(self, action: #selector(option2Acttion), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private let optionButton3: UIButton = {
        let button = UIButton()
        button.setTitle("보완이 걱정돼요", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.layer.borderColor = UIColor(r: 187, g: 187, b: 187).cgColor
        button.contentHorizontalAlignment = .left
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        button.addTarget(self, action: #selector(option3Acttion), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private let optionButton4: UIButton = {
        let button = UIButton()
        button.setTitle("개인정보가 불안해요", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.layer.borderColor = UIColor(r: 187, g: 187, b: 187).cgColor
        button.contentHorizontalAlignment = .left
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        button.addTarget(self, action: #selector(option4Acttion), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private let optionButton5: UIButton = {
        let button = UIButton()
        button.setTitle("앱 사용법을 모르겠어요", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.layer.borderColor = UIColor(r: 187, g: 187, b: 187).cgColor
        button.contentHorizontalAlignment = .left
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        button.addTarget(self, action: #selector(option5Acttion), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private let container: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 30
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "gray2")
        setNavigation()
        addSubviws()
        configUI()
        view.backgroundColor = UIColor(r: 30, g: 32, b: 33)

    }
    
    // MARK: - 탭바제거
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 커스텀 탭바를 숨깁니다.
        if let tabBarController = self.tabBarController as? HOMEATTabBarController {
            tabBarController.tabBar.isHidden = true
        }
        tabBarController?.tabBar.isTranslucent = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if let tabBarController = self.tabBarController as? HOMEATTabBarController {
            tabBarController.tabBar.isHidden = false
        }
        tabBarController?.tabBar.isTranslucent = false
    }
    func addSubviws() {
        view.addSubview(WhyLabel)
        view.addSubview(container)
        container.addArrangedSubview(optionButton1)
        container.addArrangedSubview(optionButton2)
        container.addArrangedSubview(optionButton3)
        container.addArrangedSubview(optionButton4)
        container.addArrangedSubview(optionButton5)
        view.addSubviews(confirmButton)

    }
    func configUI() {
        NSLayoutConstraint.activate([
            WhyLabel.topAnchor.constraint(equalTo: view.topAnchor,constant: 139),
            WhyLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 52),
            WhyLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -52),
            WhyLabel.heightAnchor.constraint(equalToConstant: 28),
            
            self.container.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 21),
            self.container.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -22),
            self.container.topAnchor.constraint(equalTo: self.WhyLabel.bottomAnchor, constant: 50),
            self.container.heightAnchor.constraint(equalToConstant: 355),
            
            self.optionButton1.leadingAnchor.constraint(equalTo: self.container.leadingAnchor),
            self.optionButton1.trailingAnchor.constraint(equalTo: self.container.trailingAnchor),
            
            self.optionButton2.leadingAnchor.constraint(equalTo: self.container.leadingAnchor),
            self.optionButton2.trailingAnchor.constraint(equalTo: self.container.trailingAnchor),
            
            self.optionButton3.leadingAnchor.constraint(equalTo: self.container.leadingAnchor),
            self.optionButton3.trailingAnchor.constraint(equalTo: self.container.trailingAnchor),
            
            self.optionButton4.leadingAnchor.constraint(equalTo: self.container.leadingAnchor),
            self.optionButton4.trailingAnchor.constraint(equalTo: self.container.trailingAnchor),
            
            self.optionButton5.leadingAnchor.constraint(equalTo: self.container.leadingAnchor),
            self.optionButton5.trailingAnchor.constraint(equalTo: self.container.trailingAnchor),
            self.optionButton5.bottomAnchor.constraint(equalTo: self.container.bottomAnchor),
            
            
        ])
        self.confirmButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(50)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(50)
        }
        
    }
    private func setNavigation() {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.title = "탈퇴하기"
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "건너뛰기", style: .plain, target: self, action: #selector(jump))
        self.navigationItem.rightBarButtonItem?.tintColor = .turquoiseGreen
    }
    @objc func jump() {
        let leaveViewController = FinalLeaveViewController()
        self.navigationController?.pushViewController(leaveViewController, animated: true)
    }
    @objc func option1Acttion() {
        handleButtonSelection(optionButton: optionButton1)
    }
    @objc func option2Acttion() {
        handleButtonSelection(optionButton: optionButton2)
    }
    @objc func option3Acttion() {
        handleButtonSelection(optionButton: optionButton3)
    }
    @objc func option4Acttion() {
        handleButtonSelection(optionButton: optionButton4)
    }
    @objc func option5Acttion() {
        handleButtonSelection(optionButton: optionButton5)
    }
    
    func handleButtonSelection(optionButton: UIButton) {
        if selectedOptionButton == nil {
            selectedOptionButton = optionButton
            optionButton.backgroundColor = .gray
            confirmButton.isEnabled = true
            confirmButton.alpha = 1
            confirmButton.backgroundColor = .turquoiseGreen
        } else {
            selectedOptionButton?.backgroundColor = nil
            selectedOptionButton = optionButton
            optionButton.backgroundColor = .gray
        }
    }
    //뒤로가기
    @objc func back(_ sender: Any) {
         self.navigationController?.popViewController(animated: true)
        print("back click")
     }
    @objc func confirmAction() {
        let leaveViewController = FinalLeaveViewController()
        self.navigationController?.pushViewController(leaveViewController, animated: true)
    }

}

