//
//  InstagramAccountView.swift
//  HOMEAT
//
//  Created by 강석호 on 4/2/24.
//

import Foundation
import UIKit
import Then
import SnapKit

final class InstagramAccountView: BaseView {
    
    private let accountLabel = UILabel()
    private let backgroundView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func setConfigure() {
        backgroundView.do {
            $0.backgroundColor = .white
            $0.layer.cornerRadius = 8
        }
        
        accountLabel.do {
            $0.text = "@yejin_woo"
            $0.font = .bodyBold15
            $0.textColor = .black
        }
        
    }
    override func setConstraints() {
        
        addSubviews(backgroundView, accountLabel)
        
        backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        accountLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
