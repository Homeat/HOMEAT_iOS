//
//  PayAddViewController.swift
//  HOMEAT
//
//  Created by 강삼고 on 4/2/24.
//

import UIKit
import SnapKit
import Then
import Alamofire
import AVFoundation
import Photos
import PhotosUI

class PayAddViewController: BaseViewController,UITextFieldDelegate {
    
    //MARK: - Property
    private lazy var customButton: UIButton = makeCustomButton()
    private let priceTextField = UITextField()
    private let memoLabel = UILabel()
    private let memoTextField = UITextField()
    private let shopTagButton = TagButton()
    private let eatoutTagButton = TagButton()
    private let deliveryTagButton = TagButton()
    private let imageView = UIImageView()
    private let saveAlert = UIAlertController(title: "", message: "", preferredStyle: .alert)
    private let tagStackView = UIStackView()
    private var selectedImageURL: String?
    private var selectedImage : UIImage?
    private var totalPrice : Int?
    private let priceButton = UIButton()
    private var keyboardHeight : CGFloat = 0
    private enum Mode {
        case camera
        case album
    }
    private var currentMode: Mode = .camera
    //MARK: - Function
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        setAddTarget()
        setKeyboardObservers()
        navigationController?.navigationBar.barTintColor = UIColor(named: "homeBackgroundColor")
        priceTextField.delegate = self
    }
    deinit {
        removeKeyboardObservers()
    }
    // MARK: - 탭바제거
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let tabBarController = self.tabBarController as? HOMEATTabBarController {
            tabBarController.tabBar.isHidden = true
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
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
        imageView.do {
            $0.layer.cornerRadius = 14
            $0.clipsToBounds = true
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
            $0.keyboardType = .numberPad
        }
        
        priceButton.do {
            var attributedTitle = AttributedString("23,800원")
            attributedTitle.font = .bodyMedium15
            $0.configuration?.attributedTitle = attributedTitle
            $0.setTitleColor(.white, for: .normal)
            $0.isHidden = true
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
            let confirm = UIAlertAction(title: "네 맞습니다.", style: .default) { _ in
            }
            let right = UIAlertAction(title: "금액 직접입력", style: .destructive) { _ in
                self.showPriceTextField()
            }
            $0.addAction(confirm)
            $0.addAction(right)
        }
        
    }
    //MARK: - 사진과 앨범 파트
    private var isCameraAuthorized: Bool {
        AVCaptureDevice.authorizationStatus(for: .video) == .authorized
    }
    //MARK: - setConstraints
    override func setConstraints(){
        view.addSubviews(customButton,imageView, priceTextField, priceButton, memoLabel, memoTextField, tagStackView)
        imageView.bringSubviewToFront(self.imageView)
        tagStackView.addArrangedSubview(shopTagButton)
        tagStackView.addArrangedSubview(eatoutTagButton)
        tagStackView.addArrangedSubview(deliveryTagButton)
        
        customButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(150)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(176)
            $0.width.equalTo(176)
        }
        
        imageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(150)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(176)
            $0.width.equalTo(176)
        }
        
        priceTextField.snp.makeConstraints {
            $0.top.equalTo(customButton.snp.bottom).offset(29)
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
    
    // MARK: - func
    private func showPriceTextField() {
        self.priceTextField.isHidden = false
        self.priceButton.isHidden = true
    }
    func makeCustomButton() -> UIButton {
        var config = UIButton.Configuration.plain()
        var attributedTitle = AttributedString("영수증 사진 촬영")
        attributedTitle.font = .systemFont(ofSize: 18, weight: .bold)
        config.attributedTitle = attributedTitle
        let pointSize = CGFloat(30)
        let imageConfig = UIImage.SymbolConfiguration(pointSize: pointSize)
        config.image = UIImage(named: "cameraIcon")
        config.preferredSymbolConfigurationForImage = imageConfig
        
        config.imagePlacement = .top
        config.background.backgroundColor = .darkGray
        config.baseForegroundColor = .lightGray
        config.cornerStyle = .small
        
        // 이미지와 텍스트 간격 조절
        config.imagePadding = 12.7
        config.titlePadding = 10
        
        let customButton = UIButton(configuration: config)
        customButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        return customButton
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
        customButton.addTarget(self, action: #selector(cameraButtonTapped), for: .touchUpInside)
    }
    private func setKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func removeKeyboardObservers() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func adjustViewForKeyboard() {
        let memoTextFieldMaxY = memoTextField.frame.maxY
        let viewHeight = view.frame.height
        let visibleHeight = viewHeight - keyboardHeight
        
        if memoTextFieldMaxY > visibleHeight {
            let yOffset = memoTextFieldMaxY - visibleHeight + 10
            view.frame.origin.y = -yOffset
        } else {
            view.frame.origin.y = 0
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == priceTextField {
            let currentText = textField.text ?? ""
            guard let stringRange = Range(range, in: currentText) else { return false }
            let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
            textField.text = formatNumber(updatedText)
            return false
        }
        return true
    }
    func pickImage() {
        let photoLibrary = PHPhotoLibrary.shared()
        var configuration = PHPickerConfiguration(photoLibrary: photoLibrary)
        configuration.selectionLimit = 1
        configuration.filter = .any(of: [.images])
        
        DispatchQueue.main.async {
            let picker = PHPickerViewController(configuration: configuration)
            picker.delegate = self // 이 부분을 추가해줍니다.
            picker.isEditing = true
            self.present(picker, animated: true, completion: nil)
        }
    }
    private func formatNumber(_ number: String) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.groupingSeparator = ","
        let cleanNumber = number.replacingOccurrences(of: ",", with: "")
        if let formattedNumber = numberFormatter.string(from: NSNumber(value: Int(cleanNumber) ?? 0)) {
            return formattedNumber
        }
        return number
    }
    
    //MARK: - @objc Func
    @objc private func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            keyboardHeight = keyboardFrame.height
            adjustViewForKeyboard()
        }
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        keyboardHeight = 0
        adjustViewForKeyboard()
    }
    
    @objc func saveButtonTapped(_ sender: UIBarButtonItem) {
        var selectedTag: String? = nil
        let homeVC = HomeViewController()
        if shopTagButton.isSelected {
            selectedTag = "장보기"
        } else if eatoutTagButton.isSelected {
            selectedTag = "외식비"
        } else if deliveryTagButton.isSelected {
            selectedTag = "배달비"
        }
        let memo = memoTextField.text ?? ""
        let price: Int
        if priceTextField.isHidden {
            price = UserDefaults.standard.value(forKey: "ocrPrice") as? Int ?? 0
        } else {
            let priceText = priceTextField.text?.replacingOccurrences(of: ",", with: "") ?? ""
            price = Int(priceText) ?? 0
        }
        //영수증 사진 첨부할 경우
        if let url = selectedImageURL {
            let request = PayAddRequestBodyDTO(money: price, type: selectedTag, memo: memo, url: url)
            NetworkService.shared.homeSceneService.payAdd(bodyDTO: request) { [weak self] response in
                guard let self = self else { return }
                switch response {
                case .success(_):
                    tabBarController?.tabBar.isHidden = true
                    homeVC.navigationItem.hidesBackButton = true
                    self.navigationController?.pushViewController(homeVC, animated: true)
                    print("데이터 서버 연동 성공")
                default:
                    print("데이터 서버 연동 실패")
                }
            }
        } else {
            let price = priceTextField.text?.replacingOccurrences(of: ",", with: "") ?? ""
            guard !price.isEmpty, let tag = selectedTag else {
                let alert = UIAlertController(title: "입력미스", message: "가격과 태그를 채워주세요", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                present(alert, animated: true)
                return
            }
            let request = PayAddRequestBodyDTO(money: Int(price), type: selectedTag, memo: memo, url: nil)
            NetworkService.shared.homeSceneService.payAdd(bodyDTO: request) { [weak self] response in
                guard let self = self else { return }
                switch response {
                case .success(_):
                    tabBarController?.tabBar.isHidden = true
                    homeVC.navigationItem.hidesBackButton = true
                    self.navigationController?.pushViewController(homeVC, animated: true)
                    print("데이터 서버 연동 성공")
                default:
                    print("데이터 서버 연동 실패")
                }
            }
        }
    }
    //MARK: - 사진과 앨범 파트
    // 버튼 액션 함수
    @objc func touchUpImageAddButton(button: UIButton) {
        // 갤러리 접근 권한 허용 여부 체크
        PHPhotoLibrary.requestAuthorization(for: .readWrite) { status in
            switch status {
            case .notDetermined:
                DispatchQueue.main.async {
                    self.showAlert(message: "갤러리를 불러올 수 없습니다. 핸드폰 설정에서 사진 접근 허용을 모든 사진으로 변경해주세요.")
                }
            case .denied, .restricted:
                DispatchQueue.main.async {
                    self.showAlert(message: "갤러리를 불러올 수 없습니다. 핸드폰 설정에서 사진 접근 허용을 모든 사진으로 변경해주세요.")
                }
            case .authorized, .limited: // 모두 허용, 일부 허용
                self.pickImage()
            @unknown default:
                print("PHPhotoLibrary::execute - \"Unknown case\"")
            }
        }
    }
    @objc private func openCamera() {
#if targetEnvironment(simulator)
        fatalError()
#endif
        
        AVCaptureDevice.requestAccess(for: .video) { [weak self] isAuthorized in
            guard isAuthorized else {
                self?.showAlertGoToSetting()
                return
            }
            
            
            DispatchQueue.main.async {
                let pickerController = UIImagePickerController()
                pickerController.sourceType = .camera
                pickerController.allowsEditing = false
                pickerController.mediaTypes = ["public.image"]
                pickerController.delegate = self
                self?.present(pickerController, animated: true)
            }
        }
    }
    
    @objc func buttonTapped(){
        
        let actionSheet = UIAlertController(title: "사진 선택", message: "원하는 방법을 선택하세요", preferredStyle: .actionSheet)
        let takePhotoAction = UIAlertAction(title: "사진 촬영", style: .default) { _ in
            self.currentMode = .camera
            self.openCamera()
        }
        let chooseFromLibraryAction = UIAlertAction(title: "앨범에서 사진 선택", style: .default) { _ in
            self.currentMode = .album
            self.touchUpImageAddButton(button: self.customButton)
        }
        
        let cancleAction = UIAlertAction(title: "취소", style: .cancel , handler: nil)
        takePhotoAction.setValue(UIColor.white, forKey: "titleTextColor")
        chooseFromLibraryAction.setValue(UIColor.white, forKey: "titleTextColor")
        cancleAction.setValue(UIColor.red, forKey: "titleTextColor")
        
        actionSheet.addAction(takePhotoAction)
        actionSheet.addAction(chooseFromLibraryAction)
        actionSheet.addAction(cancleAction)
        self.present(actionSheet, animated: true, completion: nil)
        
        
        
    }
    
    @objc func cameraButtonTapped() {
#if targetEnvironment(simulator)
        fatalError()
#endif
        
        AVCaptureDevice.requestAccess(for: .video) { [weak self] isAuthorized in
            guard isAuthorized else {
                self?.showAlertGoToSetting()
                return
            }
            DispatchQueue.main.async {
                let pickerController = UIImagePickerController()
                pickerController.sourceType = .camera
                pickerController.allowsEditing = false
                pickerController.mediaTypes = ["public.image"]
                pickerController.delegate = self
                self?.present(pickerController, animated: true)
            }
        }
    }
    func showAlert(message: String) {
        let alert = UIAlertController(title: "알림", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    func showAlertGoToSetting() {
        let alertController = UIAlertController(
            title: "현재 카메라 사용에 대한 접근 권한이 없습니다.",
            message: "설정 > {앱 이름}탭에서 접근을 활성화 할 수 있습니다.",
            preferredStyle: .alert
        )
        let cancelAlert = UIAlertAction(
            title: "취소",
            style: .cancel
        ) { _ in
            alertController.dismiss(animated: true, completion: nil)
        }
        let goToSettingAlert = UIAlertAction(
            title: "설정으로 이동하기",
            style: .default) { _ in
                guard
                    let settingURL = URL(string: UIApplication.openSettingsURLString),
                    UIApplication.shared.canOpenURL(settingURL)
                else { return }
                UIApplication.shared.open(settingURL, options: [:])
            }
        [cancelAlert, goToSettingAlert]
            .forEach(alertController.addAction(_:))
        DispatchQueue.main.async {
            self.present(alertController, animated: true)
        }
    }
}

//MARK: - Extension
extension PayAddViewController : UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    // 이미지 선택된 후 ocr 요청처리 메서드
    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]
    ) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            picker.dismiss(animated: true)
            return
        }
        handleSelectedImage(image)
        picker.dismiss(animated: true)
    }
    
    private func handleSelectedImage(_ image: UIImage) {
        selectedImage = image
        imageView.image = image
        imageView.isHidden = false
        customButton.isHidden = true
        
        // Show loading indicator
        let loadingIndicator = UIActivityIndicatorView(style: .large)
        loadingIndicator.center = view.center
        view.addSubview(loadingIndicator)
        loadingIndicator.startAnimating()
        view.isUserInteractionEnabled = false // Disable user interaction while loading

        if let imageData = image.jpegData(compressionQuality: 0.8) {
            uploadImage(imageData: imageData, loadingIndicator: loadingIndicator)
        }
    }
    
    private func uploadImage(imageData: Data, loadingIndicator: UIActivityIndicatorView) {
        let image = OcrRequestBodyDTO(file: imageData)
        NetworkService.shared.homeSceneService.ocr(bodyDTO: image) { [weak self] response in
            guard let self = self else { return }
            // Hide the loading indicator
            DispatchQueue.main.async {
                loadingIndicator.stopAnimating()
                loadingIndicator.removeFromSuperview()
                self.view.isUserInteractionEnabled = true // Re-enable user interaction
            }

            switch response {
            case .success(let data):
                guard let imageUrl = data.data?.imageUrl else {
                    return
                }
                print(data.data?.totalPrice ?? "")
                DispatchQueue.main.async {
                    self.priceTextField.isHidden = true
                    self.priceButton.isHidden = false
                    self.priceButton.snp.makeConstraints {
                        $0.top.equalTo(self.imageView.snp.bottom).offset(29)
                        $0.leading.equalToSuperview().offset(105)
                        $0.trailing.equalToSuperview().offset(-104)
                        $0.height.equalTo(43)
                    }
                    let price = String(data.data?.totalPrice ?? 0).formattedWithSeparator()
                    
                    let attributedTitle = NSMutableAttributedString(string: price, attributes: [
                        .font: UIFont.bodyBold18,
                        .foregroundColor: UIColor.white
                    ])
                    
                    let wonString = NSAttributedString(string: " 원", attributes: [
                        .font: UIFont.systemFont(ofSize: 25, weight: .bold),
                        .foregroundColor: UIColor.white
                    ])
                    
                    attributedTitle.append(wonString)
                    
                    self.priceButton.setAttributedTitle(attributedTitle, for: .normal)
                    self.saveAlert.message = "\(price)원이 맞나요?"
                    self.present(self.saveAlert, animated: true, completion: nil)
                }
                UserDefaults.standard.setValue(data.data?.totalPrice, forKey: "ocrPrice")
                self.selectedImageURL = imageUrl
                print("ocr 서버 연동 성공")
            default:
                print("데이터 서버 연동 실패")
            }
        }
    }
}

extension PayAddViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true, completion: nil)
        
        guard let provider = results.first?.itemProvider else { return }
        if provider.canLoadObject(ofClass: UIImage.self) {
            provider.loadObject(ofClass: UIImage.self) { [weak self] image, error in
                guard let image = image as? UIImage, error == nil else { return }
                DispatchQueue.main.async {
                    self?.handleSelectedImage(image)
                }
            }
        }
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

extension String {
    func formattedWithSeparator() -> String {
        guard let number = Int(self) else { return self }
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber(value: number)) ?? self
    }
}
