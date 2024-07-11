//
//  RecipeWriteViewCell.swift
//  HOMEAT
//
//  Created by 이지우 on 5/24/24.
//

import Foundation
import UIKit
import SnapKit
import Then

class RecipeWriteViewCell: UITableViewCell {
    
    static let identifier = "RecipeWriteViewCell"
    //MARK: - Property
    let stepImage = UIImageView()
    let contentLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setConfigure()
        setConstraints()
    }
    
    override func layoutSubviews() {
           // 테이블 뷰 셀 사이의 간격
           super.layoutSubviews()

        let spacing: CGFloat = 12  // 상하 간격을 설정
            contentView.frame = CGRect(x: contentView.frame.origin.x,
                                       y: contentView.frame.origin.y,
                                       width: contentView.frame.size.width,
                                       height: self.frame.height - spacing)

            // contentView의 위치도 조정
            contentView.center = CGPoint(x: contentView.center.x, y: self.frame.size.height / 2)
       }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - SetUI
    private func setConfigure() {
        selectionStyle = .none
        contentView.do {
            $0.backgroundColor = UIColor(named: "coolGray4")
            $0.isUserInteractionEnabled = true
        }
        
        stepImage.do {
            $0.layer.cornerRadius = 10
            $0.layer.masksToBounds = true
        }
        
        contentLabel.do {
            $0.text = "레시피 내용이 들어갈 자리 입니다."
            $0.font = .captionMedium10
            $0.textColor = .warmgray
            $0.numberOfLines = 3
        }
    }
    
    private func setConstraints() {
        contentView.addSubviews(stepImage, contentLabel)
        contentView.layer.cornerRadius = 12.0
        contentView.layer.masksToBounds = true
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 0.5
        contentView.layer.shadowRadius = 4
        
        stepImage.snp.makeConstraints {
            $0.leading.equalTo(contentView.snp.leading).offset(8)
            $0.top.equalTo(contentView.snp.top).offset(8)
            $0.bottom.equalTo(contentView.snp.bottom).offset(-5)
            $0.width.equalTo(stepImage.snp.height)
        }
        
        contentLabel.snp.makeConstraints {
            $0.leading.equalTo(stepImage.snp.trailing).offset(20)
            $0.top.equalTo(stepImage.snp.top)
            $0.trailing.equalTo(contentView.snp.trailing).offset(-20)
        }
    }
    
    func configure(with recipe: foodRecipeDTOS) {
        if let imageData = recipe.recipePicture {
            stepImage.image = UIImage(data: imageData)
        } else {
            stepImage.image = nil
        }
        contentLabel.text = recipe.recipe
    }
}
