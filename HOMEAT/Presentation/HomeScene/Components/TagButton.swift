//
//  TagButton.swift
//  HOMEAT
//
//  Created by 강삼고 on 4/5/24.
//

import UIKit
import SnapKit
import Then

class TagButton: UIButton {
    
    static var selectedButton: TagButton?
    
    override var isSelected: Bool {
        didSet {
            setButtonUI()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setStyle()
        setConstraints()
        setAddTaget()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TagButton {
    
    private func setStyle() {
        self.do {
            var config = UIButton.Configuration.plain()
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
//            $0.width.equalTo(94)
        }
    }
    
    private func setAddTaget() {
        self.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
    }
    
    private func setButtonUI() {
        if isSelected {
            layer.borderWidth = 2
        } else {
            layer.borderWidth = 0
        }
    }
    
    //MARK: - @objc Func
    @objc func buttonClicked(_ sender: TagButton) {
        sender.isSelected.toggle()
        if sender != TagButton.selectedButton {
            TagButton.selectedButton?.isSelected = false
        }
        TagButton.selectedButton = sender
    }
}
