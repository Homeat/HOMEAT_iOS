//
//  InfoReplyTableViewCell.swift
//  HOMEAT
//
//  Created by 김민솔 on 7/1/24.
//

import UIKit
import Then
import SnapKit

protocol InfoTalkReplyCellDelgate: AnyObject {
    func replyDeclareButtonTapped(_ cell: InfoReplyTableViewCell)
    func replyButtonTapped(_ cell: InfoReplyTableViewCell)
}

class InfoReplyTableViewCell: UITableViewCell {
    weak var delegate: InfoTalkReplyCellDelgate?
    
    static let identifier = "InfoReplyTableViewCell"
    
    //MARK: - Properties
    private let replyProfile = UIImageView()
    private let replyNickname = UILabel()
    private let replyContent = UILabel()
    private let replyDeclare = UIButton()
    private let replyDate = UILabel()
    private let replyButton = UIButton()
    private let replyAddProfile = UIImageView()
    private let line = UIView()
    
    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureViews() {
        replyProfile.do {
            $0.image = UIImage(named: "profileIcon")
            $0.backgroundColor = UIColor.turquoiseDarkGray
            $0.layer.cornerRadius = 20
            $0.layer.borderWidth = 1.3
            $0.layer.borderColor = UIColor.white.cgColor
            $0.contentMode = .scaleAspectFit
        }
        replyAddProfile.do {
            $0.image = UIImage(named: "replyCharacter")
            $0.backgroundColor = UIColor.turquoiseDarkGray
            $0.layer.cornerRadius = 10
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
            $0.numberOfLines = 0
        }
        replyDeclare.do {
            $0.setImage(UIImage(named: "dots"), for: .normal)
            $0.setTitleColor(UIColor.warmgray8, for: .normal)
            $0.titleLabel?.font = .captionMedium10
            $0.addTarget(self, action: #selector(declareButtonTapped), for: .touchUpInside)
        }
        replyDate.do {
            $0.text = "mm월 dd일 12:00시"
            $0.font = .captionMedium10
            $0.textColor = UIColor.warmgray8
        }
        replyButton.do {
            $0.setImage(UIImage(named: "chat"), for: .normal)
            $0.addTarget(self, action: #selector(replyButtonTapped), for: .touchUpInside)
        }
        line.do {
            $0.backgroundColor = UIColor.turquoiseDarkGray
        }
    }
    
    private func setConstraints() {
        contentView.addSubview(replyProfile)
        contentView.addSubview(replyAddProfile)
        contentView.addSubviews(replyNickname, replyContent, replyDeclare, replyDate, replyButton, line)
        
        replyProfile.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.leading.equalToSuperview().inset(20)
            $0.height.width.equalTo(37.8)
        }
        
        replyAddProfile.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.leading.equalToSuperview().inset(70)
            $0.height.width.equalTo(20)
        }
        
        replyNickname.snp.makeConstraints {
            $0.top.equalTo(replyProfile.snp.top)
            $0.leading.equalTo(replyAddProfile.snp.trailing).offset(11.2)
        }
        
        replyContent.snp.makeConstraints {
            $0.top.equalTo(replyNickname.snp.bottom).offset(4)
            $0.leading.equalTo(replyNickname.snp.leading)
            $0.trailing.equalToSuperview().inset(22)
        }
        
        replyDeclare.snp.makeConstraints {
            $0.top.equalTo(replyAddProfile.snp.top)
            $0.trailing.equalToSuperview().inset(22)
        }
        
        replyDate.snp.makeConstraints {
            $0.top.equalTo(replyContent.snp.bottom).offset(8)
            $0.leading.equalTo(replyNickname.snp.leading)
            $0.bottom.equalToSuperview().inset(16)
        }
        
        replyButton.snp.makeConstraints {
            $0.centerY.equalTo(replyDate.snp.centerY)
            $0.leading.equalTo(replyDate.snp.trailing).offset(8)
            $0.width.height.equalTo(13)
        }
        
        line.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.height.equalTo(1)
            $0.leading.trailing.equalToSuperview()
        }
    }
    
    func updateContent(comment: InfoTalkComments) {
        replyProfile.isHidden = false
        replyAddProfile.isHidden = true
        
        replyNickname.text = comment.commentNickName
        replyContent.text = comment.content
        
        setDateLabel(from: comment.createdAt)
    }
    
    func updateContent(reply: InfoTalkReplies) {
        replyProfile.isHidden = true
        replyAddProfile.isHidden = false
        replyButton.isHidden = true
        replyNickname.text = reply.replyNickName
        replyContent.text = reply.content
        
        setDateLabel(from: reply.createdAt)
    }
    
    private func setDateLabel(from dateString: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        
        if let date = dateFormatter.date(from: dateString) {
            let displayFormatter = DateFormatter()
            displayFormatter.dateFormat = "MM월 dd일 HH:mm"
            replyDate.text = displayFormatter.string(from: date)
        } else {
            replyDate.text = dateString
        }
    }
    
    //MARK: - @objc
    @objc func declareButtonTapped() {
        delegate?.replyDeclareButtonTapped(self)
    }
    
    @objc func replyButtonTapped() {
        delegate?.replyButtonTapped(self)
    }
}
