//
//  PayDetailTableViewCell.swift
//  HOMEAT
//
//  Created by 김민솔 on 7/4/24.
//

import UIKit

class PayDetailTableViewCell: UITableViewCell {
    
    static let identifier = "PayDetailTableViewCell"

    // MARK: - Properties
    private let homefoodIcon = UIImageView()
    private let eatoutIcon = UIImageView()
    private let homefoodTitleLabel = UILabel()
    private let tagButton = UIButton()
    private let expenseLabel = UILabel()
    private let leftMoneyLabel = UILabel()
    private let memoLabel = UILabel()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setConfigure()
        setConstraints()
        self.backgroundColor = UIColor(named: "homeBackgroundColor")

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 18, right: 0))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConfigure() {
        contentView.backgroundColor = UIColor(r: 54, g: 56, b: 57)
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 10
        
        homefoodIcon.do {
            $0.image = UIImage(named: "homefoodIcon")
        }
        eatoutIcon.do {
            $0.image = UIImage(named: "eatoutIcon")
        }
        homefoodTitleLabel.do {
            $0.font = .bodyMedium15
            $0.textColor = .white
        }
        
        tagButton.do {
            $0.layer.cornerRadius = 7
            $0.clipsToBounds = true
            $0.layer.borderWidth = 1
            $0.titleLabel?.font = UIFont(name: "NotoSansKR-Medium", size: 7.3)
        }
        
        expenseLabel.do {
            $0.font = .bodyMedium15
        }
        
        leftMoneyLabel.do {
            $0.font = .captionMedium10
            $0.textColor = .white
        }
        
        memoLabel.do {
            $0.numberOfLines = 2
            $0.font = UIFont(name: "NotoSansKR-Medium", size: 11)
            $0.textColor = UIColor(r: 216, g: 216, b: 216)
        }
    }
    
    private func setConstraints() {
        contentView.addSubviews(homefoodIcon, homefoodTitleLabel, tagButton, expenseLabel, leftMoneyLabel, memoLabel)
        
        homefoodIcon.snp.makeConstraints {
            $0.top.equalToSuperview().offset(21)
            $0.leading.equalToSuperview().offset(15)
        }
        
        homefoodTitleLabel.snp.makeConstraints {
            $0.centerY.equalTo(homefoodIcon).offset(-1)
            $0.leading.equalTo(homefoodIcon.snp.trailing).offset(11)
        }
        
        tagButton.snp.makeConstraints {
            $0.centerY.equalTo(homefoodTitleLabel)
            $0.leading.equalTo(homefoodTitleLabel.snp.trailing).offset(12)
            $0.height.equalTo(16)
            $0.width.equalTo(43)
        }
        
        expenseLabel.snp.makeConstraints {
            $0.centerY.equalTo(tagButton).offset(-4)
            $0.trailing.equalToSuperview().offset(-17)
        }
        
        memoLabel.snp.makeConstraints {
            $0.top.equalTo(homefoodTitleLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(39)
        }
        
        leftMoneyLabel.snp.makeConstraints {
            $0.top.equalTo(memoLabel.snp.top).offset(-1)
            $0.trailing.equalToSuperview().offset(-17)
        }
    }
    
    func configure(type: String, amount: String, tag: String, leftAmount: String, memo: String) {
        homefoodTitleLabel.text = type
        tagButton.setTitle(tag, for: .normal)
        expenseLabel.text = "\(amount) 원"
        leftMoneyLabel.text = "\(leftAmount) 원"
        memoLabel.text = memo
        
        if type == "집밥" {
            homefoodIcon.image = UIImage(named: "homefoodIcon")
            expenseLabel.textColor = UIColor(named: "turquoiseGreen")
            tagButton.setTitleColor(UIColor(named: "turquoiseGreen"), for: .normal)
            tagButton.layer.borderColor = UIColor(named: "turquoiseGreen")?.cgColor
        } else if type == "배달/외식" {
            homefoodIcon.image = UIImage(named: "eatoutIcon")
            expenseLabel.textColor = UIColor(named: "turquoisePurple")
            tagButton.setTitleColor(UIColor(named: "turquoisePurple"), for: .normal)
            tagButton.layer.borderColor = UIColor(named: "turquoisePurple")?.cgColor
        }
    }
}
