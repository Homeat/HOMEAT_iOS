//
//  PresentInfoView.swift
//  HOMEAT
//
//  Created by 강석호 on 4/7/24.
//

import Foundation
import UIKit
import Then
import SnapKit

final class PresentInfoView: BaseView {
    
    private let infoLabel = UILabel()
    private let backgroundView = UIView()
    let userName = UserDefaults.standard.string(forKey: "userNickname") ?? "사용자"
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func setConfigure() {
        backgroundView.do {
            $0.backgroundColor = .coolGray4
            $0.layer.cornerRadius = 10
        }
        
        infoLabel.do {
            $0.text = "예진이다람쥐"
            $0.font = .bodyMedium16
            $0.textColor = .white
        }
    }
    
    override func setConstraints() {
        infoLabel.text = userName
        addSubviews(backgroundView, infoLabel)
        
        backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        infoLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(18)
        }
    }
}
