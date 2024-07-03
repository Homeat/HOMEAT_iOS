//
//  PostTagCollectionViewCell.swift
//  HOMEAT
//
//  Created by 김민솔 on 7/2/24.
//

import UIKit
import SnapKit
import Then

class PostTagCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "PostTagCell"
    private let tagButton = UIButton()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setConfigure()
        setConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setConstraints() {
        tagButton.do {
            $0.layer.cornerRadius = 12
            $0.clipsToBounds = true
            let normalBorderColor = UIColor.turquoiseGreen
            let normalTitleColor = UIColor.turquoiseGreen
            $0.setTitleColor(normalTitleColor, for: .normal)
            $0.backgroundColor = UIColor.turquoiseDarkGray
            $0.layer.borderWidth = 2
            $0.layer.borderColor = normalBorderColor.cgColor
            $0.titleLabel?.font = .captionMedium13
        }
    }
    private func setConfigure() {
        contentView.addSubview(tagButton)
        tagButton.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func configure(with tag: String) {
            tagButton.setTitle(tag, for: .normal)
    }
}
