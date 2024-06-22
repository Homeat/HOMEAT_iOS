//
//  FoodTalkCollectionViewCell.swift
//  HOMEAT
//
//  Created by 이지우 on 4/7/24.
//

import UIKit
import SnapKit

class FoodTalkCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "FoodTalkCollectionViewCell"
    
    let foodName: UILabel = {
        let label = UILabel()
        label.font = .bodyMedium15
        label.textColor = .white
        
        return label
    }()
    
    let foodImageView: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 11
        image.image = UIImage(named: "plusIcon")
        
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 4
        layer.cornerRadius = 10
        layer.masksToBounds = false
        
        addSubviews(foodName, foodImageView)
        
        foodImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(14)
            make.height.equalTo(106)
            make.width.equalTo(125)
        }
        
        foodName.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(11)
        }
    }
}
