//
//  PhotoViewCell.swift
//  HOMEAT
//
//  Created by 이지우 on 5/19/24.
//

import Foundation
import UIKit
import SnapKit
import Then

class PhotoViewCell: UICollectionViewCell {
    
    let imageView = UIImageView()
    let deleteButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setConfigure()
        setConstraints()
    }
    
    //MARK: - SetUI
    private func setConfigure() {
        imageView.do {
            $0.contentMode = .scaleAspectFill
            $0.layer.cornerRadius = 14
        }
        
        deleteButton.do {
            $0.imageView?.contentMode = .scaleAspectFit
            $0.setImage(UIImage(named: "ImageDeleteButton"), for: .normal)
        }
    }
    
    private func setConstraints() {
        contentView.addSubview(imageView)
        
        imageView.snp.makeConstraints {
            $0.top.equalTo(contentView.snp.top)
            $0.leading.equalTo(contentView.snp.leading)
            $0.trailing.equalTo(contentView.snp.trailing)
            $0.bottom.equalTo(contentView.snp.bottom)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
