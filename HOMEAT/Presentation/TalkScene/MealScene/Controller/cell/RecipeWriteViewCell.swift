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
    private let contentLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setConfigure()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - SetUI
    private func setConfigure() {
        contentLabel.do {
            $0.text = "레시피 내용이 들어갈 자리 입니다."
            $0.font = .captionMedium10
            $0.textColor = .warmgray
        }
    }
    
    private func setConstraints() {
        contentView.addSubviews(contentLabel)
        contentView.snp.makeConstraints {
            $0.leading.equalTo(self.snp.leading)
            $0.trailing.equalTo(self.snp.trailing)
            $0.top.equalTo(self.snp.top)
            $0.bottom.equalTo(self.snp.bottom)
        }
        
        contentLabel.snp.makeConstraints {
            $0.centerY.equalTo(contentView.snp.centerY)
            $0.leading.equalTo(contentView.snp.leading).offset(70)
        }
    }
}
