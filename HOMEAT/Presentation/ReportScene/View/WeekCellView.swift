//
//  WeekCellView.swift
//  HOMEAT
//
//  Created by 김민솔 on 4/11/24.
//

import Foundation
import UIKit
import Kingfisher

class WeekCellView: BaseView {
    //MARK: - Property
    var weekLabel = UILabel()
    var imageView = UIImageView()
    
    override func setConfigure() {
        weekLabel.do {
            $0.textColor = .black
            $0.text = "1W"
            $0.font = .bodyBold15
            $0.isHidden = false
        }
        imageView.do {
            $0.contentMode = .scaleAspectFit
        }
    }
    
    override func setConstraints() {
        addSubviews(weekLabel, imageView)
        
        weekLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.centerX.equalToSuperview()
            
        }
        
        imageView.snp.makeConstraints {
            $0.centerY.equalToSuperview().offset(5)
            $0.centerX.equalToSuperview()
        }
    }
    
    func updateWeekLabel(withWeekIndex index: Int) {
        weekLabel.text = "\(index)W"
    }
    
    func configure(with badgeUrl: String) {
        guard let url = URL(string: badgeUrl) else {
            return
        }
        imageView.kf.setImage(with: url)
    }
    
    func setWeekLabelHidden(_ hidden: Bool) {
        weekLabel.isHidden = hidden
    }
}
