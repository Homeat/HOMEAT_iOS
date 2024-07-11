//
//  TagCollectionViewCell.swift
//  HOMEAT
//
//  Created by 김민솔 on 6/20/24.
//

import UIKit

protocol TagDeleteActionDelegate: AnyObject {
    func tagDelete(at index: Int)
}

class TagCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "TagCell"
    var selectedTags: [String] = []
    var index : Int?
    weak var delegate: TagDeleteActionDelegate?
    let deleteImage: UIImage? = UIImage(named: "greenDelete")
    private let tagButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setConfigure()
        setConstraints()
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setConfigure() {
        tagButton.do {
            $0.setTitle("할인", for: .normal)
            $0.layer.cornerRadius = 19
            $0.clipsToBounds = true
            $0.setTitleColor(UIColor.turquoiseGreen, for: .normal)
            $0.backgroundColor = UIColor.turquoiseDarkGray
            $0.layer.borderColor = UIColor.turquoiseGreen.cgColor
            $0.layer.borderWidth = 2
            $0.semanticContentAttribute = .forceRightToLeft
            $0.titleLabel?.font = .bodyBold15
            $0.setImage(deleteImage, for: .normal)
            $0.imageEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
            $0.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)

        }
    }
    
    func setConstraints() {
        contentView.addSubview(tagButton)
        tagButton.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func configure(with tag:String, index: Int) {
        tagButton.setTitle("\(tag)", for: .normal)
        self.index = index
    }
    
    @objc private func deleteButtonTapped() {
        guard let index = index else { return }
        delegate?.tagDelete(at: index)
    }
}
