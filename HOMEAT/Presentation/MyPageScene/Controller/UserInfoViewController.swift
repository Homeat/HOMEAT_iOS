//
//  UserInfoViewController.swift
//  HOMEAT
//
//  Created by 강석호 on 4/3/24.
//

import Foundation
import UIKit
import Then
import SnapKit
import AVFoundation
import Photos
import PhotosUI

class UserInfoViewController: BaseViewController {
    
    // MARK: Property
//    private let customButton = UIButton()
    private let profileview = UIView()
    private let profileImageView = UIImageView()
    private let newProfileImageView = CircularImageView()
    private let profileEditIcon = UIButton()
    private let userInfoTableView = UITableView()
    var nickName: String?
    var emailAdress: String?
    var birth: String?
    var incom: Int = 0
    private var currentMode: Mode = .camera
    // MARK: - 탭바제거
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
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setTapBarHidden()
        setupTableView()
        updateMyInfo()
        setNavigation()
    }
    
    override func setConfigure() {
        view.do {
            $0.backgroundColor = UIColor(r: 30, g: 32, b: 33)
        }
        profileview.do {
            $0.backgroundColor = .turquoiseGreen
            $0.layer.cornerRadius = 50
            $0.layer.borderColor = UIColor.white.cgColor
            $0.layer.borderWidth = 3
            $0.layer.masksToBounds = true
            $0.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(buttonTapped)))

        }
        profileImageView.do {
            $0.backgroundColor = .turquoiseGreen
            $0.image = UIImage.init(named: "profileIcon")
            $0.layer.masksToBounds = true
            $0.layer.cornerRadius = 10
        }
        newProfileImageView.do {
            
            $0.isHidden = false
        }
        profileEditIcon.do {
            $0.setImage(UIImage(named: "EditIcon"), for: .normal)
            $0.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        }
    }
    
    override func setConstraints() {
        
        userInfoTableView.isScrollEnabled = false
        
        view.addSubviews(profileview, userInfoTableView)
        profileview.addSubview(profileImageView)
        view.addSubview(newProfileImageView)
        view.addSubview(profileEditIcon)
        profileview.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(35)
            $0.width.height.equalTo(110)
        }
        profileImageView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(20)
        }
        newProfileImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(30)
            $0.width.height.equalTo(130)
        }
        userInfoTableView.snp.makeConstraints {
            $0.top.equalTo(newProfileImageView.snp.bottom).offset(45)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(240)
        }
        profileEditIcon.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(130)
            $0.bottom.equalTo(userInfoTableView.snp.top).offset(-35)
            $0.width.height.equalTo(40)
        }
    }
    
    private func setNavigation() {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.title = "회원 정보 수정"
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.tintColor = .white
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "수정", style: .plain, target: self, action: #selector(editButtonTapped))
        self.navigationItem.rightBarButtonItem?.tintColor = .turquoiseGreen
    }
    
    private func setTapBarHidden() {
        
        self.tabBarController?.tabBar.isHidden = true
    }
    
    private func setupTableView() {
        userInfoTableView.delegate = self
        userInfoTableView.dataSource = self
        userInfoTableView.register(UserInfoTableViewCell.self, forCellReuseIdentifier: "UserInfoTableViewCell")
        
        userInfoTableView.separatorStyle = .singleLine
        userInfoTableView.separatorColor = UIColor.white
        userInfoTableView.separatorInset = .zero
    }
    private func updateMyInfo() {
        NetworkService.shared.myPageService.mypageDetail() { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let data):
                guard let data = data.data else { return }
                let url = data.profileImgUrl
                DispatchQueue.main.async {
                    guard let url = URL(string: data.profileImgUrl) else {return}
                    self.newProfileImageView.kf.setImage(with: url)
                    
                }
                self.nickName = data.nickname
                self.emailAdress = data.email
                UserDefaults.standard.set(data.email, forKey: "userEmail")
                self.incom = data.income
                UserDefaults.standard.set(data.income, forKey: "userIncome")
                self.birth = data.birth
                DispatchQueue.main.async {
                    self.userInfoTableView.reloadData()
                }
                print(data)
            default:
                print("서버연동 실패")
                
            }
        }
    }
    //MARK: - 사진과 앨범 파트
    private var isCameraAuthorized: Bool {
        AVCaptureDevice.authorizationStatus(for: .video) == .authorized
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
//    @objc private func editButtonTapped() {
//        
//    }
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
    @objc func buttonTapped(){
        
        let actionSheet = UIAlertController(title: "사진 선택", message: "원하는 방법을 선택하세요", preferredStyle: .actionSheet)
        let takePhotoAction = UIAlertAction(title: "사진 촬영", style: .default) { _ in
            self.currentMode = .camera
            self.openCamera()
        }
        let chooseFromLibraryAction = UIAlertAction(title: "앨범에서 사진 선택", style: .default) { _ in
            self.currentMode = .album
            self.touchUpImageAddButton(button: self.profileEditIcon)
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
}

extension UserInfoViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
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
        profileview.isHidden = true
        newProfileImageView.isHidden = false
        if let imageData = image.jpegData(compressionQuality: 0.8) {
            uploadImage(imageData: imageData)
        }
    }
    
    private func uploadImage(imageData: Data) {
        let image = ProfileEditRequestBodyDTO(profileImg: imageData)
        print(image)
        NetworkService.shared.myPageService.mypageProfile(bodyDTO: image) { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let data):
                print("서버 연동 성공")
            default:
                print("서버 연동 실패")
            }

        }
//        NetworkService.shared.myPageService.myProfileDelete() { [weak self] response in
//            guard let self = self else { return }
//            switch response {
//            case .success(_):
//                print("서버 연동 성공")
//
//            default:
//                print("서버 연동 실패")
//                
//            }
//            
//        }

    }
}
extension UserInfoViewController: PHPickerViewControllerDelegate {
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

extension UserInfoViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserInfoTableViewCell", for: indexPath) as! UserInfoTableViewCell
        cell.selectionStyle = .none
        switch indexPath.row {
        case 0:
            cell.titleLabel.text = "닉네임"
            cell.descriptionLabel.text = nickName
        case 1:
            cell.titleLabel.text = "생일"
            cell.arrowButton.isHidden = true
            cell.descriptionLabel.text = birth
        case 2:
            cell.titleLabel.text = "이메일 주소"
            cell.arrowButton.isHidden = true
            cell.descriptionLabel.text = emailAdress
        case 3:
            cell.titleLabel.text = "한 달 수입"
            cell.descriptionLabel.text = "\(incom.formattedWithSeparator) 원"
        default:
            break
        }
        cell.bringSubviewToFront(cell.arrowButton)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            switch indexPath.row {
            case 0:
                let userInfoModifyViewController = UserInfoModifyViewController()
                self.navigationController?.pushViewController(userInfoModifyViewController, animated: true)
            case 3:
                let userIncomeEditViewController = EditIncomeViewController()
                self.navigationController?.pushViewController(userIncomeEditViewController, animated: true)
                
            default:
                break
            }
        }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    

}

