//
//  EditIncomeViewController.swift
//  HOMEAT
//
//  Created by 김민솔 on 7/10/24.
//

import UIKit

class EditIncomeViewController: BaseViewController, UITextFieldDelegate {
    
    // MARK: Property
    private let presentIncomeLabel = UILabel()
    private let presentIncomeView = PresentIncomeView()
    private let checkIncomeLabel = UILabel()
    private let duplicationCheckButton = UIButton()
    private let confirmButton = UIButton()
    private let incomeTextField = UITextField()
    var isNicknameValid: Bool = false
    private var newName: String = ""
    let userName = UserDefaults.standard.string(forKey: "userNickname") ?? "사용자"
    let income = UserDefaults.standard.double(forKey: "userIncome")
    
    // MARK: Life Cycle
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigation()
        incomeTextField.delegate = self
        incomeTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        confirmButton.addTarget(self, action: #selector(confirmButtonTapped), for: .touchUpInside)
    }
    
    // MARK: UI
    override func setConfigure() {
        view.do {
            $0.backgroundColor = UIColor(r: 30, g: 32, b: 33)
        }
        
        presentIncomeLabel.do {
            $0.text = "현재 한 달 수입"
            $0.font = .bodyMedium18
            $0.textColor = .turquoiseGreen
        }
        
        checkIncomeLabel.do {
            $0.text = "변경할 한 달 수입"
            $0.font = .bodyMedium18
            $0.textColor = .turquoiseGreen
        }
        
        incomeTextField.do {
            let attributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: UIColor.gray
            ]
            $0.attributedPlaceholder = NSAttributedString(string: "변경된 수입을 입력해주세요.", attributes: attributes)
            $0.font = .bodyMedium16
            $0.textColor = .white
            $0.layer.cornerRadius = 10
            $0.clipsToBounds = true
            $0.backgroundColor = .coolGray4
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: $0.frame.height))
            $0.leftViewMode = .always
            $0.keyboardType = .numberPad
        }
        
        confirmButton.do {
            $0.setTitle("변경하기", for: .normal)
            $0.setTitleColor(UIColor.black, for: .normal)
            $0.layer.cornerRadius = 10
            $0.layer.masksToBounds = true
            $0.backgroundColor = UIColor(named: "warmgray3")
            $0.alpha = 0.5
            $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
    }
    
    override func setConstraints() {
        
        view.addSubviews(presentIncomeLabel, presentIncomeView, checkIncomeLabel, incomeTextField, confirmButton)
        
        presentIncomeLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(35)
            $0.leading.equalToSuperview().offset(20)
        }
        
        presentIncomeView.snp.makeConstraints {
            $0.top.equalTo(presentIncomeLabel.snp.bottom).offset(12)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(57)
        }
        
        checkIncomeLabel.snp.makeConstraints {
            $0.top.equalTo(presentIncomeView.snp.bottom).offset(35)
            $0.leading.equalToSuperview().offset(20)
        }
        
        incomeTextField.snp.makeConstraints {
            $0.top.equalTo(checkIncomeLabel.snp.bottom).offset(12)
            $0.leading.equalToSuperview().offset(20)
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
        self.navigationItem.title = "한 달 수입 변경"
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.tintColor = .white
    }
    
    private func updateServer(with income: Int) {
//        guard let incomeText = incomeTextField.text, !incomeText.isEmpty, let newIncome = Int(incomeText) else {
//            showAlert(message: "유효한 수입을 입력해주세요.")
//            return
//        }
        let bodyDTO = IncomeReuqestBodyDTO(income: Int(income))
        NetworkService.shared.myPageService.myPageIncomeEdit(bodyDTO: bodyDTO) { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let data):
                print("한달 수입 수정 완료")
                let nextVC = FinishIncomeViewController()
                nextVC.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(nextVC, animated: true)
            default:
                print("소득 수정 실패")
                self.showAlert(message: "수입 변경에 실패했습니다.")
                
            }
        }
    }

    private func setTapBarHidden() {
        self.tabBarController?.tabBar.isHidden = true
    }

    private func showAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    @objc private func confirmButtonTapped() {
        guard let incomeText = incomeTextField.text, !incomeText.isEmpty, let newIncome = Int(incomeText.replacingOccurrences(of: ",", with: "")) else {
            showAlert(message: "유효한 수입을 입력해주세요.")
            return
        }
        
        UserDefaults.standard.set(newIncome, forKey: "userIncome")
        updateServer(with: newIncome)
    }

    @objc private func textFieldDidChange(_ textField: UITextField) {
        if let text = textField.text, !text.isEmpty {
            confirmButton.backgroundColor = .turquoiseGreen
            confirmButton.alpha = 1.0
            formatTextField(textField)
        } else {
            confirmButton.backgroundColor = UIColor(named: "warmgray3")
            confirmButton.alpha = 0.5
        }
    }

    private func formatTextField(_ textField: UITextField) {
        if let text = textField.text?.replacingOccurrences(of: ",", with: ""),
           let number = Double(text) {
            textField.text = Formatter.withSeparator.string(from: NSNumber(value: number))
        }
    }

}
