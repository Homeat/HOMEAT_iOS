//
//  RecipeStepCell.swift
//  HOMEAT
//
//  Created by 이지우 on 5/17/24.
//

import Foundation
import UIKit
import Then
import SnapKit

class RecipeStepCell: UITableViewCell {
    
    //MARK: - Property
    private let line = UIView()
    private let stepLabel = UILabel()
    private let photoView = UIImageView()
    private let view = UIView()
    
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
        
        self.selectionStyle = .none
        
        line.do {
            $0.backgroundColor = .warmgray10
        }
        
        stepLabel.do {
            $0.text = "STEP 1"
            $0.font = .bodyMedium16
            $0.textColor = .warmgray6
        }
        
        photoView.do {
            $0.backgroundColor = .turquoiseDarkGray
            $0.contentMode = .scaleAspectFit
            $0.layer.cornerRadius = 9
        }
        
        view.do {
            $0.backgroundColor = .turquoiseDarkGray
            $0.layer.cornerRadius = 10
        }
    }
    
    private func setConstraints() {
        
        addSubviews(line, stepLabel, photoView, view)
        
        line.snp.makeConstraints {
            $0.top.equalTo(self.snp.top)
            $0.leading.equalTo(self.snp.leading).offset(21)
            $0.trailing.equalTo(self.snp.trailing).inset(21)
            $0.height.equalTo(1)
        }
        
        stepLabel.snp.makeConstraints {
            $0.top.equalTo(line.snp.bottom).offset(15)
            $0.leading.equalTo(line.snp.leading)
            $0.trailing.equalTo(line.snp.trailing)
        }
        
        photoView.snp.makeConstraints {
            $0.top.equalTo(stepLabel.snp.bottom).offset(15)
            $0.leading.equalTo(line.snp.leading)
            $0.height.equalTo(111)
            $0.width.equalTo(111)
        }
        
        view.snp.makeConstraints {
            $0.top.equalTo(photoView.snp.bottom).offset(20)
            $0.leading.equalTo(line.snp.leading)
            $0.trailing.equalTo(line.snp.trailing)
            $0.bottom.equalTo(self.snp.bottom).inset(20)
        }
    }
}
