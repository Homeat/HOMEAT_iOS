//
//  PayCheckDetailViewController.swift
//  HOMEAT
//
//  Created by 강삼고 on 4/10/24.
//

import UIKit
import SnapKit
import Then

class PayCheckDetailViewController: BaseViewController {
    
    //MARK: - Property
    private let payCheckView = PayCheckView()
    private let devideLine = UIView()
    private let homefoodCheckView = HomefoodCheckView()
    private let eatoutCheckView = EatoutCheckView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
    }
    
    override func setConfigure() {
        view.backgroundColor = UIColor(named: "homeBackgroundColor")
        
        devideLine.do {
            $0.backgroundColor = UIColor(r: 102, g: 102, b: 102)
        }
    }
    
    override func setConstraints() {
        view.addSubviews(payCheckView, devideLine, homefoodCheckView, eatoutCheckView)
        
        payCheckView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(136)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-21)
            $0.bottom.equalToSuperview().offset(-520)
        }
        
        devideLine.snp.makeConstraints {
            $0.top.equalTo(payCheckView.snp.bottom).offset(26.5)
            $0.height.equalTo(1)
            $0.leading.equalTo(payCheckView)
            $0.trailing.equalTo(payCheckView)
        }
        
        homefoodCheckView.snp.makeConstraints {
            $0.top.equalTo(devideLine.snp.bottom).offset(26.5)
            $0.leading.equalTo(devideLine)
            $0.trailing.equalTo(devideLine)
            $0.height.equalTo(96)
        }
        
        eatoutCheckView.snp.makeConstraints {
            $0.top.equalTo(homefoodCheckView.snp.bottom).offset(20)
            $0.leading.equalTo(devideLine)
            $0.trailing.equalTo(devideLine)
            $0.height.equalTo(96)
        }
    }
    
    private func setNavigationBar() {
        self.navigationItem.title = "지출확인"
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.tintColor = .white
    }
}
