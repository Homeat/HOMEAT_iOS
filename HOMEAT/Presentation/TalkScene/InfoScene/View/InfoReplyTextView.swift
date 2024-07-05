//
//  InfoReplyTextView.swift
//  HOMEAT
//
//  Created by 김민솔 on 7/2/24.
//

import Foundation
import UIKit
import SnapKit
import Then

class InfoReplyTextView: BaseView {
    
    //MARK: - Property
    let replyTextField = UITextField()
    private let heartButton = UIButton()
    private let sendButton = UIButton()
    private var isHeartSelected = false
    private var heartCount: Int = 0
    override init(frame: CGRect) {
        super.init(frame: frame)
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
        
        replyTextField.do {
            $0.placeholder = "댓글을 남겨보세요."
            $0.font = .bodyMedium16
            $0.textColor = UIColor(named: "font5")
            $0.layer.cornerRadius = 20
            $0.backgroundColor = .turquoiseDarkGray
            $0.attributedPlaceholder = NSAttributedString(string: "댓글을 남겨보세요.", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "font5") ?? UIColor.gray])
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: $0.frame.height))
            $0.leftViewMode = .always
            $0.layer.borderColor = UIColor.init(named: "font7")?.cgColor
            $0.layer.borderWidth = 1.0
        }
        
        sendButton.do {
            $0.setImage(UIImage(named: "sendIcon"), for: .normal)
            $0.contentMode = .scaleAspectFit
        }
    }
    
    override func setConstraints() {
        addSubviews(heartButton, replyTextField, sendButton)
        
        heartButton.snp.makeConstraints {
            $0.leading.equalTo(self.snp.leading).offset(20)
            $0.centerY.equalTo(replyTextField.snp.centerY)
            $0.height.equalTo(22.6)
            $0.width.equalTo(22.6)
        }
        
        replyTextField.snp.makeConstraints {
            $0.leading.equalTo(heartButton.snp.trailing).offset(10)
            $0.top.equalTo(self.snp.top).offset(24)
            $0.bottom.equalTo(self.snp.bottom).inset(24)
            $0.trailing.equalTo(self.snp.trailing).inset(20)
        }
        
        sendButton.snp.makeConstraints {
            $0.centerY.equalTo(replyTextField.snp.centerY)
            $0.trailing.equalTo(replyTextField.snp.trailing).inset(8)
        }
    }
    
    func setTarget() {
        heartButton.addTarget(self, action: #selector(heartButtonTapped), for: .touchUpInside)
    }
    func updateHeartStatus(increment: Bool) {
        
    }
    @objc private func heartButtonTapped() {
        isHeartSelected.toggle()
        let imageName = isHeartSelected ? "isHeartSelected" : "isHeartUnselected"
        heartButton.setImage(UIImage(named: imageName), for: .normal)
        updateHeartStatus(increment: isHeartSelected)
    }
    
    
}
    

