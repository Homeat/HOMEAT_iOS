//
//  RecipeWriteViewController.swift
//  HOMEAT
//
//  Created by 이지우 on 5/19/24.
//

import Foundation
import UIKit
import SnapKit
import Then
import Photos
import PhotosUI
import AVFoundation

class RecipeWriteViewController: BaseViewController, UICollectionViewDelegateFlowLayout {
    var selectedButton: UIButton?
    private var selectedImages: [UIImage] = []
    private lazy var customButton: UIButton = makeCustomButton()
    private enum Mode {
            case camera
            case album
    }
    private var currentMode: Mode = .camera
    var activeField: UIView?
    private var isCameraAuthorized: Bool {
       AVCaptureDevice.authorizationStatus(for: .video) == .authorized
     }
    var data: [String] = ["Cell 1", "Cell 2"]
    var tableViewHeightConstraint: NSLayoutConstraint!
    //MARK: - Property
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let imagePicker = UIImagePickerController()
    //private let photoButton = UIButton()
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        //셀 만들어야 함
        collectionView.register(PhotoViewCell.self, forCellWithReuseIdentifier: "PhotoViewCell")
        
        return collectionView
    }()
    private let imageView = UIImageView()
    private let container = UIStackView()
    private let breakfastButton = UIButton()
    private let lunchButton = UIButton()
    private let dinnerButton = UIButton()
    private let nameLabel = UILabel()
    private let nameTextField = UITextField()
    private let memoLabel = UILabel()
    private let memoTextView = UITextView()
    private let line = UIView()
    private let stepLabel = UILabel()
    private let stepAddButton = UIButton()
    private let tableView = UITableView()
    
    //MARK: - LIfeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        setUpKeyboard()
        collectionView.isHidden = true
        setTableView()
        navigationController?.navigationBar.barTintColor = UIColor(named: "homeBackgroundColor")
    }

    //MARK: - SetUI
    let textViewPlaceHolder = "오늘의 음식이 담고 있는 이야기는?"
    override func setConfigure() {
        self.view.do {
            $0.backgroundColor = UIColor(named: "homeBackgroundColor")
        }
        
        scrollView.do {
            $0.backgroundColor = UIColor(named: "homeBackgroundColor")
        }
        
        contentView.do {
            $0.backgroundColor = UIColor(named: "homeBackgroundColor")
        }
        
        imagePicker.do {
            $0.delegate = self
        }
        
        imageView.do {
            $0.layer.cornerRadius = 14
        }
        
        container.do {
            $0.axis = .horizontal
            $0.distribution = .fillEqually
            $0.spacing = 28
        }
        
        breakfastButton.do {
            $0.setTitle("#아침", for: .normal)
            $0.setTitleColor(UIColor(named: "turquoiseGreen"), for: .normal)
            $0.layer.cornerRadius = 18
            $0.titleLabel?.font = .bodyBold15
            $0.backgroundColor = .turquoiseDarkGray
            $0.addTarget(self, action: #selector(isHashTagButtonTapped), for: .touchUpInside)
            $0.layer.borderWidth = 2
            $0.layer.borderColor = UIColor(named: "turquoiseDarkGray")?.cgColor
        }
        
        lunchButton.do {
            $0.setTitle("#점심", for: .normal)
            $0.setTitleColor(UIColor(named: "turquoiseGreen"), for: .normal)
            $0.layer.cornerRadius = 18
            $0.titleLabel?.font = .bodyBold15
            $0.backgroundColor = .turquoiseDarkGray
            $0.addTarget(self, action: #selector(isHashTagButtonTapped), for: .touchUpInside)
            $0.layer.borderWidth = 2
            $0.layer.borderColor = UIColor(named: "turquoiseDarkGray")?.cgColor
        }
        
        dinnerButton.do {
            $0.setTitle("#저녁", for: .normal)
            $0.setTitleColor(UIColor(named: "turquoiseGreen"), for: .normal)
            $0.layer.cornerRadius = 18
            $0.titleLabel?.font = .bodyBold15
            $0.backgroundColor = .turquoiseDarkGray
            $0.addTarget(self, action: #selector(isHashTagButtonTapped), for: .touchUpInside)
            $0.layer.borderWidth = 2
            $0.layer.borderColor = UIColor(named: "turquoiseDarkGray")?.cgColor
        }
        
        nameLabel.do {
            $0.text = "제목"
            $0.textColor = .turquoiseGreen
            $0.font = .bodyMedium18
        }
        
        nameTextField.do {
            $0.backgroundColor = .turquoiseDarkGray
            $0.layer.cornerRadius = 10
            $0.attributedPlaceholder = NSAttributedString(string: "오늘 먹은 음식의 이름은?", attributes: [NSAttributedString.Key.foregroundColor : UIColor(named: "warmgray")!])
            $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: $0.frame.height))
            $0.leftViewMode = .always
            $0.textColor = .warmgray
            $0.font = .bodyMedium16
            $0.delegate = self
        }
        
        memoLabel.do {
            $0.text = "메모"
            $0.font = .bodyMedium18
            $0.textColor = .turquoiseGreen
        }
        
        memoTextView.do {
            $0.backgroundColor = .turquoiseDarkGray
            $0.layer.cornerRadius = 10
            $0.text = textViewPlaceHolder
            $0.textColor = .warmgray
            $0.delegate = self
            $0.textContainerInset = UIEdgeInsets(top: 13, left: 20, bottom: 0, right: 0)
            $0.font = .bodyMedium16
        }
        
        line.do {
            $0.backgroundColor = .turquoiseDarkGray
        }
        
        stepLabel.do {
            $0.text = "STEP"
            $0.font = .bodyMedium18
            $0.textColor = .turquoiseGreen
        }
        
        stepAddButton.do {
            $0.setTitle("레시피 추가하기", for: .normal)
            $0.setTitleColor(UIColor(r: 248, g: 208, b: 186), for: .normal)
            $0.titleLabel?.font = .bodyMedium16
            $0.addTarget(self, action: #selector(stepAddButtonTapped), for: .touchUpInside)
        }
    }
    
    override func setConstraints() {
        view.addSubviews(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubviews(customButton, collectionView, container, nameLabel, nameTextField, memoLabel, memoTextView, line, stepLabel, stepAddButton, tableView)
        self.view.addSubview(self.imageView)
        view.bringSubviewToFront(self.imageView)
        
        container.addArrangedSubview(breakfastButton)
        container.addArrangedSubview(lunchButton)
        container.addArrangedSubview(dinnerButton)
        
        scrollView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalTo(scrollView.frameLayoutGuide)
            $0.height.equalTo(1000)
        }
        
        customButton.snp.makeConstraints {
            $0.top.equalTo(contentView.safeAreaLayoutGuide.snp.top).offset(51)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(176)
            $0.width.equalTo(176)
        }
        
        collectionView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.height.equalTo(176)
            $0.top.equalTo(contentView.safeAreaLayoutGuide.snp.top).offset(51)
        }
        
        imageView.snp.makeConstraints {
            $0.top.equalTo(contentView.safeAreaLayoutGuide.snp.top).offset(51)
            $0.leading.equalTo(contentView.snp.leading).offset(108)
            $0.trailing.equalTo(contentView.snp.trailing).offset(-109)
            $0.height.equalTo(176)
        }
        
        container.snp.makeConstraints {
            $0.top.equalTo(customButton.snp.bottom).offset(36)
            $0.leading.equalToSuperview().offset(47)
            $0.trailing.equalToSuperview().offset(-47)
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(container.snp.bottom).offset(44)
            $0.leading.equalToSuperview().offset(21)
        }
        
        nameTextField.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(9)
            $0.leading.equalTo(nameLabel.snp.leading)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(50)
        }
        
        memoLabel.snp.makeConstraints {
            $0.top.equalTo(nameTextField.snp.bottom).offset(31)
            $0.leading.equalTo(nameLabel.snp.leading)
        }
        
        memoTextView.snp.makeConstraints {
            $0.top.equalTo(memoLabel.snp.bottom).offset(9)
            $0.leading.equalTo(nameLabel.snp.leading)
            $0.trailing.equalTo(nameTextField.snp.trailing)
            $0.height.equalTo(50)
        }
        
        line.snp.makeConstraints {
            $0.leading.equalTo(nameTextField.snp.leading)
            $0.trailing.equalTo(nameTextField.snp.trailing)
            $0.top.equalTo(memoTextView.snp.bottom).offset(9)
        }
        
        stepLabel.snp.makeConstraints {
            $0.leading.equalTo(line.snp.leading)
            $0.top.equalTo(line.snp.bottom).offset(18)
        }
        
        stepAddButton.snp.makeConstraints {
            $0.top.equalTo(stepLabel.snp.top)
            $0.bottom.equalTo(stepLabel.snp.bottom)
            $0.trailing.equalTo(memoTextView.snp.trailing)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(stepLabel.snp.bottom).offset(9)
            $0.leading.equalTo(line.snp.leading)
            $0.trailing.equalTo(line.snp.trailing)
            $0.height.equalTo(600)
        }
    }
    
    private func setNavigationBar() {
        self.navigationItem.title = "집밥토크 글쓰기"
        self.navigationController?.navigationBar.tintColor = .white
        let backbutton = UIBarButtonItem()
        backbutton.tintColor = .white
        navigationController?.navigationBar.topItem?.backBarButtonItem = backbutton
        navigationController?.navigationBar.barTintColor = UIColor(named: "homeBackgroundColor")
    }
    
    func setUpKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(RecipeWriteViewCell.self, forCellReuseIdentifier: RecipeWriteViewCell.identifier)
        tableView.backgroundColor = UIColor(named: "homeBackgroundColor")
        tableView.layer.cornerRadius = 10
    }
    
    //MARK: - @objc
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let keyboardHeight = keyboardSize.height
            adjustViewForKeyboard(show: true, keyboardHeight: keyboardHeight)
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        adjustViewForKeyboard(show: false, keyboardHeight: 0)
    }
    
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
                self.pickImage() // 갤러리 불러오는 동작을 할 함수
            @unknown default:
                print("PHPhotoLibrary::execute - \"Unknown case\"")
            }
        }
    }
    
    @objc func photoButtonTapped() {
        let actionSheet = UIAlertController(title: "사진 선택", message: "원하는 방법을 선택하세요", preferredStyle: .actionSheet)

        let takePhotoAction = UIAlertAction(title: "사진 촬영", style: .default) { _ in
            self.currentMode = .camera
            self.openCamera()
        }

        let chooseFromLibraryAction = UIAlertAction(title: "앨범에서 사진 선택", style: .default) { _ in
            self.currentMode = .album
            self.customButton.isHidden = true
            self.collectionView.isHidden = false
            self.touchUpImageAddButton(button: self.customButton)
        }

        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)

        takePhotoAction.setValue(UIColor.white, forKey: "titleTextColor")
        chooseFromLibraryAction.setValue(UIColor.white, forKey: "titleTextColor")
        cancelAction.setValue(UIColor.red, forKey: "titleTextColor")

        actionSheet.addAction(takePhotoAction)
        actionSheet.addAction(chooseFromLibraryAction)
        actionSheet.addAction(cancelAction)
        
        self.present(actionSheet, animated: true, completion: nil)
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
    
    @objc func stepAddButtonTapped() {
        let vc = StepWriteController()
        vc.delegate = self
        vc.modalPresentationStyle = UIModalPresentationStyle.automatic
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc func isHashTagButtonTapped(_ sender: UIButton) {
        if let selectedButton = selectedButton {
            selectedButton.isSelected = false
            selectedButton.layer.borderColor = UIColor(named: "turquoiseDarkGray")?.cgColor
        }
        sender.isSelected = true
        sender.layer.borderColor = UIColor(named: "turquoiseGreen")?.cgColor
        selectedButton = sender
    }
    
    //MARK: - Methods
    func pickImage(){
            let photoLibrary = PHPhotoLibrary.shared()
            var configuration = PHPickerConfiguration(photoLibrary: photoLibrary)

            configuration.selectionLimit = 3 //한번에 가지고 올 이미지 갯수 제한
            configuration.filter = .any(of: [.images]) // 이미지, 비디오 등의 옵션

            DispatchQueue.main.async { // 메인 스레드에서 코드를 실행시켜야함
                let picker = PHPickerViewController(configuration: configuration)
                picker.delegate = self
                picker.isEditing = true
                self.present(picker, animated: true, completion: nil) // 갤러리뷰 프리젠트
        }
    }
    
    func makeCustomButton() -> UIButton {
        var config = UIButton.Configuration.plain()
        var attributedTitle = AttributedString("사진 추가")
        attributedTitle.font = .systemFont(ofSize: 18, weight: .bold)
        config.attributedTitle = attributedTitle
        let pointSize = CGFloat(30)
        let imageConfig = UIImage.SymbolConfiguration(pointSize: pointSize)
        config.image = UIImage.init(named: "cameraIcon")
        config.preferredSymbolConfigurationForImage = imageConfig

        config.imagePlacement = .top
        config.background.backgroundColor = .darkGray
        config.baseForegroundColor = .lightGray
        config.cornerStyle = .small

        // 이미지와 텍스트 간격 조절
        config.imagePadding = 12.7
        config.titlePadding = 10

        let customButton = UIButton(configuration: config)
        customButton.addTarget(self, action: #selector(photoButtonTapped), for: .touchUpInside)
        customButton.translatesAutoresizingMaskIntoConstraints = false

        return customButton
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 176, height: 176)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 30
    }
}

//MARK: - Extension
extension RecipeWriteViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func showAlert(message: String) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return selectedImages.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoViewCell", for: indexPath) as! PhotoViewCell
            let image = selectedImages[indexPath.item]
            cell.imageView.image = image
            return cell
    }
}

extension RecipeWriteViewController: PHPickerViewControllerDelegate {
    // 사진 선택이 끝났을 때 호출되는 함수
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        let identifiers = results.compactMap(\.assetIdentifier)
        let fetchResult = PHAsset.fetchAssets(withLocalIdentifiers: identifiers, options: nil)
        
        let group = DispatchGroup()
        fetchResult.enumerateObjects { asset, index, pointer in
            
        }
        for result in results {
            group.enter()
            let itemProvider = result.itemProvider
            if itemProvider.canLoadObject(ofClass: UIImage.self) {
                itemProvider.loadObject(ofClass: UIImage.self) { [weak self] (image, error) in
                    guard let self = self else { return }
                    
                    if let error = error {
                        print("Error loading image: \(error)")
                        group.leave()
                        return
                    }
                    
                    if let image = image as? UIImage {
                        selectedImages.append(image)
                    }
                    
                    group.leave()
                }
            } else {
                group.leave()
            }
        }
        group.notify(queue: .main) {
            // 모든 이미지가 로드되었을 때 실행되는 부분
            DispatchQueue.main.async { [self] in
                if self.currentMode == .album {
                    // 앨범 모드일 경우의 처리
                    self.customButton.isHidden = true
                    self.collectionView.isHidden = false
                    self.selectedImages = selectedImages
                    
                    // 이미지가 추가되었을 때 디버깅 정보 출력
                    print("selectedImages contents: \(self.selectedImages)")
                    
                    self.collectionView.reloadData() // collectionView 갱신
                }
            }
            // 이미지 피커를 닫음
            picker.dismiss(animated: true, completion: nil)
        }
    }
}


extension RecipeWriteViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(
            _ picker: UIImagePickerController,
            didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]
        ) {
            guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
                picker.dismiss(animated: true)
                return
            }
            // 이미지를 selectedImages 배열에 추가
            selectedImages.append(image)
            
            // 이미지 뷰에 선택된 이미지 표시
            imageView.image = image //화면에 보일것이다.
            // 버튼을 숨기고 이미지 뷰를 표시하도록 설정
            //addImageButton.isHidden = true
            imageView.isHidden = false
            customButton.isHidden = true // customButton도 함께 숨김

            self.imageView.image = image
            //imagePickercontroller를 죽인다.
            picker.dismiss(animated: true, completion: nil)
            
            NSLayoutConstraint.activate([
                customButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: -200), //화면 밖으로 이동시킬려고 밖으로 빼냄
                customButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 108),
                customButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -109),
                customButton.heightAnchor.constraint(equalToConstant: 176),
            ])
        }
}

// TextField, TextView 키보드 처리
extension RecipeWriteViewController: UITextFieldDelegate, UITextViewDelegate {
    func adjustViewForKeyboard(show: Bool, keyboardHeight: CGFloat) {
        guard let activeField = self.activeField else { return }
        
        let adjustmentHeight = (show ? keyboardHeight : 0)
    
        var aRect = self.view.frame
        aRect.size.height -= adjustmentHeight
        
        if show {
            if let activeFieldFrame = activeField.superview?.convert(activeField.frame, to: self.view) {
                if !aRect.contains(activeFieldFrame.origin) {
                    let scrollPoint = CGPoint(x: 0, y: activeFieldFrame.origin.y - keyboardHeight)
                    UIView.animate(withDuration: 0.3) {
                        self.view.frame.origin.y = -scrollPoint.y
                    }
                }
            }
        } else {
            UIView.animate(withDuration: 0.3) {
                self.view.frame.origin.y = 0
            }
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeField = textField
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        activeField = nil
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        activeField = textView
        if textView.text == textViewPlaceHolder {
            textView.text = nil
            textView.textColor = .warmgray
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        activeField = nil
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.text = textViewPlaceHolder
            textView.textColor = .warmgray
        }
    }
}

// 하단 레시피 TableView
extension RecipeWriteViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RecipeWriteViewCell.identifier, for: indexPath) as! RecipeWriteViewCell
        cell.textLabel?.text = data[indexPath.row]
        cell.textLabel?.textColor = .white
        cell.selectionStyle = .none
        return cell
    }
}

extension RecipeWriteViewController: ModalViewControllerDelegate {
    func didAddCell() {
        data.append("New Cell")
        tableView.reloadData()
    }
}









