//
//  PayAddViewController.swift
//  HOMEAT
//
//  Created by 강삼고 on 4/2/24.
//

import UIKit
import SnapKit
import Then

class PayAddViewController: BaseViewController {
    
    //MARK: - Property
    private let cameraButton = UIButton()
    private let priceTextField = UITextField()
    private let memoLabel = UILabel()
    private let memoTextField = UITextField()
    private let shopTagButton = TagButton()
    private let eatoutTagButton = TagButton()
    private let deliveryTagButton = TagButton()
    private let saveAlert = UIAlertController(title: "", message: "", preferredStyle: .alert)
    private let cameraActionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
    
    private let tagStackView = UIStackView()
    private let imagePicker = UIImagePickerController()
    
    //MARK: - Function
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        setAddTarget()
    }
    
    // MARK: - 탭바제거
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 커스텀 탭바를 숨깁니다.
        if let tabBarController = self.tabBarController as? HOMEATTabBarController {
            tabBarController.tabBar.isHidden = true
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // 다른 화면으로 넘어갈 때 커스텀 탭바를 다시 보이게 합니다.
        if let tabBarController = self.tabBarController as? HOMEATTabBarController {
            tabBarController.tabBar.isHidden = false
        }
    }

    // MARK: - setConfigure
    override func setConfigure() {
        view.do {
            $0.backgroundColor = UIColor(named: "homeBackgroundColor")
        }
        
        memoLabel.do {
            $0.text = "메모"
            $0.font = .bodyMedium18
            $0.textColor = UIColor(named: "turquoiseGreen")
        }
        
        cameraButton.do {
            var attributedTitle = AttributedString("영수증 사진 촬영")
            var config = UIButton.Configuration.plain()
            let pointSize = CGFloat(30)
            let imageConfig = UIImage.SymbolConfiguration(pointSize: pointSize)
            attributedTitle.font = .bodyBold18
            config.attributedTitle = attributedTitle
            config.image = UIImage(named: "cameraIcon")
            config.preferredSymbolConfigurationForImage = imageConfig
            config.imagePlacement = .top
            config.background.backgroundColor = UIColor(r: 42, g: 42, b: 44)
            config.baseForegroundColor = .white
            config.imagePadding = 19.7
            $0.configuration = config
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 14
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
            $0.spacing = 18
            $0.axis = .horizontal
            $0.alignment = .fill
            $0.distribution = .fillEqually
        }
        
        shopTagButton.do {
            var attributedTitle = AttributedString("#장보기")
            attributedTitle.font = .bodyMedium15
            $0.configuration?.attributedTitle = attributedTitle
        }
        
        eatoutTagButton.do {
            var attributedTitle = AttributedString("#외식비")
            attributedTitle.font = .bodyMedium15
            $0.configuration?.attributedTitle = attributedTitle
        }
        
        deliveryTagButton.do {
            var attributedTitle = AttributedString("#배달비")
            attributedTitle.font = .bodyMedium15
            $0.configuration?.attributedTitle = attributedTitle
        }
        
        saveAlert.do {
            let confirm = UIAlertAction(title: "금액 추가하기", style: .default)
            let cancle = UIAlertAction(title: "다시 찍기", style: .destructive, handler: nil)
            $0.message = "23,800원이 맞나요?"
            $0.addAction(confirm)
            $0.addAction(cancle)
        }
        
        cameraActionSheet.do {
            let takeAction = UIAlertAction(title: "사진 촬영", style: .default) { action in
                self.openCamera()
            }
            let selectAction = UIAlertAction(title: "앨범에서 사진 선택", style: .default) { action in
                self.openPhotoLibrary()
            }
            let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
            takeAction.setValue(UIColor.white, forKey: "titleTextColor")
            selectAction.setValue(UIColor.white, forKey: "titleTextColor")
            cancelAction.setValue(UIColor.red, forKey: "titleTextColor")
            $0.addAction(takeAction)
            $0.addAction(selectAction)
            $0.addAction(cancelAction)
        }
        
        imagePicker.do {
            $0.sourceType = .camera
            $0.allowsEditing = true
            $0.cameraDevice = .rear
            $0.delegate = self
            $0.cameraCaptureMode = .photo
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
            $0.top.equalTo(cameraButton.snp.bottom).offset(29)
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
    
    private func setNavigationBar() {
        self.navigationItem.title = "지출 추가"
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        let saveButtonItem = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveButtonTapped(_:)))
        saveButtonItem.tintColor = .white
        self.navigationItem.setRightBarButton(saveButtonItem, animated: false)
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.tintColor = .white
    }
    
    private func setAddTarget() {
        cameraButton.addTarget(self, action: #selector(cameraButtonTapped), for: .touchUpInside)
    }
    
    private func setTapBarHidden() {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    private func openCamera() {
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true)
    }
    
    private func openPhotoLibrary() {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true)
    }
    
    //MARK: - @objc Func
    @objc func saveButtonTapped(_ sender: UIBarButtonItem) {
        present(saveAlert, animated: true)
    }
    
    @objc func cameraButtonTapped(_ sender: Any) {
        present(cameraActionSheet, animated: true)
    }
}

//MARK: - Extension
extension PayAddViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
            let resizeImage = image.resizeImage(toFit: cameraButton)
            cameraButton.setImage(resizeImage, for: .normal)
            cameraButton.setTitle("", for: .normal)
        }
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}

extension UIImage {
    func resizeImage(toFit button: UIButton) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: button.frame.size)
        let resizedImage = renderer.image { _ in
            draw(in: CGRect(origin: .zero, size: button.frame.size))
        }
        return resizedImage
    }
}
