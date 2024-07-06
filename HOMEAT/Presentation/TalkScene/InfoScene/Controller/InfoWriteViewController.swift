//
//  InfoWriteViewController.swift
//  HOMEAT
//
//  Created by 김민솔 on 5/19/24.
//

import UIKit
import AVFoundation
import Photos
import PhotosUI
import SnapKit

class InfoWriteViewController: BaseViewController {
    //MARK: - Property
    private let hashContainer = UIStackView()
    private let addImageButton = UIButton()
    private let imageView = UIImageView()
    private let tagImage = UIButton()
    private let tagButton = UIButton()
    private let nameLabel = UILabel()
    private let nameTextField = UITextField()
    private let memoLabel = UILabel()
    private let memoTextView = UITextView()
    private let imageConfig = UIImage.SymbolConfiguration(pointSize: 50, weight: .light)
    var selectedButton: UIButton?
    var selectedTags: [String] = []
    var activeField: UIView?
    private var selectedImages: [UIImage] = []
    private lazy var customButton: UIButton = makeCustomButton()
    let deleteImage: UIImage? = UIImage(named: "greenDelete")
    private var isCameraAuthorized: Bool {
        AVCaptureDevice.authorizationStatus(for: .video) == .authorized
    }
    private let deleteButton = UIButton()
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
        collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: "PhotoCell")
        return collectionView
    }()
    private lazy var tagCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        //셀 만들어야 함
        collectionView.register(TagCollectionViewCell.self, forCellWithReuseIdentifier: "TagCell")
        
        return collectionView
    } ()
    private var currentMode: Mode = .camera
    let textViewPlaceHolder = "질문이나 이야기를 해보세요!"
    
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
    
    // contentSize의 변경을 관찰하여 동적으로 높이 조정
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
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        navigationController?.navigationBar.barTintColor = UIColor(named: "homeBackgroundColor")
        memoTextView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
    }
    private func setNavigationBar() {
        self.navigationItem.title = "정보토크 글쓰기"
        let titleAttributes: [NSAttributedString.Key: Any] = [
            .font:  UIFont.bodyMedium18,
            .foregroundColor: UIColor.white
        ]
        navigationController?.navigationBar.titleTextAttributes = titleAttributes
        let backbutton = UIBarButtonItem(image: UIImage.init(named: "navigationBackIcon"), style: .plain, target: self, action: #selector(customBackButtonTapped))
        backbutton.tintColor = .white
        navigationItem.leftBarButtonItem = backbutton
        navigationController?.navigationBar.barTintColor = UIColor(named: "homeBackgroundColor")
        let rightButton = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveButtonTapped))
        let rightAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.bodyMedium18,
            .foregroundColor: UIColor.white]
        rightButton.setTitleTextAttributes(rightAttributes, for: .normal)
        navigationItem.rightBarButtonItem = rightButton
    }
    //MARK: - SetUI
    override func setConfigure() {
        view.do {
            $0.backgroundColor = UIColor(named: "homeBackgroundColor")
        }
        imagePicker.do {
            $0.delegate = self
        }
        imageView.do {
            $0.layer.cornerRadius = 14
            $0.layer.masksToBounds = true
        }
        
        hashContainer.do {
            $0.distribution = .fillEqually
            $0.spacing = 20
            $0.axis = .horizontal
            $0.alignment = .fill
        }
        nameLabel.do {
            $0.text = "제목"
            $0.textColor = .turquoiseGreen
            $0.font = .bodyMedium18
        }
        nameTextField.do {
            $0.backgroundColor = .turquoiseDarkGray
            $0.layer.cornerRadius = 10
            $0.attributedPlaceholder = NSAttributedString(string: "제목을 입력하세요!", attributes: [NSAttributedString.Key.foregroundColor : UIColor(named: "warmgray")!])
            $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: $0.frame.height))
            $0.leftViewMode = .always
            $0.textColor = .warmgray
            $0.font = .bodyMedium16
            $0.delegate = self
        }
        memoLabel.do {
            $0.text = "내용"
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
        
        tagButton.do {
            $0.setTitle("해시태그를 추가해 보세요!", for: .normal)
            $0.setTitleColor(.turquoiseGreen, for: .normal)
            $0.layer.cornerRadius = 20
            $0.clipsToBounds = true
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.turquoiseGreen.cgColor
            $0.titleLabel?.font = .bodyBold15
        }
        
        tagImage.do {
            $0.setImage(UIImage(named: "greenHashTag"), for: .normal)
            $0.addTarget(self, action: #selector(navigateToTagPlusViewController), for: .touchUpInside)
        }
        deleteButton.do {
            $0.setImage(UIImage(named: "DeleteButton"), for: .normal)
            $0.imageView?.contentMode = .scaleAspectFit
            $0.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
            $0.isHidden = true
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    // 관찰자 분리.
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    override func setConstraints() {
        view.addSubviews(imageView,collectionView,tagCollectionView,tagButton,tagImage,nameLabel,
                         nameTextField,memoLabel,memoTextView)
        view.bringSubviewToFront(imageView)
        view.addSubview(deleteButton)
        view.bringSubviewToFront(deleteButton)
        view.addSubview(customButton)
        imageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(51)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(176)
            $0.width.equalTo(176)
        }
        deleteButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(47)
            $0.trailing.equalTo(imageView.snp.trailing).offset(10.8)
            $0.height.equalTo(33.2)
            $0.width.equalTo(33.2)
        }
        collectionView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.height.equalTo(176)
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(51)
        }
        tagButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(267)
            $0.leading.equalToSuperview().inset(22)
            $0.height.equalTo(40)
            $0.width.equalTo(214)
        }
        
        tagImage.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(265)
            $0.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(42)
            $0.width.equalTo(42)
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(tagButton.snp.bottom).offset(41)
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
        customButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(51)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(176)
            $0.height.equalTo(176)
        }
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
    //MARK: - @objc
    
    @objc private func customBackButtonTapped() {
        if let talkVC = self.navigationController?.viewControllers.first(where: { $0 is TalkViewController }) as? TalkViewController {
            self.navigationController?.popToViewController(talkVC, animated: true)
            talkVC.switchToInfoTalk()
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @objc func navigateToTagPlusViewController() {
        let tagplusVC = TagPlusViewController()
        tabBarController?.tabBar.isHidden = true //하단 탭바 안보이게 전환
        tagplusVC.selectedTags = self.selectedTags
        tagplusVC.delegate = self
        self.navigationController?.pushViewController(tagplusVC, animated: true)
        print("tagplus click")
    }
    
    @objc func saveButtonTapped() {
        guard let title = nameTextField.text, !title.isEmpty, !memoTextView.text.isEmpty else {
            let alert = UIAlertController(title: "입력 필요", message: "제목과 내용을 모두 입력해 주세요.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        if title.count >= 15 {
            let alert = UIAlertController(title: "제목 길이 초과", message: "제목이 너무 길어요", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        
        if memoTextView.text.count >= 130 {
            let alert = UIAlertController(title: "내용 길이 초과", message: "내용이 너무 길어요", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        let imageDataArray = selectedImages.compactMap {$0.jpegData(compressionQuality:0.8)}
        let infotalkRequest = InfoTalkSaveRequestBodyDTO (
            title: title, content: memoTextView.text, tags: selectedTags, imgUrl: imageDataArray)
        print(infotalkRequest)
        NetworkService.shared.infoTalkService.infoTalkSave(bodyDTO: infotalkRequest) { response in
            switch response {
            case .success(_):
                DispatchQueue.main.async {
                    if let talkVC = self.navigationController?.viewControllers.first(where: { $0 is TalkViewController }) as? TalkViewController {
                        self.navigationController?.popToViewController(talkVC, animated: true)
                        NotificationCenter.default.post(name: NSNotification.Name("InfoTalkDataChanged"), object: nil)
                        talkVC.switchToInfoTalk()
                    } else {
                        let talkVC = TalkViewController()
                        talkVC.navigationItem.hidesBackButton = true
                        self.navigationController?.pushViewController(talkVC, animated: true)
                        talkVC.switchToInfoTalk()
                    }
                    
                }
                print("데이터 서버 연동 성공")
            default:
                print("데이터 서버 연동 실패")
            }
        }
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let keyboardHeight = keyboardSize.height
            adjustViewForKeyboard(show: true, keyboardHeight: keyboardHeight)
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        adjustViewForKeyboard(show: false, keyboardHeight: 0)
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
    @objc func dismissKeyboard() {
        // 키보드를 내립니다.
        view.endEditing(true)
    }
    
    @objc private func deleteButtonTapped() {
        selectedImages.removeAll()
        imageView.isHidden = true
        customButton.isHidden = false
        deleteButton.isHidden = true
    }
}
//MARK: - Extension
// TextField, TextView 키보드 처리
extension InfoWriteViewController: UITextFieldDelegate, UITextViewDelegate {
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
extension InfoWriteViewController: TagDeleteActionDelegate {
    func tagDelete(at index: Int) {
        selectedTags.remove(at: index)
        tagCollectionView.reloadData()
        if selectedTags.isEmpty {
            tagButton.isHidden = false
        }
    }
}
extension InfoWriteViewController: InfoDeleteActionDelegate {
    func delete(at index: Int) {
        selectedImages.remove(at: index)
        collectionView.reloadData()
        if selectedImages.isEmpty {
            customButton.isHidden = false
        }
    }
}
extension InfoWriteViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.collectionView {
            return CGSize(width: 176, height: 176)
        } else if collectionView == tagCollectionView {
            let tag = selectedTags[indexPath.item]
            let tagWidth = tag.width(withConstrainedHeight: 40, font: UIFont.systemFont(ofSize: 15), margin: 50)
            return CGSize(width: tagWidth, height: 40)
        }
        return CGSize.zero
    }
}
extension InfoWriteViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func showAlert(message: String) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionView { //사진과 앨범 부분
            return selectedImages.count
        } else if collectionView == tagCollectionView { //태그 부분
            return selectedTags.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.collectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.reuseIdentifier, for: indexPath) as! PhotoCollectionViewCell
            let image = selectedImages[indexPath.item]
            cell.postImageView.image = image
            cell.index = indexPath.item
            cell.delegate = self
            return cell
            
        } else if collectionView == tagCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TagCell", for: indexPath) as! TagCollectionViewCell
            let tag = selectedTags[indexPath.item]
            cell.configure(with: tag, index: indexPath.item)
            cell.delegate = self
            return cell
        }
        return UICollectionViewCell()
    }
}

extension InfoWriteViewController: PHPickerViewControllerDelegate {
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
    func pickerDidCancel(_ picker: PHPickerViewController) {
            // 취소 버튼을 눌렀을 때 customButton을 다시 나타나게 함
            self.customButton.isHidden = false
            picker.dismiss(animated: true, completion: nil)
        }
}

extension InfoWriteViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
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
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            self.customButton.isHidden = false
            picker.dismiss(animated: true, completion: nil)
    }
}
extension InfoWriteViewController: TagPlusViewControllerDelegate {
    func didUpdateTags(_ tags: [String]) {
        self.selectedTags = tags
        if !selectedTags.isEmpty {
            tagButton.isHidden = true
            tagCollectionView.snp.makeConstraints {
                $0.top.equalTo(view.safeAreaLayoutGuide).offset(267)
                $0.leading.equalToSuperview().inset(22)
                $0.trailing.equalTo(tagImage.snp.leading).offset(-30)
                $0.height.equalTo(40)
            }
            tagCollectionView.reloadData()
        } else {
            tagCollectionView.isHidden = true
            tagButton.isHidden = false
        }
        
    }
}
//string 동적 계산
extension String {
    func width(withConstrainedHeight height: CGFloat, font: UIFont, margin: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect,
                                            options: [.usesLineFragmentOrigin, .usesFontLeading],
                                            attributes: [NSAttributedString.Key.font: font],
                                            context: nil)
        return ceil(boundingBox.width) + margin
    }
}
