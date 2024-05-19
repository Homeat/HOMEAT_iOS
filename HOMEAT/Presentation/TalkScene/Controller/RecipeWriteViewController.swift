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

class RecipeWriteViewController: BaseViewController {
    
    var activeField: UIView?
    //MARK: - Property
    private let imagePicker = UIImagePickerController()
    private let photoButton = UIButton()
    private let container = UIStackView()
    private let breakfastButton = UIButton()
    private let lunchButton = UIButton()
    private let dinnerButton = UIButton()
    private let nameLabel = UILabel()
    private let nameTextField = UITextField()
    private let memoLabel = UILabel()
    private let memoTextView = UITextView()
    
    //MARK: - LIfeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        setUpKeyboard()
    }
    
    //MARK: - SetUI
    let textViewPlaceHolder = "오늘의 음식이 담고 있는 이야기는?"
    override func setConfigure() {
        view.do {
            $0.backgroundColor = UIColor(named: "homeBackgroundColor")
        }
        
        photoButton.do {
            var attributedTitle = AttributedString("사진 추가")
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
        
        container.do {
            $0.axis = .horizontal
            $0.distribution = .fillEqually
            $0.spacing = 28
        }
        
        breakfastButton.do {
            $0.setTitle("#아침", for: .normal)
            $0.setTitleColor(UIColor(named: "turquoiseGreen"), for: .normal)
            $0.layer.cornerRadius = 20
            $0.titleLabel?.font = .bodyBold15
            $0.backgroundColor = .turquoiseDarkGray
        }
        
        lunchButton.do {
            $0.setTitle("#점심", for: .normal)
            $0.setTitleColor(UIColor(named: "turquoiseGreen"), for: .normal)
            $0.layer.cornerRadius = 20
            $0.titleLabel?.font = .bodyBold15
            $0.backgroundColor = .turquoiseDarkGray
        }
        
        dinnerButton.do {
            $0.setTitle("#저녁", for: .normal)
            $0.setTitleColor(UIColor(named: "turquoiseGreen"), for: .normal)
            $0.layer.cornerRadius = 19
            $0.titleLabel?.font = .bodyBold15
            $0.backgroundColor = .turquoiseDarkGray
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
    }
    
    override func setConstraints() {
        view.addSubviews(photoButton, container, nameLabel, nameTextField, memoLabel, memoTextView)
        
        container.addArrangedSubview(breakfastButton)
        container.addArrangedSubview(lunchButton)
        container.addArrangedSubview(dinnerButton)
        
        photoButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(150)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(176)
            $0.width.equalTo(176)
        }
        
        container.snp.makeConstraints {
            $0.top.equalTo(photoButton.snp.bottom).offset(36)
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
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
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
}

//MARK: - Extension
extension RecipeWriteViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
}

// TextField, TextView 키보드 처리
extension RecipeWriteViewController: UITextFieldDelegate, UITextViewDelegate {
    func adjustViewForKeyboard(show: Bool, keyboardHeight: CGFloat) {
        guard let activeField = self.activeField else { return }
        
        let adjustmentHeight = (show ? keyboardHeight : 0)
        
        // 현재 활성화된 텍스트 입력 뷰가 키보드에 가리지 않도록 화면을 올립니다.
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



