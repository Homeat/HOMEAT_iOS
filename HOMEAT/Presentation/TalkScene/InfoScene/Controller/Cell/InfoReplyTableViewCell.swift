//
//  InfoReplyTableViewCell.swift
//  HOMEAT
//
//  Created by 김민솔 on 7/1/24.
//

import UIKit
import Then
import SnapKit

class InfoReplyTableViewCell: UITableViewCell {
    static let identifier = "InfoReplyTableViewCell"
    //MARK: - Property
    private let replyProfile = UIImageView()
    private let replyNickname = UILabel()
    private let replyContent = UILabel()
    private let replyDeclare = UIButton()
    private let replyDate = UILabel()
    private let line = UIView()
    
    //MARK: -- Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setConfigure()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setConfigure() {
        replyProfile.do {
            $0.image = UIImage(named: "profileIcon")
            $0.backgroundColor = UIColor.turquoiseDarkGray
            $0.layer.cornerRadius = 20
            $0.layer.borderWidth = 1.3
            $0.layer.borderColor = UIColor.white.cgColor
            $0.contentMode = .scaleAspectFit
        }
        
        replyNickname.do {
            $0.text = "닉네임"
            $0.font = .captionMedium13
            $0.textColor = UIColor.turquoiseGreen
        }
        
        replyContent.do {
            $0.text = "댓글 내용이 들어갈 자리입니다."
            $0.font = .captionMedium13
            $0.textColor = .white
        }
        
        replyDeclare.do {
            $0.setTitle("신고하기", for: .normal)
            $0.setTitleColor(UIColor.warmgray8, for: .normal)
            $0.titleLabel?.font = .captionMedium10
        }
        
        replyDate.do {
            $0.text = "mm월 dd일 12:00시"
            $0.font = .captionMedium10
            $0.textColor = UIColor.warmgray8
        }
        
        line.do {
            $0.backgroundColor = UIColor.turquoiseDarkGray
        }
    }
    private func setConstraints() {
        contentView.addSubviews(replyProfile, replyNickname, replyContent, replyDeclare, replyDate, line)
        
        replyProfile.snp.makeConstraints {
            $0.top.equalTo(contentView.snp.top).inset(16)
            $0.leading.equalTo(contentView.snp.leading).inset(20)
            $0.height.equalTo(37.8)
            $0.width.equalTo(37.8)
        }
        
        replyNickname.snp.makeConstraints {
            $0.top.equalTo(replyProfile.snp.top)
            $0.leading.equalTo(replyProfile.snp.trailing).offset(11.2)
        }
        
        replyContent.snp.makeConstraints {
            $0.bottom.equalTo(replyProfile.snp.bottom)
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
        
        line.snp.makeConstraints {
            $0.bottom.equalTo(contentView.snp.bottom)
            $0.height.equalTo(1)
            $0.leading.equalTo(contentView.snp.leading)
            $0.trailing.equalTo(contentView.snp.trailing)
        }
    }

}
