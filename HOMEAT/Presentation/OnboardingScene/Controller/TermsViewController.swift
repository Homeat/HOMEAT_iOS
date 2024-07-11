import UIKit
import SnapKit
import Then

class TermsViewController: BaseViewController {
    
    //MARK: - Properties
    private let signupButton = UIButton()
    
    private let container = UIStackView()
    
    private let allCheckButton = UIButton()
    private let allLabel = UILabel()
    private let allImage = UIImageView()
    private let allContainer = UIStackView()
    
    private let firstCheckButton = UIButton()
    private let firstLabel = UILabel()
    private let firstTermViewButton = UIButton()
    private let firstContainer = UIStackView()
    
    private let secondCheckButton = UIButton()
    private let secondLabel = UILabel()
    private let secondTermViewButton = UIButton()
    private let secondContainer = UIStackView()
    
    private let thirdCheckButton = UIButton()
    private let thirdLabel = UILabel()
    private let thirdTermViewButton = UIButton()
    private let thirdContainer = UIStackView()
    
    private let forthCheckButton = UIButton()
    private let forthLabel = UILabel()
    private let forthTermViewButton = UIButton()
    private let forthContainer = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAddTarget()
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    override func setConfigure() {
        view.backgroundColor = UIColor(named: "turquoiseGray2")
        
        container.do {
            $0.addArrangedSubview(allContainer)
            $0.addArrangedSubview(firstContainer)
            $0.addArrangedSubview(secondContainer)
            $0.addArrangedSubview(thirdContainer)
            $0.addArrangedSubview(forthContainer)
            $0.axis = .vertical
            $0.spacing = 10
            $0.alignment = .leading
        }
        
        allContainer.do {
            $0.addArrangedSubview(allCheckButton)
            $0.addArrangedSubview(allImage)
            $0.addArrangedSubview(allLabel)
            $0.axis = .horizontal
            $0.spacing = 5
        }
        
        allCheckButton.do {
            $0.setImage(UIImage(named: "termUncheck"), for: .normal)
            $0.setImage(UIImage(named: "termCheck"), for: .selected)
            $0.addTarget(self, action: #selector(allCheckButtonTapped), for: .touchUpInside)
        }
        
        allImage.do {
            $0.image = UIImage(named: "Logo")
            $0.contentMode = .scaleAspectFit
        }
        
        allLabel.do {
            $0.text = "약관 전체 동의"
            $0.textColor = .white
            $0.font = .bodyMedium18
        }
        
        firstContainer.do {
            $0.addArrangedSubview(firstCheckButton)
            $0.addArrangedSubview(firstLabel)
            $0.addArrangedSubview(firstTermViewButton)
            $0.axis = .horizontal
            $0.layoutMargins = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
            $0.isLayoutMarginsRelativeArrangement = true
            $0.spacing = 5
        }
        
        firstCheckButton.do {
            $0.setImage(UIImage(named: "termUncheck"), for: .normal)
            $0.setImage(UIImage(named: "termCheck"), for: .selected)
            $0.addTarget(self, action: #selector(checkButtonTapped), for: .touchUpInside)
        }
        
        firstLabel.do {
            $0.text = "[필수] 이용 약관 동의"
            $0.textColor = .white
            $0.font = .bodyMedium15
        }
        
        firstTermViewButton.do {
            $0.setTitle("보기", for: .normal)
            $0.setTitleColor(UIColor(named: "turquoiseGreen"), for: .normal)
            $0.titleLabel?.font = .bodyMedium15
        }
        
        secondContainer.do {
            $0.addArrangedSubview(secondCheckButton)
            $0.addArrangedSubview(secondLabel)
            $0.addArrangedSubview(secondTermViewButton)
            $0.axis = .horizontal
            $0.layoutMargins = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
            $0.isLayoutMarginsRelativeArrangement = true
            $0.spacing = 5
        }
        
        secondCheckButton.do {
            $0.setImage(UIImage(named: "termUncheck"), for: .normal)
            $0.setImage(UIImage(named: "termCheck"), for: .selected)
            $0.addTarget(self, action: #selector(checkButtonTapped), for: .touchUpInside)
        }
        
        secondLabel.do {
            $0.text = "[필수] 개인정보 수집 및 이용동의"
            $0.textColor = .white
            $0.font = .bodyMedium15
        }
        
        secondTermViewButton.do {
            $0.setTitle("보기", for: .normal)
            $0.setTitleColor(UIColor(named: "turquoiseGreen"), for: .normal)
            $0.titleLabel?.font = .bodyMedium15
        }
        
        thirdContainer.do {
            $0.addArrangedSubview(thirdCheckButton)
            $0.addArrangedSubview(thirdLabel)
            $0.addArrangedSubview(thirdTermViewButton)
            $0.axis = .horizontal
            $0.layoutMargins = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
            $0.isLayoutMarginsRelativeArrangement = true
            $0.spacing = 5
        }
        
        thirdCheckButton.do {
            $0.setImage(UIImage(named: "termUncheck"), for: .normal)
            $0.setImage(UIImage(named: "termCheck"), for: .selected)
            $0.addTarget(self, action: #selector(checkButtonTapped), for: .touchUpInside)
        }
        
        thirdLabel.do {
            $0.text = "[필수] 위치기반 정보 수집 동의"
            $0.textColor = .white
            $0.font = .bodyMedium15
        }
        
        thirdTermViewButton.do {
            $0.setTitle("보기", for: .normal)
            $0.setTitleColor(UIColor(named: "turquoiseGreen"), for: .normal)
            $0.titleLabel?.font = .bodyMedium15
        }
        
        forthContainer.do {
            $0.addArrangedSubview(forthCheckButton)
            $0.addArrangedSubview(forthLabel)
            $0.addArrangedSubview(forthTermViewButton)
            $0.axis = .horizontal
            $0.layoutMargins = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
            $0.isLayoutMarginsRelativeArrangement = true
            $0.spacing = 5
        }
        
        forthCheckButton.do {
            $0.setImage(UIImage(named: "termUncheck"), for: .normal)
            $0.setImage(UIImage(named: "termCheck"), for: .selected)
            $0.addTarget(self, action: #selector(checkButtonTapped), for: .touchUpInside)
        }
        
        forthLabel.do {
            $0.text = "[선택] 마케팅 활용 동의"
            $0.textColor = .white
            $0.font = .bodyMedium15
        }
        
        forthTermViewButton.do {
            $0.setTitle("보기", for: .normal)
            $0.setTitleColor(UIColor(named: "turquoiseGreen"), for: .normal)
            $0.titleLabel?.font = .bodyMedium15
        }
        
        signupButton.do {
            $0.setTitle("동의하고 가입하기", for: .normal)
            $0.setTitleColor(.black, for: .normal)
            $0.backgroundColor = .gray
            $0.layer.cornerRadius = 10
            $0.titleLabel?.font = .bodyMedium18
            $0.clipsToBounds = true
            $0.isEnabled = false
        }
    }
    
    override func setConstraints() {
        view.addSubviews(signupButton, container)
        
        container.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            $0.leading.equalTo(signupButton.snp.leading)
        }
        
        signupButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.bottom.equalToSuperview().inset(96)
            $0.height.equalTo(57)
        }
    }
    
    func setAddTarget() {
        firstTermViewButton.addTarget(self, action: #selector(firstCheckButtonTapped), for: .touchUpInside)
        secondTermViewButton.addTarget(self, action: #selector(secondCheckButtonTapped), for: .touchUpInside)
        thirdTermViewButton.addTarget(self, action: #selector(thirdCheckButtonTapped), for: .touchUpInside)
        forthTermViewButton.addTarget(self, action: #selector(forthCheckButtonTapped), for: .touchUpInside)
        signupButton.addTarget(self, action: #selector(signupButtonTapped), for: .touchUpInside)
    }
    
    @objc func signupButtonTapped() {
        let nextVC = SignUpViewController()
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @objc func firstCheckButtonTapped() {
        let nextVC = FirstPolicyViewController()
            nextVC.title = "이용 약관 동의"
            nextVC.view.backgroundColor = .turquoiseGray2
            let closeButton = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(closeButtonTapped))
            nextVC.navigationItem.rightBarButtonItem = closeButton
            
            let navigationController = UINavigationController(rootViewController: nextVC)
            navigationController.modalPresentationStyle = .fullScreen
            
            // 타이틀 텍스트 색상을 흰색으로 설정
            let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            navigationController.navigationBar.titleTextAttributes = textAttributes
            
            self.present(navigationController, animated: true, completion: nil)
    }
    
    @objc func secondCheckButtonTapped() {
        let nextVC = SecondPolicyViewController()
            nextVC.title = "개인정보 수집 및 이용동의"
            nextVC.view.backgroundColor = .turquoiseGray2
            let closeButton = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(closeButtonTapped))
            nextVC.navigationItem.rightBarButtonItem = closeButton
            
            let navigationController = UINavigationController(rootViewController: nextVC)
            navigationController.modalPresentationStyle = .fullScreen
            
            // 타이틀 텍스트 색상을 흰색으로 설정
            let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            navigationController.navigationBar.titleTextAttributes = textAttributes
            
            self.present(navigationController, animated: true, completion: nil)
    }
    
    @objc func thirdCheckButtonTapped() {
        let nextVC = ThirdPolicyViewController()
        nextVC.title = "위치기반 정보 수집 동의"
        nextVC.view.backgroundColor = .turquoiseGray2
        let closeButton = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(closeButtonTapped))
        nextVC.navigationItem.rightBarButtonItem = closeButton
        
        let navigationController = UINavigationController(rootViewController: nextVC)
        navigationController.modalPresentationStyle = .fullScreen
        
        // 타이틀 텍스트 색상을 흰색으로 설정
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController.navigationBar.titleTextAttributes = textAttributes
        
        self.present(navigationController, animated: true, completion: nil)
    }
    
    @objc func forthCheckButtonTapped() {
        let nextVC = ForthPolicyViewController()
        nextVC.title = "마케팅 활용 동의"
        nextVC.view.backgroundColor = .turquoiseGray2
        let closeButton = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(closeButtonTapped))
        nextVC.navigationItem.rightBarButtonItem = closeButton
        
        let navigationController = UINavigationController(rootViewController: nextVC)
        navigationController.modalPresentationStyle = .fullScreen
        
        // 타이틀 텍스트 색상을 흰색으로 설정
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController.navigationBar.titleTextAttributes = textAttributes
        
        self.present(navigationController, animated: true, completion: nil)
    }
    
    @objc func allCheckButtonTapped() {
        let isSelected = !allCheckButton.isSelected
        allCheckButton.isSelected = isSelected
        firstCheckButton.isSelected = isSelected
        secondCheckButton.isSelected = isSelected
        thirdCheckButton.isSelected = isSelected
        forthCheckButton.isSelected = isSelected
        updateSignupButtonState()
    }
    
    @objc func checkButtonTapped(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        updateAllCheckButtonState()
        updateSignupButtonState()
    }
    
    func updateAllCheckButtonState() {
        let allSelected = firstCheckButton.isSelected && secondCheckButton.isSelected && thirdCheckButton.isSelected && forthCheckButton.isSelected
        allCheckButton.isSelected = allSelected
    }
    
    func updateSignupButtonState() {
        let allRequiredSelected = firstCheckButton.isSelected && secondCheckButton.isSelected && thirdCheckButton.isSelected
        signupButton.isEnabled = allRequiredSelected
        signupButton.backgroundColor = allRequiredSelected ? UIColor(named: "turquoiseGreen") : .gray
    }
    
    @objc private func closeButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
}
