//
//  ContinueButton.swift
//  HOMEAT
//
//  Created by 강삼고 on 5/9/24.
//

import UIKit
import SnapKit
import Then

class ContinueButton: UIButton {
    
    static var selectedButton: TagButton?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setStyle()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ContinueButton {
    
    private func setStyle() {
        self.do {
            var config = UIButton.Configuration.plain()
            var attributedTitle = AttributedString("계속하기")
            attributedTitle.font = .bodyMedium18
            config.attributedTitle = attributedTitle
            config.background.backgroundColor = UIColor(r: 216, g: 216, b: 216)
            config.baseForegroundColor = .black
            config.cornerStyle = .medium
            $0.configuration = config
            $0.configurationUpdateHandler = { button in
                switch button.state {
                case .disabled:
                    button.configuration?.background.backgroundColor = UIColor(r: 216, g: 216, b: 216)
                default:
                    button.configuration?.background.backgroundColor = UIColor(named: "turquoiseGreen")
                }
            }
            $0.isEnabled = false
        }
    }
    
    private func setConstraints() {
        self.snp.makeConstraints {
            $0.height.equalTo(57)
        }
    }
}
