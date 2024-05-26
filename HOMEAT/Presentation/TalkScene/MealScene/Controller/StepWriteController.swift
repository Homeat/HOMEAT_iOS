//
//  StepWriteController.swift
//  HOMEAT
//
//  Created by 이지우 on 5/24/24.
//

import Foundation
import UIKit
import Then
import SnapKit

protocol ModalViewControllerDelegate: AnyObject {
    func didAddCell()
}

class StepWriteController: BaseViewController, UITextViewDelegate {
    
    weak var delegate: ModalViewControllerDelegate?
    //MARK: - Property
    private let recipeWriteLabel = UILabel()
    private let photoButton = UIButton()
    private let photoActionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
    private let imagePicker = UIImagePickerController()
    private let line = UIView()
    private let recipTextView = UITextView()
    private let saveButton = UIButton()
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        setKeyboard()
    }
    
    //MARK: - SetUI
    let textViewPlaceHolder = "레시피를 작성해주세요!"
    override func setConfigure() {
        view.do {
            $0.backgroundColor = UIColor(named: "homeBackgroundColor")
        }
        
        recipeWriteLabel.do {
            $0.text = "레시피 작성"
            $0.textColor = .white
            $0.font = .bodyMedium18
        }
        
        photoButton.do {
            var config = UIButton.Configuration.plain()
            let pointSize = CGFloat(30)
            let imageConfig = UIImage.SymbolConfiguration(pointSize: pointSize)
            config.image = UIImage(named: "addIcon")
            config.preferredSymbolConfigurationForImage = imageConfig
            config.imagePlacement = .top
            config.background.backgroundColor = .turquoiseDarkGray
            config.baseForegroundColor = .white
            config.imagePadding = 19.7
            $0.configuration = config
            $0.layer.cornerRadius = 14
            $0.addTarget(self, action: #selector(photoButtonTapped), for: .touchUpInside)
        }
        
        photoActionSheet.do {
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
        
        line.do {
            $0.backgroundColor = .turquoiseDarkGray
        }
        
        recipTextView.do {
            $0.backgroundColor = .turquoiseDarkGray
            $0.layer.cornerRadius = 10
            $0.text = textViewPlaceHolder
            $0.textColor = .warmgray
            $0.textContainerInset = UIEdgeInsets(top: 13, left: 20, bottom: 0, right: 0)
            $0.font = .bodyMedium16
            $0.delegate = self
        }
        
        saveButton.do {
            $0.setTitle("저장하기", for: .normal)
            $0.setTitleColor(.black, for: .normal)
            $0.layer.cornerRadius = 10
            $0.backgroundColor = .turquoiseGreen
            $0.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        }
    }
    
    override func setConstraints() {
        view.addSubviews(recipeWriteLabel, photoButton, line, recipTextView, saveButton)
        
        recipeWriteLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.centerX.equalTo(photoButton.snp.centerX)
        }
        
        photoButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(190)
            $0.height.equalTo(201)
            $0.width.equalTo(226)
        }
        
        line.snp.makeConstraints {
            $0.top.equalTo(photoButton.snp.bottom).offset(45)
            $0.leading.equalToSuperview().offset(21)
            $0.trailing.equalToSuperview().offset(-21)
            $0.height.equalTo(1)
        }
        
        recipTextView.snp.makeConstraints {
            $0.top.equalTo(line).offset(40)
            $0.leading.equalTo(line.snp.leading)
            $0.trailing.equalTo(line.snp.trailing)
            $0.height.equalTo(170)
        }
        
        saveButton.snp.makeConstraints {
            $0.leading.equalTo(recipTextView.snp.leading)
            $0.trailing.equalTo(recipTextView.snp.trailing)
            $0.top.equalTo(recipTextView.snp.bottom).offset(40)
            $0.height.equalTo(57)
        }
    }
    
    func setNavigationBar() {
        self.navigationItem.title = "레시피 작성"
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.tintColor = .white
    }
    
    func setKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == textViewPlaceHolder {
            textView.text = nil
            textView.textColor = .warmgray
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.text = textViewPlaceHolder
            textView.textColor = .warmgray
        }
    }
    
    private func setTapBarHidden() {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    //MARK: - Method
    private func openCamera() {
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true)
    }
    
    private func openPhotoLibrary() {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true)
    }
    
    //MARK: - @objc
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let keyboardHeight = keyboardSize.height
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardHeight
            }
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    @objc func photoButtonTapped(_ sender: Any) {
        present(photoActionSheet, animated: true)
    }
    
    @objc func saveButtonTapped(_ sender: Any) {
        //데이터 전달
        delegate?.didAddCell()
        self.dismiss(animated: true, completion: nil)
    }
}

extension StepWriteController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
            let resizeImage = image.resizeImage(toFit: photoButton)
            photoButton.setImage(resizeImage, for: .normal)
            photoButton.setTitle("", for: .normal)
        }
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}


