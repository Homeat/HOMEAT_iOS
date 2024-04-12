//
//  WeekCollectionViewCell.swift
//  HOMEAT
//
//  Created by 김민솔 on 4/11/24.
//

import UIKit

class WeekCollectionViewCell: UICollectionViewCell {
    static let id = "WeekCollectionViewCell"
    
    //MARK: - Property
    var cellView = WeekCellView()
    var successMoney = UILabel()
    var failMoney = UILabel()
    
    var model: WeekCellModel? {
        didSet {
            guard let model = model else { return }
            cellView.updateWeekLabel(withWeekIndex: model.weekIndex)
            cellView.imageView.image = UIImage(named: model.imageName)
        }
    }
    
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
            $0.text = "50,000원"
            $0.font = .bodyBold15
            $0.textColor = .turquoiseGreen
        }
        
        failMoney.do {
            $0.text = "4,500원"
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
            $0.trailing.equalToSuperview().inset(18)
            $0.height.equalTo(20)
        }
        
        failMoney.snp.makeConstraints {
            $0.top.equalTo(successMoney.snp.bottom)
            $0.trailing.equalTo(successMoney.snp.trailing)
            $0.height.equalTo(20)
        }
    }
    
    func updateWeekLabel(withWeekIndex index: Int) {
        cellView.updateWeekLabel(withWeekIndex: index)
    }
    
}
