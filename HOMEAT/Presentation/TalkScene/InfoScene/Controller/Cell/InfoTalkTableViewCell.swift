//
//  InfoTableViewCell.swift
//  HOMEAT
//
//  Created by 김민솔 on 5/19/24.
//

import UIKit
import Then
import SnapKit
import Alamofire
import Kingfisher

class InfoTalkTableViewCell: UITableViewCell {
    
    static let identifier = "InfoTalkTableViewCell"
    
    //MARK: -- Property
    var postImageView = UIImageView()
    var titleLabel = UILabel()
    var dateLabel = UILabel()
    var contentLabel = UILabel()
    var heartImage = UIImageView()
    var heartLabel = UILabel()
    var chatImage = UIImageView()
    var chatLabel = UILabel()
    
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
        postImageView.do {
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 10
        }
        
        titleLabel.do {
            $0.font = .bodyMedium15
            $0.textColor = .white
            $0.numberOfLines = 0
        }
        
        dateLabel.do {
            $0.font = .bodyMedium10
            $0.textColor = .warmgray8
            $0.numberOfLines = 0
        }
        
        contentLabel.do {
            $0.font = .bodyMedium10
            $0.textColor = .warmgray8
            $0.numberOfLines = 0
        }
        
        heartLabel.do {
            $0.textColor = .turquoiseGreen
            $0.font = .bodyMedium10
            $0.numberOfLines = 0
        }
        chatImage.do {
            $0.image = UIImage(named: "isReply")
        }
        heartImage.do {
            $0.image = UIImage(named: "isSmallHeartSelected")
        }
        chatLabel.do {
            $0.textColor = .turquoiseGreen
            $0.numberOfLines = 0
            $0.font = .bodyMedium10
        }
    }
    
    func setConstraints() {
        backgroundColor = UIColor(r: 30, g: 32, b: 33)
        contentView.addSubviews(titleLabel,dateLabel,contentLabel,postImageView,heartImage,heartLabel,chatImage,chatLabel)
        contentView.layer.borderWidth = 1.0
        contentView.layer.cornerRadius = 10.0
        contentView.layer.masksToBounds = true
        contentView.backgroundColor = .turquoiseGray
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(19)
            $0.leading.equalTo(postImageView.snp.trailing).offset(18)
        }
        
        dateLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(27)
            $0.leading.equalTo(titleLabel.snp.trailing).offset(10)
            $0.trailing.equalToSuperview().inset(10)
            $0.bottom.equalTo(titleLabel.snp.bottom)
        }
        
        postImageView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.top)
            $0.leading.equalToSuperview().inset(20)
            $0.width.equalTo(78)
            $0.height.equalTo(73)
        }
        
        contentLabel.snp.makeConstraints {
            $0.leading.equalTo(titleLabel.snp.leading)
            $0.trailing.equalToSuperview().inset(10)
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.height.equalTo(56)
        }
        
        heartImage.snp.makeConstraints {
            $0.top.equalTo(chatLabel.snp.top)
            $0.width.equalTo(11.9)
            $0.height.equalTo(11)
        }
        
        heartLabel.snp.makeConstraints {
            $0.leading.equalTo(heartImage.snp.trailing).offset(5)
            $0.centerY.equalTo(heartImage.snp.centerY)
        }
        
        chatImage.snp.makeConstraints {
            $0.leading.equalTo(heartLabel.snp.trailing).offset(9)
            $0.centerY.equalTo(heartImage.snp.centerY)
            $0.width.equalTo(11.9)
            $0.height.equalTo(11)
        }
        
        chatLabel.snp.makeConstraints {
            $0.top.equalTo(contentLabel.snp.bottom).offset(9)
            $0.leading.equalTo(chatImage.snp.trailing).offset(5)
            $0.trailing.equalToSuperview().inset(20)
            $0.centerY.equalTo(chatImage.snp.centerY)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 18, right: 0))
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(with infoTalk: InfoTalk) {
        let photoUrl = infoTalk.url
        let url = URL(string: photoUrl)
        let formattedCreatedAt = formatDateString(infoTalk.createdAt)
        titleLabel.text = infoTalk.title
        dateLabel.text = formattedCreatedAt
        contentLabel.text = infoTalk.content
        heartLabel.text = "\(infoTalk.love ?? 0)"
        print(heartLabel.text)
        chatLabel.text = "\(infoTalk.commentNumber ?? 0)"
        postImageView.kf.setImage(with: url)
    }
}
extension InfoTalkTableViewCell {
    func formatDateString(_ dateString: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSS"
        if let date = formatter.date(from: dateString) {
            formatter.dateFormat = "M월 d일 HH:mm"
            return formatter.string(from: date)
        } else {
            return ""
        }
    }
}
