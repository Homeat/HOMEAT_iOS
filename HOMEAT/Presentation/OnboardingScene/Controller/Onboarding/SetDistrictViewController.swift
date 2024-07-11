//
//  SetDistrictViewController.swift
//  HOMEAT
//
//  Created by 강삼고 on 5/20/24.
//

import Foundation
import UIKit
import Then
import SnapKit

class SetDistrictViewController: ProgressViewController {
    
    private let searchButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateProgressBar(progress: 4/6)
        setTitleLabel(title: "거주하고 있는 동네는\n어디인가요?")
        setSubTitleLabel(subtitle: "게시판 사용에 필요해요!")
        setDetailLabel(detail: "주소")
        setNextVC(nextVC: SetIncomeViewController())
        setAddTarget()
        continueButton.isEnabled = true
    }
    
    override func setConfigure() {
        super.setConfigure()
    
        searchButton.do {
            var config = UIButton.Configuration.plain()
            var attributedTitle = AttributedString("도로명, 지번, 건물명 검색")
            attributedTitle.font = .bodyMedium16
            config.attributedTitle = attributedTitle
            config.image = UIImage(named: "searchIcon")
            config.imagePadding = 125
            config.imagePlacement = .trailing
            config.cornerStyle = .medium
            config.background.backgroundColor = UIColor(r: 54, g: 56, b: 57)
            config.baseForegroundColor = UIColor(r: 216, g: 216, b: 216)
            $0.configuration = config
        }
    }
    
    override func setConstraints() {
        super.setConstraints()
        view.addSubviews(searchButton)
        
        searchButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(369)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(57)
        }
    }
    
    //MARK: - setButtonAction
    private func setAddTarget() {
        searchButton.addTarget(self, action: #selector(isSearchButtonTapped), for: .touchUpInside)
    }
    
    //MARK: - @objc Func
    @objc func isSearchButtonTapped(_ sender: Any) {
        let nextVC = SearchDistrictViewController()
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}
