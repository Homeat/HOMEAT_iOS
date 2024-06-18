//
//  IngredientView.swift
//  HOMEAT
//
//  Created by 이지우 on 5/16/24.
//

import Foundation
import UIKit
import SnapKit
import Then

class IngredientView: UITableViewHeaderFooterView {
    
    private let recipeLabel = UILabel()
    private let ingredientLabel = UILabel()
    private let line = UIView()
    private let view = UIView()
    
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setConfigure()
        setConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - SetUI
    private func setConfigure() {
        
        recipeLabel.do {
            $0.text = "레시피"
            $0.font = .bodyMedium18
            $0.textColor = .turquoiseGreen
        }
        
        line.do {
            $0.backgroundColor = .warmgray10
        }
        
        ingredientLabel.do {
            $0.text = "재료"
            $0.font = .bodyMedium16
            $0.textColor = .warmgray6
        }
        
        view.do {
            $0.backgroundColor = .turquoiseDarkGray
            $0.layer.cornerRadius = 10
        }
        
    }
    
    private func setConstraint() {
        addSubviews(recipeLabel, ingredientLabel, line, view)
        
        recipeLabel.snp.makeConstraints {
            $0.leading.equalTo(self.snp.leading).offset(21)
            $0.top.equalTo(self.snp.top).offset(44)
        }
        
        line.snp.makeConstraints {
            $0.top.equalTo(recipeLabel.snp.bottom).offset(15)
            $0.leading.equalTo(recipeLabel.snp.leading)
            $0.trailing.equalTo(self.snp.trailing).inset(21)
            $0.height.equalTo(1)
        }
        
        ingredientLabel.snp.makeConstraints {
            $0.leading.equalTo(recipeLabel)
            $0.top.equalTo(line.snp.bottom).offset(15)
        }
        
        view.snp.makeConstraints {
            $0.top.equalTo(ingredientLabel.snp.bottom).offset(15)
            $0.leading.equalTo(recipeLabel.snp.leading)
            $0.trailing.equalTo(line.snp.trailing)
            $0.height.equalTo(163)
        }
    }
        
}
    
