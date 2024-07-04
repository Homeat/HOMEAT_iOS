//
//  PhotoCollectionViewCell.swift
//  HOMEAT
//
//  Created by 김민솔 on 5/19/24.
//

import UIKit
import SnapKit
import Then
//MARK: 앨범 사진 셀

protocol InfoDeleteActionDelegate: AnyObject {
    func delete(at index: Int)
}

class PhotoCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "PhotoCell"
    //MARK: -- Property
    var postImageView = UIImageView()
    var deleteButton = UIButton()
    weak var delegate: InfoDeleteActionDelegate?
    var index: Int?
    override init(frame: CGRect) {
        super.init(frame: frame)
        setConfigure()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConfigure() {
        postImageView.do {
            $0.contentMode = .scaleAspectFill
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 14
            $0.layer.masksToBounds = true
        }
        
        deleteButton.do {
            $0.setImage(UIImage(named: "DeleteButton"), for: .normal)
            $0.imageView?.contentMode = .scaleAspectFit
            $0.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        }
    }
    
    private func setConstraints() {
        contentView.addSubviews(postImageView,deleteButton)
        
        postImageView.snp.makeConstraints {
            $0.top.equalTo(contentView.snp.top)
            $0.leading.equalTo(contentView.snp.leading).offset(25)
            $0.trailing.equalTo(contentView.snp.trailing)
            $0.bottom.equalTo(contentView.snp.bottom)
        }
        
        deleteButton.snp.makeConstraints {
            $0.top.equalTo(postImageView.snp.top).offset(9)
            $0.trailing.equalTo(postImageView.snp.trailing).inset(10.8)
            $0.height.equalTo(33.2)
            $0.width.equalTo(33.2)
        }
        
    }
    
    @objc private func deleteButtonTapped() {
        guard let index = index else { return }
        delegate?.delete(at: index)
    }
}
