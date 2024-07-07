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
            $0.contentMode = .scaleAspectFit
        }
    }
    
    private func setConstraint() {
        addSubviews(recipeLabel)
        
        recipeLabel.snp.makeConstraints {
            $0.leading.equalTo(self.snp.leading).offset(21)
            $0.top.equalTo(self.snp.top).offset(44)
            $0.bottom.equalTo(self.snp.bottom).offset(-10)
        }
    }
        
}
    
