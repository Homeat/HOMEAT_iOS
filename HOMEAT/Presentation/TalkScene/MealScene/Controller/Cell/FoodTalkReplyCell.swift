//
//  FoodTalkReplyCell.swift
//  HOMEAT
//
//  Created by 이지우 on 5/6/24.
//

import Foundation
import UIKit
import Then
import SnapKit

protocol FoodTalkReplyCellDelgate: AnyObject {
    func replyDeclareButtonTapped(_ cell: FoodTalkReplyCell)
    func replyButtonTapped(_ cell: FoodTalkReplyCell)
}

class FoodTalkReplyCell: UITableViewCell {
    weak var delegate: FoodTalkReplyCellDelgate?
    //MARK: - Property
    private let replyProfile = UIImageView()
    private let replyNickname = UILabel()
    private let replyContent = UILabel()
    private let replyDeclare = UIButton()
    private let replyDate = UILabel()
    private let replyButton = UIButton()
    private let replyAddProfile = UIImageView()
    private let line = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - SetUI
    private func setUI() {
    
        replyProfile.do {
            $0.image = UIImage(named: "profileIcon")
            $0.backgroundColor = UIColor(named: "turquoiseDarkGray")
            $0.layer.cornerRadius = 20
            $0.layer.borderWidth = 1.3
            $0.layer.borderColor = UIColor.white.cgColor
            $0.contentMode = .scaleAspectFit
        }
        
        replyAddProfile.do {
            $0.image = UIImage(named: "replyCharacter")
            $0.backgroundColor = UIColor.turquoiseDarkGray
            $0.layer.cornerRadius = 20
            $0.layer.borderWidth = 5
            $0.layer.borderColor = UIColor.white.cgColor
            $0.contentMode = .scaleAspectFit
        }
        
        replyNickname.do {
            $0.text = "닉네임"
            $0.font = .captionMedium13
            $0.textColor = UIColor(named: "turquoiseGreen")
        }
        
        replyContent.do {
            $0.text = "댓글 내용이 들어갈 자리입니다."
            $0.font = .captionMedium13
            $0.textColor = .white
        }
        
        replyDeclare.do {
            $0.setImage(UIImage(named: "dots"), for: .normal)
            $0.setTitleColor(UIColor(named: "warmgray8"), for: .normal)
            $0.titleLabel?.font = .captionMedium10
            $0.addTarget(self, action: #selector(declareButtonTapped), for: .touchUpInside)
        }
        
        replyDate.do {
            $0.text = "mm월 dd일 12:00시"
            $0.font = .captionMedium10
            $0.textColor = UIColor(named: "warmgray8")
        }
        
        replyButton.do {
            $0.setImage(UIImage(named: "icon-4"), for: .normal)
            $0.addTarget(self, action: #selector(replyButtonTapped), for: .touchUpInside)
        }
        
        line.do {
            $0.backgroundColor = UIColor(named: "turquoiseDarkGray")
        }
    }
    
    private func setConstraints() {
        contentView.addSubview(replyProfile)
        contentView.addSubviews(replyNickname, replyContent, replyDeclare, replyDate,replyButton, line)
        replyNickname.snp.makeConstraints {
            $0.top.equalTo(replyProfile.snp.top)
            $0.leading.equalTo(replyProfile.snp.trailing).offset(11.2)
        }
        replyProfile.snp.remakeConstraints {
            $0.top.equalTo(contentView.snp.top).inset(16)
            $0.leading.equalTo(contentView.snp.leading).inset(20)
            $0.height.equalTo(37.8)
            $0.width.equalTo(37.8)
        }
        replyContent.snp.makeConstraints {
            $0.top.equalTo(replyNickname.snp.bottom)
            $0.leading.equalTo(replyNickname.snp.leading)
        }
        
        replyDeclare.snp.makeConstraints {
            $0.top.equalTo(replyProfile.snp.top)
            $0.trailing.equalToSuperview().inset(22)
        }
        
        replyDate.snp.makeConstraints {
            $0.top.equalTo(replyContent.snp.bottom).offset(8)
            $0.leading.equalTo(replyNickname.snp.leading)
        }
        
        replyButton.snp.makeConstraints {
            $0.top.equalTo(replyContent.snp.bottom).offset(5)
            $0.leading.equalTo(replyDate.snp.trailing).offset(8)
            $0.width.equalTo(13)
        }
        line.snp.makeConstraints {
            $0.bottom.equalTo(contentView.snp.bottom)
            $0.height.equalTo(1)
            $0.leading.equalTo(contentView.snp.leading)
            $0.trailing.equalTo(contentView.snp.trailing)
        }
    }
    
    func updateContent(comment: FoodTalkComment) {
        
        replyNickname.text = comment.commentNickName
        replyContent.text = comment.content
        
        let dateString = comment.createdAt
        print("Original Date String: \(dateString)")
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        
        var displayDate = ""
        if let date = dateFormatter.date(from: dateString) {
            let displayFormatter = DateFormatter()
            displayFormatter.dateFormat = "MM월 dd일 HH:mm"
            displayDate = displayFormatter.string(from: date)
            print("Converted Date: \(displayDate)")
        } else {
            print("날짜 형식 변환 실패")
            // 기본 형식으로 설정
            displayDate = dateString
        }
        replyDate.text = displayDate
    }
    
    func updateContent(reply: FoodTalkReply) {
        
        replyNickname.text = reply.replyNickName
        replyContent.text = reply.content

        let dateString = reply.createdAt
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        
        var displayDate = ""
        if let date = dateFormatter.date(from: dateString) {
            let displayFormatter = DateFormatter()
            displayFormatter.dateFormat = "MM월 dd일 HH:mm"
            displayDate = displayFormatter.string(from: date)
        } else {
            displayDate = dateString
        }
        replyDate.text = displayDate
    }
    
    //MARK: - @objc
    @objc func declareButtonTapped() {
        delegate?.replyDeclareButtonTapped(self)
    }
    
    @objc func replyButtonTapped() {
        delegate?.replyButtonTapped(self)
    }
}


