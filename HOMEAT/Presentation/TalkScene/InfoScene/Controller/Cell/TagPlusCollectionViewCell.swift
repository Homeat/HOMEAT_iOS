//
//  TagPlusCollectionViewCell.swift
//  HOMEAT
//
//  Created by 김민솔 on 6/20/24.
//

import UIKit
import SnapKit
import Then

protocol TagPlusDelegate: AnyObject {
    func tagChangeByClick(isSelect: Bool, tag: String)
}

class TagPlusCollectionViewCell: UICollectionViewCell {
    weak var delegate: TagPlusDelegate?
    static let reuseIdentifier = "TagPlusCell"
    private var tagTitle: String = ""
    var selectedTags: [String] = []
    var onSelectionChange: (() -> Void)?
    private let tagButton = UIButton()
    var onSelectStatusChange: ((Bool) -> Void)?
    override init(frame: CGRect) {
        super.init(frame: frame)
        setConfigure()
        setConstraints()
    }
    private func setConstraints() {
        contentView.addSubview(tagButton)
        tagButton.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    private func setConfigure() {
        tagButton.do {
            $0.layer.cornerRadius = 22.5
            $0.clipsToBounds = true
            let normalBorderColor = UIColor.warmgray.cgColor
            let normalTitleColor = UIColor.warmgray
            $0.setTitleColor(normalTitleColor, for: .normal)
            $0.backgroundColor = UIColor.turquoiseDarkGray
            $0.layer.borderWidth = 2
            $0.layer.borderColor = normalBorderColor
            $0.titleLabel?.font = .bodyMedium15
            $0.addTarget(self, action: #selector(tagButtonTapped), for: .touchUpInside)
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with tag: String, isSelected: Bool) {
        self.tagTitle = tag
        tagButton.setTitle(tag, for: .normal)
        let titleSize = NSString(string: tag).size(withAttributes: [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)
        ])
        let buttonWidth = titleSize.width + 40
        tagButton.widthAnchor.constraint(equalToConstant: buttonWidth).isActive = true
        updateSelectedState(isSelected)
    }
    private func updateSelectedState(_ isSelected: Bool) {
        let selectedBorderColor = UIColor.turquoiseGreen.cgColor
        let normalBorderColor = UIColor.warmgray.cgColor
        tagButton.layer.borderColor = isSelected ? selectedBorderColor : normalBorderColor
        let selectedTitleColor = UIColor.turquoiseGreen
        let normalTitleColor = UIColor.warmgray
        tagButton.setTitleColor(isSelected ? selectedTitleColor : normalTitleColor, for: .normal)
        tagButton.isSelected = isSelected
    }
    @objc func tagButtonTapped() {
        tagButton.isSelected.toggle()
        updateSelectedState(tagButton.isSelected)
        delegate?.tagChangeByClick(isSelect: tagButton.isSelected, tag: tagTitle)
    }
}
