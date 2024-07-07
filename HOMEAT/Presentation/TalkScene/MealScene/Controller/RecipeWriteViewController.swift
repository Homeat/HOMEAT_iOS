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

class RecipeWriteViewController: BaseViewController, UICollectionViewDelegateFlowLayout, StepWriteViewControllerDelegate {
    var userId: Int?
    var selectedTag: String?
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
    var tableViewHeightConstraint: NSLayoutConstraint!
    var foodRecipes: [foodRecipeDTOS] = []
    func didSaveRecipe(recipe: String?, recipePicture: UIImage?) {
        let recipePictureData = recipePicture?.jpegData(compressionQuality: 0.8)
        let foodRecipe = foodRecipeDTOS(recipe: recipe ?? "", recipePicture: recipePictureData)
        foodRecipes.append(foodRecipe)
        tableView.reloadData()
        updateContentViewHeight()
        print("레시피: \(foodRecipe.recipe)")
        print("현재 foodRecipes 배열: \(foodRecipes.count) 개의 레시피가 있습니다.")
    }
    //MARK: - Property
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let imagePicker = UIImagePickerController()
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
        collectionView.register(PhotoViewCell.self, forCellWithReuseIdentifier: "PhotoViewCell")
        return collectionView
    }()
    private let imageView = UIImageView()
    private let deleteButton = UIButton()
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
    private let doneButton = UIButton()
    
    //MARK: - LIfeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        setUpKeyboard()
        setTableView()
        collectionView.isHidden = true
        memoTextView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
        updateContentViewHeight()
        navigationController?.navigationBar.barTintColor = UIColor(named: "homeBackgroundColor")
    }
    
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
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
            if keyPath == "contentSize", let newSize = change?[.newKey] as? CGSize {
                let newHeight = max(newSize.height, 50) // 최소 높이 제약 조건 설정
                memoTextView.constraints.filter { $0.firstAttribute == .height }.first?.constant = newHeight
                view.layoutIfNeeded()
            }
        }
        deinit {
            // 뷰 컨트롤러가 할당 해제될 때 옵저버를 제거
            memoTextView.removeObserver(self, forKeyPath: "contentSize")
        }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateContentViewHeight()
    }


    //MARK: - SetUI
    let textViewPlaceHolder = "오늘의 음식이 담고 있는 이야기는?"
    override func setConfigure() {
        self.view.do {
            $0.backgroundColor = UIColor(named: "homeBackgroundColor")
        }
        
        scrollView.do {
            $0.backgroundColor = UIColor(named: "homeBackgroundColor")
            $0.showsVerticalScrollIndicator = false
        }
        
        contentView.do {
            $0.backgroundColor = UIColor(named: "homeBackgroundColor")
        }
        
        imagePicker.do {
            $0.delegate = self
        }
        
        imageView.do {
            $0.layer.cornerRadius = 14
            $0.layer.masksToBounds = true
        }
        
        deleteButton.do {
            $0.setImage(UIImage(named: "DeleteButton"), for: .normal)
            $0.imageView?.contentMode = .scaleAspectFit
            $0.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
            $0.isHidden = true
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
            $0.setTitle("+레시피 추가", for: .normal)
            $0.setTitleColor(.white, for: .normal)
            $0.titleLabel?.font = .bodyMedium16
            $0.addTarget(self, action: #selector(stepAddButtonTapped), for: .touchUpInside)
        }
    }
    
    override func setConstraints() {
        view.addSubviews(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubviews(imageView, collectionView, container, nameLabel, nameTextField, memoLabel, memoTextView, line, stepLabel, stepAddButton, tableView)
        contentView.bringSubviewToFront(imageView)
        contentView.addSubview(customButton)
        contentView.addSubview(deleteButton)
        contentView.bringSubviewToFront(deleteButton)
        
        container.addArrangedSubview(breakfastButton)
        container.addArrangedSubview(lunchButton)
        container.addArrangedSubview(dinnerButton)
        
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
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
            $0.centerX.equalToSuperview()
            $0.height.equalTo(176)
            $0.width.equalTo(176)

        }
        
        deleteButton.snp.makeConstraints {
            $0.top.equalTo(contentView.safeAreaLayoutGuide.snp.top).offset(47)
            $0.trailing.equalTo(imageView.snp.trailing).offset(10.8)
            $0.height.equalTo(33.2)
            $0.width.equalTo(33.2)
        }
        
        container.snp.makeConstraints {
            $0.top.equalTo(contentView.safeAreaLayoutGuide).offset(267)
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
        let titleAttributes: [NSAttributedString.Key: Any] = [
            .font:  UIFont(name: "NotoSansKR-Medium", size: 18)!,
            .foregroundColor: UIColor.white
        ]
        navigationController?.navigationBar.titleTextAttributes = titleAttributes
        let backbutton = UIBarButtonItem()
        backbutton.tintColor = .white
        navigationController?.navigationBar.topItem?.backBarButtonItem = backbutton
        navigationController?.navigationBar.barTintColor = UIColor(named: "homeBackgroundColor")
        let rightButton = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveButtonTapped))
        let rightAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "NotoSansKR-Medium", size: 18)!,
            .foregroundColor: UIColor.white]
        rightButton.setTitleTextAttributes(rightAttributes, for: .normal)
        navigationItem.rightBarButtonItem = rightButton
    }
    
    func setUpKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    private func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(RecipeWriteViewCell.self, forCellReuseIdentifier: RecipeWriteViewCell.identifier)
        tableView.backgroundColor = UIColor(named: "homeBackgroundColor")
        tableView.layer.cornerRadius = 10
        tableView.isUserInteractionEnabled = true
        tableView.allowsSelection = true
    }
    
    func saveData() {
        NotificationCenter.default.post(name: NSNotification.Name("FoodTalkDataChanged"), object: nil)
        navigationController?.popViewController(animated: true)
    }
    
    private func updateContentViewHeight() {
        let contentHeight = tableView.contentSize.height + 600 // 기본 높이 + 테이블 뷰의 높이
        contentView.snp.updateConstraints { make in
            make.height.equalTo(contentHeight)
        }
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 100, right: 0)
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
            case .authorized, .limited:
                self.pickImage()
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
        vc.stepDelegate = self
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
        if let tag = sender.titleLabel?.text?.replacingOccurrences(of: "#", with: "") {
            selectedTag = tag
        }
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func saveButtonTapped() {
        guard let name = nameTextField.text, !name.isEmpty else {
            showAlert(message: "제목을 입력하세요")
            return
        }
        
        guard let memo = memoTextView.text, !memo.isEmpty else {
            showAlert(message: "메모를 입력하세요")
            return
        }
        
        if name.count >= 15 {
            let alert = UIAlertController(title: "제목 길이 초과", message: "제목이 너무 길어요", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        
        if memo.count >= 130 {
            let alert = UIAlertController(title: "내용 길이 초과", message: "내용이 너무 길어요", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        
        guard let tag = selectedTag, !tag.isEmpty else {
            showAlert(message: "태그를 선택하세요")
            return
        }
        
        guard !selectedImages.isEmpty else {
            showAlert(message: "이미지를 선택하세요")
            return
        }
        
        let imageDataArray = selectedImages.compactMap { $0.jpegData(compressionQuality: 0.8) }
        let bodyDTO = FoodTalkSaveRequestBodyDTO(name: name, memo: memo, tag: tag, ingredient: "재료", foodPictures: imageDataArray, foodRecipeRequest: foodRecipes)
        print(bodyDTO)
        print("bodyDTO.foodRecipeRequest count: \(bodyDTO.foodRecipeRequest.count)")
        for recipe in bodyDTO.foodRecipeRequest {
            print("Recipe: \(recipe.recipe)")
        }
        
        NetworkService.shared.foodTalkService.foodTalkSave(bodyDTO: bodyDTO) { [weak self] response in
            switch response {
            case .success(let data):
                print("성공: 데이터가 반환되었습니다")
                if let foodTalkData = data.data {}
                for (index, image) in imageDataArray.enumerated() {
                    print("Image \(index) Size: \(image.count) bytes")
                }
                NotificationCenter.default.post(name: NSNotification.Name("FoodTalkDataChanged"), object: nil)
                self?.navigationController?.popViewController(animated: true)
            default:
                print("데이터 저장 실패")
            }
        }
    }
    
    @objc private func deleteButtonTapped() {
        selectedImages.removeAll()
        imageView.isHidden = true
        customButton.isHidden = false
        deleteButton.isHidden = true
    }
    
    //MARK: - Methods
    func pickImage(){
            let photoLibrary = PHPhotoLibrary.shared()
            var configuration = PHPickerConfiguration(photoLibrary: photoLibrary)

            configuration.selectionLimit = 3
            configuration.filter = .any(of: [.images])

            DispatchQueue.main.async {
                let picker = PHPickerViewController(configuration: configuration)
                picker.delegate = self
                picker.isEditing = true
                self.present(picker, animated: true, completion: nil)
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
        cell.postImageView.image = image
        cell.index = indexPath.item
        cell.delegate = self
        return cell
    }
}

extension RecipeWriteViewController: DeleteActionDelegate {
    func delete(at index: Int) {
        selectedImages.remove(at: index)
        collectionView.reloadData()
        if selectedImages.isEmpty {
            customButton.isHidden = false
        }
    }
}

extension RecipeWriteViewController: PHPickerViewControllerDelegate {
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
            DispatchQueue.main.async { [self] in
                if self.currentMode == .album {
                    self.selectedImages = selectedImages
                    print("selectedImages contents: \(self.selectedImages)")
                    
                    if self.selectedImages.isEmpty {
                        self.customButton.isHidden = false
                    } else {
                        self.customButton.isHidden = true
                        self.collectionView.isHidden = false
                        self.collectionView.reloadData() // collectionView 갱신
                    }
                }
            }
            // 이미지 피커를 닫음
            picker.dismiss(animated: true)
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
        selectedImages.append(image)
        imageView.image = image
        imageView.isHidden = false
        customButton.isHidden = true
        deleteButton.isHidden = false
        self.imageView.image = image
        picker.dismiss(animated: true)
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true
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
    
    func textViewShhouldReturn(_ textView: UITextView) -> Bool{
        // 키보드 내리면서 동작
        textView.resignFirstResponder()
        return true
    }
}

// 하단 레시피 TableView
extension RecipeWriteViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodRecipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RecipeWriteViewCell.identifier, for: indexPath) as! RecipeWriteViewCell
        let foodRecipe = foodRecipes[indexPath.row]
        cell.configure(with: foodRecipe)
        cell.backgroundColor = UIColor(named: "homeBackgroundColor")
        cell.layer.cornerRadius = 10
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        updateContentViewHeight()
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            foodRecipes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedRecipe = foodRecipes[indexPath.row]
        let stepWriteVC = StepWriteController()
        stepWriteVC.recipe = selectedRecipe
        stepWriteVC.recipeIndex = indexPath.row
        stepWriteVC.delegate = self
        let navController = UINavigationController(rootViewController: stepWriteVC)
        navController.modalPresentationStyle = .automatic
        present(navController, animated: true, completion: nil)
    }
}

extension RecipeWriteViewController: ModalViewControllerDelegate {
    func didAddCell() {
            tableView.reloadData()
        }
        
        func didUpdateCell(at index: Int, with recipe: foodRecipeDTOS) {
            foodRecipes[index] = recipe
            tableView.reloadData()
        }
}









