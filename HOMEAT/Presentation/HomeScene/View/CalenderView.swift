//
//  CalenderView.swift
//  HOMEAT
//
//  Created by 강삼고 on 4/10/24.
//

import Foundation
import UIKit
import SnapKit
import Then

class CalenderView: BaseView {
    
    //MARK: - component
    private let leftHole = UIImageView()
    private let rightHole = UIImageView()
    private let circleSize: CGFloat = 15
    
    //MARK: - Function
    //MARK: - setConfigure
    override func setConfigure() {
        super.setConfigure()
        
        self.backgroundColor = UIColor(named: "coolGray4")
        self.layer.cornerRadius = 14
        self.clipsToBounds = true
        
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
    }
    
    //MARK: - setConstraints
    override func setConstraints() {
        super.setConstraints()
        self.addSubviews(leftHole, rightHole)
        
        leftHole.snp.makeConstraints {
            $0.top.equalTo(self).offset(15)
            $0.width.equalTo(15.1)
            $0.height.equalTo(15.1)
            $0.leading.equalTo(self).offset(15)
        }
        
        rightHole.snp.makeConstraints {
            $0.top.equalTo(self).offset(15)
            $0.width.equalTo(15.1)
            $0.height.equalTo(15.1)
            $0.trailing.equalTo(self).offset(-15)
        }
    }
}
