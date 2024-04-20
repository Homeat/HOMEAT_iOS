//
//  CalenderCollectionViewCell.swift
//  HOMEAT
//
//  Created by 강삼고 on 4/18/24.
//

import UIKit

class CalenderCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CalenderCollectionViewCell"
//    var jipbapPercentage: CGFloat = 0.0 // 집밥 퍼센테이지
//    var outPercentage: CGFloat = 0.0 // 외식/배달 퍼센테이지
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
    
//    override func prepareForReuse() {
//        self.dayLabel.text = nil
//    }
//    func update(day: String) {
//        self.dayLabel.text = day
//    }
    
    private func setConfigure() {
        self.do {
            $0.backgroundColor = UIColor(named: "coolGray4")
        }
        
        dayLabel.do {
            $0.textColor = UIColor.white
            $0.font = .bodyBold15
            $0.text = "17"
        }
        

        // contentView에 원형의 코너 라디우스 적용
//        self.applyCornerRadius()
    }
    
    private func setConstraints() {
        self.addSubview(dayLabel)
        
        dayLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(10)
            $0.centerX.equalToSuperview()
        }
        
    }
    
//    func applyCornerRadius() {
//        self.contentView.layer.cornerRadius = self.bounds.width / 2
//        self.contentView.clipsToBounds = true
//    }
//    
//    func removeCornerRadius() {
//        self.contentView.layer.cornerRadius = 0
//        self.contentView.clipsToBounds = false
//    }
}
