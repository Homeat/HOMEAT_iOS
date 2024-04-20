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
    private let previousButton = UIButton()
    private let nextButton = UIButton()
    private let dateLabel = UILabel()
    private let weekStackView = UIStackView()
    
    
    //MARK: - Function
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureWeekLabel()
    }
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
        
        previousButton.do {
            $0.setImage(UIImage(named: "previousButtonIcon"), for: .normal)
        }
        
        nextButton.do {
            $0.setImage(UIImage(named: "nextButtonIcon"), for: .normal)
        }
        
        dateLabel.do {
            $0.text = "2024년 4월"
            $0.font = .bodyMedium18
            $0.textColor = .white
        }
        
        weekStackView.do {
            $0.spacing = 33
            $0.axis = .horizontal
            $0.alignment = .fill
            $0.distribution = .fillEqually
        }
    }
    
    //MARK: - setConstraints
    override func setConstraints() {
        super.setConstraints()
        self.addSubviews(leftHole, rightHole, previousButton, nextButton, dateLabel, weekStackView)
        
        leftHole.snp.makeConstraints {
            $0.top.equalTo(self).offset(10)
            $0.width.equalTo(15)
            $0.height.equalTo(15)
            $0.leading.equalTo(self).offset(11)
        }
        
        rightHole.snp.makeConstraints {
            $0.top.equalTo(self).offset(10)
            $0.width.equalTo(15)
            $0.height.equalTo(15)
            $0.trailing.equalTo(self).offset(-11)
        }
        
        previousButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(22)
            $0.leading.equalToSuperview().offset(107)
        }
        
        nextButton.snp.makeConstraints {
            $0.top.equalTo(previousButton)
            $0.trailing.equalToSuperview().offset(-108)
        }
        
        dateLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalTo(previousButton)
        }
        
        weekStackView.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
        }
    }
    
    private func configureWeekLabel() {
        let dayOfTheWeek = ["일", "월", "화", "수", "목", "금", "토"]
        
        for i in 0..<7 {
            let label = UILabel()
            label.text = dayOfTheWeek[i]
            label.textColor = UIColor.white
            label.textAlignment = .center
            label.font = .bodyMedium18
            self.weekStackView.addArrangedSubview(label)
        }
    }
}
