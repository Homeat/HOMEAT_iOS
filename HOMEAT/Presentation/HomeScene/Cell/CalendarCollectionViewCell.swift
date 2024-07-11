//
//  CalendarCollectionViewCell.swift
//  HOMEAT
//
//  Created by 강삼고 on 4/18/24.
//

import UIKit

class CalendarCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CalendarCollectionViewCell"
    lazy var dayLabel = UILabel()
    
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
            $0.font = .bodyBold18
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
    
    func update(day: String) {
        dayLabel.text = day
    }
}
