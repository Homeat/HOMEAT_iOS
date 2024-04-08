//
//  PayAddViewController.swift
//  HOMEAT
//
//  Created by 강삼고 on 4/2/24.
//

import UIKit
import SnapKit
import Then

class PayAddViewController : BaseViewController {
    
    var config = UIButton.Configuration.plain()
    //MARK: - Property
    private let cameraButton = UIButton()
    private let priceTextField = UITextField()
    private let memoLabel = UILabel()
    private let memoTextField = UITextField()
    private let shopTagButton = TagButton()
    private let eatoutTagButton = TagButton()
    private let deliveryTagButton = TagButton()
    private let saveAlert = UIAlertController(title: "", message: "", preferredStyle: .alert)
    
    let tagStackView = UIStackView()
    
    //MARK: - Function
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
    }
    
    // MARK: - setConfigure
    override func setConfigure() {
        view.backgroundColor = UIColor(named: "homeBackgroundColor")
        
        memoLabel.do {
            $0.text = "메모"
            $0.font = .bodyMedium18
            $0.textColor = UIColor(named: "turquoiseGreen")
        }
        
        cameraButton.do {
            var attributedTitle = AttributedString("영수증 사진 촬영")
            attributedTitle.font = .bodyBold18
            config.attributedTitle = attributedTitle
            let pointSize = CGFloat(30)
            let imageConfig = UIImage.SymbolConfiguration(pointSize: pointSize)
            config.image = UIImage(named: "cameraIcon")
            config.preferredSymbolConfigurationForImage = imageConfig
            config.imagePlacement = .top
            config.background.backgroundColor = UIColor(r: 42, g: 42, b: 44)
            config.baseForegroundColor = .white
            config.cornerStyle = .small
            // 이미지와 텍스트 간격 조절
            config.imagePadding = 19.7
            $0.configuration = config

        }
        
        priceTextField.do {
            $0.attributedPlaceholder = NSAttributedString(string: "지출 금액을 입력해 주세요", attributes: [NSAttributedString.Key.foregroundColor: UIColor(r: 204, g: 204, b: 204)])
            $0.backgroundColor = UIColor(r: 42, g: 42, b: 44)
            $0.font = .bodyMedium15
            $0.layer.cornerRadius = 10
            $0.layer.masksToBounds = true
            $0.textColor = .white
            $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
            $0.leftViewMode = .always
        }
        
        memoTextField.do {
            $0.attributedPlaceholder = NSAttributedString(string: "오늘의 지출이 담고 있는 이야기는?", attributes: [NSAttributedString.Key.foregroundColor: UIColor(r: 204, g: 204, b: 204)])
            $0.backgroundColor = UIColor(r: 54, g: 56, b: 57)
            $0.font = .bodyMedium15
            $0.layer.cornerRadius = 10
            $0.layer.masksToBounds = true
            $0.textColor = .white
            $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 18, height: 0))
            $0.leftViewMode = .always
        }
        
        tagStackView.do {
            $0.spacing = 20
            $0.axis = .horizontal
            $0.alignment = .fill
            $0.distribution = .fillEqually
        }
        
        shopTagButton.do {
            $0.configuration?.title = "#장보기"
        }
        
        eatoutTagButton.do {
            $0.configuration?.title = "#외식비"
        }
        
        deliveryTagButton.do {
            $0.configuration?.title = "#배달비"
        saveAlert.do {
            let confirm = UIAlertAction(title: "금액 추가하기", style: .default)
            let cancle = UIAlertAction(title: "다시 찍기", style: .destructive, handler: nil)
            $0.message = "23,800원이 맞나요?"
            $0.addAction(confirm)
            $0.addAction(cancle)
        }
    }
    
    //MARK: - setConstraints
    override func setConstraints(){
        view.addSubviews(cameraButton, priceTextField, memoLabel, memoTextField, tagStackView)
        
        tagStackView.addArrangedSubview(shopTagButton)
        tagStackView.addArrangedSubview(eatoutTagButton)
        tagStackView.addArrangedSubview(deliveryTagButton)
        
        cameraButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(150)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(176)
            $0.width.equalTo(176)
        }
        
        priceTextField.snp.makeConstraints {
            $0.top.equalTo(cameraButton.snp.bottom).offset(21)
            $0.leading.equalToSuperview().offset(105)
            $0.trailing.equalToSuperview().offset(-104)
            $0.height.equalTo(43)
        }
        
        tagStackView.snp.makeConstraints {
            $0.top.equalTo(priceTextField.snp.bottom).offset(36)
            $0.leading.equalToSuperview().offset(38)
            $0.trailing.equalToSuperview().offset(-37)
        }
        
        memoLabel.snp.makeConstraints {
            $0.top.equalTo(tagStackView.snp.bottom).offset(25)
            $0.leading.equalToSuperview().offset(21)
        }
        
        memoTextField.snp.makeConstraints {
            $0.top.equalTo(memoLabel.snp.bottom).offset(5)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(50)
        }
    }
    
    func setNavigationBar() {
        self.navigationItem.title = "지출 추가"
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        let saveButtonItem = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(save(_:)))
        saveButtonItem.tintColor = .white
        self.navigationItem.setRightBarButton(saveButtonItem, animated: false)
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.tintColor = .white
    }
    
    //MARK: - @objc Func
    @objc func save(_ sender: UIBarButtonItem) {
        present(saveAlert, animated: true)
    }
}
