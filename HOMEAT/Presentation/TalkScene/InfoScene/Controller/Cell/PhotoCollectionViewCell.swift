//
//  PhotoCollectionViewCell.swift
//  HOMEAT
//
//  Created by 김민솔 on 5/19/24.
//

import UIKit
//MARK: 앨범 사진 셀
class PhotoCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "PhotoCell"
    //MARK: -- Property
    var postImageView = UIImageView()
    var deleteButton = UIButton()
    
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
        }
        
        deleteButton.do {
            $0.setImage(UIImage(named: "deleteButton"), for: .normal)
            $0.imageView?.contentMode = .scaleAspectFit
        }
    }
    
    private func setConstraints() {
        contentView.addSubviews(postImageView,deleteButton)
        
        postImageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(25)
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        deleteButton.snp.makeConstraints {
            $0.top.equalTo(postImageView.snp.top).offset(9)
            $0.trailing.equalTo(postImageView.snp.trailing).inset(10.8)
            $0.height.equalTo(33.2)
            $0.width.equalTo(33.2)
        }
        
    }
}
