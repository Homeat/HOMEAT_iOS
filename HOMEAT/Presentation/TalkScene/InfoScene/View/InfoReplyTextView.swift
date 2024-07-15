//
//  InfoReplyTextView.swift
//  HOMEAT
//
//  Created by 김민솔 on 7/2/24.
//

import UIKit
import SnapKit
import Then

class InfoReplyTextView: BaseView {
    
    //MARK: - Property
    private let replyTextView = UITextView()
    private let heartButton = UIButton()
    private let sendButton = UIButton()
    private var isHeartSelected = false
    private var heartCount: Int = 0
    private var keyboardHeight: CGFloat = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        setConfigure()
        setConstraints()
        setTarget()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func setConfigure() {
        
        self.do {
            $0.backgroundColor = .turquoiseDarkGray
            $0.layer.cornerRadius = 10
        }
        
        heartButton.do {
            $0.setImage(UIImage(named: "isHeartUnselected"), for: .normal)
            $0.contentMode = .scaleAspectFit
        }
        
        replyTextView.do {
            $0.font = .bodyMedium16
            $0.textColor = UIColor(named: "font5")
            $0.layer.cornerRadius = 20
            $0.backgroundColor = .turquoiseDarkGray
            $0.textContainerInset = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
            $0.textContainer.lineFragmentPadding = 0
            $0.layer.borderColor = UIColor.init(named: "font7")?.cgColor
            $0.layer.borderWidth = 1.0
            $0.isScrollEnabled = false // 초기에는 스크롤 비활성화
            $0.delegate = self
        }
        
        sendButton.do {
            $0.setImage(UIImage(named: "sendIcon"), for: .normal)
            $0.contentMode = .scaleAspectFit
        }
    }
    
    override func setConstraints() {
        addSubviews(heartButton, replyTextView, sendButton)
        
        heartButton.snp.makeConstraints {
            $0.leading.equalTo(self.snp.leading).offset(20)
            $0.centerY.equalTo(replyTextView.snp.centerY)
            $0.height.equalTo(22.6)
            $0.width.equalTo(22.6)
        }
        
        replyTextView.snp.makeConstraints {
            $0.leading.equalTo(heartButton.snp.trailing).offset(10)
            $0.top.equalTo(self.snp.top).offset(24)
            $0.trailing.equalTo(sendButton.snp.leading).offset(-10)
            $0.height.equalTo(50)
        }
        
        sendButton.snp.makeConstraints {
            $0.centerY.equalTo(replyTextView.snp.centerY)
            $0.trailing.equalTo(self.snp.trailing).inset(20)
        }
    }
    
    func setTarget() {
        heartButton.addTarget(self, action: #selector(heartButtonTapped), for: .touchUpInside)
        sendButton.addTarget(self, action: #selector(sendButtonTapped), for: .touchUpInside)
    }
    
    func updateHeartStatus(increment: Bool) {
        // Implement heart status update logic
    }
    
    @objc private func heartButtonTapped() {
        isHeartSelected.toggle()
        let imageName = isHeartSelected ? "isHeartSelected" : "isHeartUnselected"
        heartButton.setImage(UIImage(named: imageName), for: .normal)
        updateHeartStatus(increment: isHeartSelected)
    }
    
    @objc private func sendButtonTapped() {
        // Handle send button tap
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrameValue = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
        else { return }
        
        let keyboardFrame = keyboardFrameValue.cgRectValue
        keyboardHeight = keyboardFrame.height
        
        UIView.animate(withDuration: 0.3) {
            self.snp.updateConstraints {
                $0.bottom.equalToSuperview().offset(-self.keyboardHeight)
            }
            self.layoutIfNeeded()
        }
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        UIView.animate(withDuration: 0.3) {
            self.snp.updateConstraints {
                $0.bottom.equalToSuperview()
            }
            self.layoutIfNeeded()
        }
    }
}

extension InfoReplyTextView: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        let maxHeight: CGFloat = 150 // Adjust this value as needed
        let currentHeight = textView.contentSize.height
        
        textView.isScrollEnabled = currentHeight > maxHeight
        
        if currentHeight <= maxHeight {
            textView.snp.updateConstraints {
                $0.height.equalTo(currentHeight)
            }
            self.layoutIfNeeded()
        } else {
            textView.snp.updateConstraints {
                $0.height.equalTo(maxHeight)
            }
            self.layoutIfNeeded()
        }
    }
}
