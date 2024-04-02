//
//  StartView.swift
//  HOMEAT
//
//  Created by 강석호 on 3/27/24.
//

import Foundation
import UIKit
import SnapKit
import Then


class HomeView: BaseView {
    //MARK: - component
    private let leftHole = UIImageView()
    private let rightHole = UIImageView()
    private let character = UIImageView()
    private let goalLabel = UILabel()
    private let leftMoneyLabel = UILabel()
    
    //MARK: - Function
    override func setConfigure() {
        super.setConfigure()
        setStyle()
        self.backgroundColor = UIColor(named: "coolGray4")
        self.layer.cornerRadius = 13.2
        self.clipsToBounds = true
        
    }
    
    override func setConstraints() {
        super.setConstraints()
        self.addSubviews(leftHole, rightHole, character)
        
        leftHole.snp.makeConstraints{
            $0.top.equalTo(self).offset(15)
            $0.width.equalTo(15.1)
            $0.height.equalTo(15.1)
            $0.leading.equalTo(self).offset(15)
        }
        
        rightHole.snp.makeConstraints{
            $0.top.equalTo(self).offset(15)
            $0.width.equalTo(15.1)
            $0.height.equalTo(15.1)
            $0.trailing.equalTo(self).offset(-15)
        }
        
        
        
    }
    
    private func setStyle() {
        
        let circleSize: CGFloat = 16
        
        leftHole.do {
            $0.frame.size = CGSize(width: circleSize, height: circleSize)
            $0.backgroundColor = UIColor(named: "homeBackgroundColor")
            $0.layer.cornerRadius = circleSize / 2
            $0.clipsToBounds = true
        }
        
        rightHole.do {
            $0.frame.size = CGSize(width: circleSize, height: circleSize)
            $0.backgroundColor = UIColor(named: "homeBackgroundColor")
            $0.layer.cornerRadius = circleSize / 2
            $0.clipsToBounds = true
        }
        
        character.do {
            $0.image = UIImage(named: "baseCharacter")
        }
    }
    
}
