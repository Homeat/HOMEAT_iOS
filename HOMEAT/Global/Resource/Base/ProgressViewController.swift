//
//  ProgressViewController.swift
//  HOMEAT
//
//  Created by 강삼고 on 5/8/24.
//

import Foundation
import UIKit

class ProgressViewController: UIViewController {
    
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let detailLabel = UILabel()
    let continueButton = ContinueButton()
    var nextVC = UIViewController()
    var progressBar = UIProgressView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setConfigure()
        setProgressBar()
        setConstraints()
        setNavigationBar()
        setAddTarget()
    }
    
    func setProgressBar() {
        progressBar.do {
            $0.progressViewStyle = .default
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.progressTintColor = UIColor(named: "turquoiseGreen")
            $0.progress = 0.0
        }
    }
    
    func setConfigure() {
        view.do {
            $0.backgroundColor = UIColor(named: "homeBackgroundColor")
        }
        
        titleLabel.do {
            $0.text = " "
            $0.numberOfLines = 2
            $0.font = .headMedium28
            $0.textColor = .white
        }
        
        subtitleLabel.do {
            $0.text = " "
            $0.font = .bodyMedium18
            $0.textColor = UIColor(r: 216, g: 216, b: 216)
        }
        
        detailLabel.do {
            $0.text = " "
            $0.textColor = UIColor(named: "turquoiseGreen")
            $0.font = .bodyMedium18
        }
    }
    
    func setConstraints() {
        view.addSubviews(progressBar, titleLabel, subtitleLabel, detailLabel, continueButton)
        
        progressBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(178)
            $0.leading.equalToSuperview().offset(20)
        }
        
        subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(12)
            $0.leading.equalTo(titleLabel)
        }
        
        detailLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(79)
            $0.leading.equalTo(titleLabel)
        }
        
        continueButton.snp.makeConstraints {
            $0.top.equalTo(detailLabel.snp.bottom).offset(355)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
        }
    }
    
    func updateProgressBar(progress: Float) {
        progressBar.progress = progress
    }
    
    func setTitleLabel(title: String) {
        titleLabel.text = title
    }
    
    func setSubTitleLabel(subtitle: String) {
        subtitleLabel.text = subtitle
    }
    
    func setDetailLabel(detail: String) {
        detailLabel.text = detail
    }
    
    func setNextVC(nextVC: UIViewController) {
        self.nextVC = nextVC
    }
    
    func setNavigationBar() {
        self.navigationItem.title = "정보입력"
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.tintColor = .white
    }
    
    //MARK: - setButtonAction
    private func setAddTarget() {
        continueButton.addTarget(self, action: #selector(isContinueButtonTapped), for: .touchUpInside)
    }
    
    //MARK: - @objc Func
    @objc func isContinueButtonTapped(_ sender: UIButton) {
        self.navigationController?.pushViewController(nextVC, animated: true)
        
    }
}

//MARK: - Extension
extension ProgressViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        if text.isEmpty == true {
            continueButton.isEnabled = false
        } else {
            continueButton.isEnabled = true
        }
        return true
    }
}
