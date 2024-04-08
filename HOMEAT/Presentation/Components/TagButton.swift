//
//  TagButton.swift
//  HOMEAT
//
//  Created by 강삼고 on 4/5/24.
//

import UIKit
import SnapKit
import Then

enum ButtonTitle: String {
    case shop = "#장보기"
    case eatOut = "#외식비"
    case delivery = "#배달비"
}

class TagButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setStyle()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TagButton {
    
    private func setStyle() {
        self.do {
            var config = UIButton.Configuration.plain()
            var attributedTitle = AttributedString("#장보기")
            attributedTitle.font = .bodyMedium15
            config.attributedTitle = attributedTitle
            config.background.backgroundColor = UIColor(r: 54, g: 56, b: 57)
            config.baseForegroundColor = UIColor(named: "turquoiseGreen")
            $0.configuration = config
            $0.layer.cornerRadius = 20
            $0.clipsToBounds = true
            $0.layer.borderWidth = 0
            $0.layer.borderColor = UIColor(named: "turquoiseGreen")?.cgColor
        }
    }
    
    private func setConstraints() {
        self.snp.makeConstraints {
            $0.height.equalTo(40)
            $0.width.equalTo(94)
        }
    }
    
}
