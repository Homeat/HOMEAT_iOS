//
//  RecipeStepCell.swift
//  HOMEAT
//
//  Created by 이지우 on 5/17/24.
//

import Foundation
import UIKit
import Then
import SnapKit

class RecipeStepCell: UITableViewCell {
    
    //MARK: - Property
    private let line = UIView()
    private let stepLabel = UILabel()
    private let photoView = UIImageView()
    private let containerView = UIView()
    private let contentLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setConfigure()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - SetUI
    private func setConfigure() {
        
        self.selectionStyle = .none
        
        line.do {
            $0.backgroundColor = .warmgray10
        }
        
        stepLabel.do {
            $0.text = "STEP 1"
            $0.font = .bodyMedium16
            $0.textColor = .warmgray6
        }
        
        photoView.do {
            $0.backgroundColor = .turquoiseDarkGray
            $0.contentMode = .scaleAspectFill
            $0.layer.cornerRadius = 9
            $0.clipsToBounds = true
        }
        
        containerView.do {
            $0.backgroundColor = .turquoiseDarkGray
            $0.layer.cornerRadius = 10
        }
        
        contentLabel.do {
            $0.text = "들어갈내용"
            $0.textColor = .warmgray
            $0.font = .bodyMedium16
            $0.contentMode = .scaleAspectFit
            $0.numberOfLines = 0
        }
    }
    
    private func setConstraints() {
            
            contentView.addSubviews(line, stepLabel, photoView, containerView)
            containerView.addSubview(contentLabel)
            
            line.snp.makeConstraints {
                $0.top.equalTo(contentView.snp.top)
                $0.leading.equalTo(contentView.snp.leading).offset(21)
                $0.trailing.equalTo(contentView.snp.trailing).inset(21)
                $0.height.equalTo(1)
            }
            
            stepLabel.snp.makeConstraints {
                $0.top.equalTo(line.snp.bottom).offset(15)
                $0.leading.equalTo(line.snp.leading)
                $0.trailing.equalTo(line.snp.trailing)
            }
            
            photoView.snp.makeConstraints {
                $0.top.equalTo(stepLabel.snp.bottom).offset(15)
                $0.leading.equalTo(line.snp.leading)
                $0.width.equalTo(contentView.snp.width).multipliedBy(1.0/3.0)
                $0.height.equalTo(photoView.snp.width)
            }
            
            containerView.snp.makeConstraints {
                $0.top.equalTo(photoView.snp.bottom).offset(20)
                $0.leading.equalTo(line.snp.leading)
                $0.trailing.equalTo(line.snp.trailing)
                $0.bottom.equalTo(contentView.snp.bottom).inset(20)
            }
            
            contentLabel.snp.makeConstraints {
                $0.top.equalTo(containerView.snp.top).offset(10)
                $0.leading.equalTo(containerView.snp.leading).offset(10)
                $0.trailing.equalTo(containerView.snp.trailing).inset(10)
                $0.bottom.equalTo(containerView.snp.bottom).offset(-10)
            }
        }
    
    func configure(with recipe: FoodTalkRecipe, step: Int) {
        stepLabel.text = "STEP \(step + 1)"
        contentLabel.text = recipe.recipe
        if let imageUrlString = recipe.foodRecipeImages.first, let imageUrl = URL(string: imageUrlString) {
            photoView.loadImage(from: imageUrl)
        } else {
            photoView.image = nil
        }
    }
}

extension UIImageView {
    func loadImage(from url: URL, placeholder: UIImage? = nil) {
        self.image = placeholder
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {return}
            
            guard let data = data, let image = UIImage(data: data) else {return}
            DispatchQueue.main.async {
                self.image = image
                self.layoutIfNeeded()
            }
        }.resume()
    }
}
