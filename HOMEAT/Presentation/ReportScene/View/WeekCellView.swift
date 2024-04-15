//
//  WeekCellView.swift
//  HOMEAT
//
//  Created by 김민솔 on 4/11/24.
//

import Foundation
import UIKit

class WeekCellView: BaseView {
    //MARK: - Property
    var weekLabel = UILabel()
    var imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func setConfigure() {
        weekLabel.do {
            $0.textColor = .black
            $0.text = "1W"
            $0.font = .bodyBold15
        }
        imageView.do {
            $0.contentMode = .scaleAspectFit
            $0.image = UIImage(named: "born_meat")
        }
    }
    
    override func setConstraints() {
        addSubviews(weekLabel,imageView)
        
        weekLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.centerX.equalToSuperview()
        }
        
        imageView.snp.makeConstraints {
            $0.top.equalTo(weekLabel.snp.bottom)
            $0.centerX.equalToSuperview()
        }
    }
    
    func updateWeekLabel(withWeekIndex index: Int) {
        weekLabel.text = "\(index)W"
    }
    
}
