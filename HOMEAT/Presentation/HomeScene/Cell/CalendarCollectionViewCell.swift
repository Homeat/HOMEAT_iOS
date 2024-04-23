//
//  CalendarCollectionViewCell.swift
//  HOMEAT
//
//  Created by 강삼고 on 4/18/24.
//

import UIKit

class CalendarCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CalendarCollectionViewCell"
//    var jipbapPercentage: CGFloat = 0.0 // 집밥 퍼센테이지
//    var outPercentage: CGFloat = 0.0 // 외식/배달 퍼센테이지
    lazy var dayLabel = UILabel()
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                backgroundColor = .white
                dayLabel.textColor = .black
                
            }
            else {
                backgroundColor = UIColor(named: "coolGray4")
                dayLabel.textColor = .white
            }
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setConfigure()
        setConstraints()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setConfigure()
        setConstraints()
    }
    
    private func setConfigure() {
        self.do {
            $0.backgroundColor = UIColor(named: "coolGray4")
            $0.layer.cornerRadius = 15
            $0.clipsToBounds = true
        }
        
        dayLabel.do {
            $0.textColor = UIColor.white
            $0.font = .bodyBold15
            $0.text = "0"
        }
    }
    
    private func setConstraints() {
        self.addSubview(dayLabel)
        
        dayLabel.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
    }
    
//    private func setTextColor() {
//        if isSelected {
//            dayLabel.text
//        }
//    }
    
    func update(day: String) {
        dayLabel.text = day
    }
}
