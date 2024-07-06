//
//  WeekCollectionViewCell.swift
//  HOMEAT
//
//  Created by 김민솔 on 4/11/24.
//

import UIKit
import Kingfisher

class WeekCollectionViewCell: UICollectionViewCell {
    static let id = "WeekCollectionViewCell"
    
    //MARK: - Property
    var cellView = WeekCellView()
    var successMoney = UILabel()
    var failMoney = UILabel()
    var currentWeekIndex: Int = 1
    //MARK: -- Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setConfigure()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setConfigure() {
        cellView.do {
            $0.backgroundColor = UIColor(named: "turquoiseGreen")
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 50
            $0.layer.masksToBounds = true
        }
        
        successMoney.do {
            $0.font = .bodyBold15
            $0.textColor = .turquoiseGreen
        }
        
        failMoney.do {
            $0.font = .bodyBold15
            $0.textColor = UIColor(named: "turquoiseRed")
        }
    }
    
    func setConstraints() {
        contentView.addSubview(cellView)
        contentView.addSubview(successMoney)
        contentView.addSubview(failMoney)
        
        cellView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(100)
        }
        
        successMoney.snp.makeConstraints {
            $0.top.equalTo(cellView.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
            //$0.trailing.equalToSuperview().inset(18)
            $0.height.equalTo(20)
        }
        
        failMoney.snp.makeConstraints {
            $0.top.equalTo(successMoney.snp.bottom)
            $0.centerX.equalToSuperview()
            //$0.trailing.equalTo(successMoney.snp.trailing)
            $0.height.equalTo(20)
        }
    }

    func configure(with weekData: WeekLookResponseDTO ) {
        let formattedGoalMoney = weekData.goal_price.formattedWithSeparator
        let formattedExceedMoney = weekData.exceed_price.formattedWithSeparator
        successMoney.text = "\(formattedGoalMoney)원"
        failMoney.text =  "\(formattedExceedMoney)원"
        if let badgeUrl = URL(string: weekData.badge_url) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: badgeUrl) {
                    DispatchQueue.main.async {
                        self.cellView.imageView.image = UIImage(data: data)
                    }
                }
            }
        }
        switch weekData.weekStatus {
        case "SUCCESS":
            cellView.backgroundColor = UIColor(named: "turquoiseGreen")
        case "FAIL":
            cellView.backgroundColor = UIColor(named: "turquoiseRed")
        case "UNDO":
            configureAsLock()
        default:
            cellView.backgroundColor = UIColor(named: "turquoiseGray")
        }
    }
    
    func configureAsLock() {
        successMoney.text = nil
        failMoney.text = nil
        cellView.imageView.image = UIImage(named: "lockReport")
        cellView.backgroundColor = UIColor(named: "turquoiseGray")
        cellView.weekLabel.isHidden = true
    }
    func updateWeekLabel(withWeekIndex index: Int) {
        cellView.updateWeekLabel(withWeekIndex: index)
    }
    
}
