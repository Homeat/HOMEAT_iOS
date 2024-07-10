//
//  PresentIncomeView.swift
//  HOMEAT
//
//  Created by 김민솔 on 7/10/24.
//

import UIKit
import Then
import SnapKit

final class PresentIncomeView: BaseView {
    
    private let incomeLabel = UILabel()
    private let backgroundView = UIView()
    let income = UserDefaults.standard.double(forKey: "userIncome")
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func setConfigure() {
        backgroundView.do {
            $0.backgroundColor = .coolGray4
            $0.layer.cornerRadius = 10
        }
        
        incomeLabel.do {
            $0.text = "예진이다람쥐"
            $0.font = .bodyMedium16
            $0.textColor = .white
        }
    }
    
    override func setConstraints() {
        incomeLabel.text = "\(income.formattedWithSeparator) 원"
        addSubviews(backgroundView, incomeLabel)
        
        backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        incomeLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(18)
        }
    }
}
