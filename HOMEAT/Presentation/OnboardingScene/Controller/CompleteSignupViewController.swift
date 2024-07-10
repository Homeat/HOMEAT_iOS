//
//  CompleteSignupViewController.swift
//  HOMEAT
//
//  Created by 강석호 on 6/22/24.
//

import UIKit
import SnapKit
import Then

class CompleteSignupViewController: BaseViewController {
    
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let addMoreButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setAddTarget()
    }
    
    override func setConfigure() {
        view.do {
            $0.backgroundColor = UIColor(r: 30, g: 32, b: 33)
        }
        
        titleLabel.do {
            $0.text = "회원가입 완료"
            $0.font = .headMedium28
            $0.textAlignment = .center
            $0.textColor = .white
        }
        
        descriptionLabel.do {
            $0.text = "꼭 맞는 혜택을 위해\n추가정보를 입력해주세요!"
            $0.font = .bodyMedium18
            $0.textColor = .turquoiseGreen
            $0.textAlignment = .center
            $0.numberOfLines = 0
        }
        
        addMoreButton.do {
            $0.backgroundColor = UIColor(named: "turquoiseGreen")
            $0.titleLabel?.font = .bodyMedium18
            $0.setTitle("추가 정보 입력하기", for: .normal)
            $0.setTitleColor(.black, for: .normal)
            $0.layer.cornerRadius = 10
            $0.clipsToBounds = true
        }
    }
    
    override func setConstraints() {
        view.addSubviews(titleLabel, descriptionLabel, addMoreButton)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(150)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        addMoreButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.bottom.equalToSuperview().offset(-100)
            $0.height.equalTo(57)
        }
    }
    
    func setAddTarget() {
        addMoreButton.addTarget(self, action: #selector(addMoreButtonClicked), for: .touchUpInside)
    }
    
    @objc func addMoreButtonClicked() {
        let vc = SetBirthViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
