//
//  SearchDistrictViewController.swift
//  HOMEAT
//
//  Created by 강삼고 on 5/20/24.
//

import Foundation
import UIKit
import Then
import SnapKit

class SearchDistrictViewController: BaseViewController {
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let searchView = UIView()
    private let searchTextField = UITextField()
    private let searchButton = UIButton()
    private let currentLocationButton = UIButton()
    private let testLabel = UILabel()
    
    //MARK: - Function
    override func viewDidLoad() {
        super.viewDidLoad()
        setAddTarget()
        setNavigationBar()
    }
    
    // MARK: - setConfigure
    override func setConfigure() {
        view.do {
            $0.backgroundColor = UIColor(named: "homeBackgroundColor")
        }
        
        searchView.do {
            $0.backgroundColor = UIColor(r: 54, g: 56, b: 57)
            $0.layer.cornerRadius = 10
            $0.layer.masksToBounds = true
        }
        
        searchTextField.do {
            $0.attributedPlaceholder = NSAttributedString(string: "동명 (읍, 면)으로 검색 (ex. 서초동)", attributes: [NSAttributedString.Key.foregroundColor: UIColor(r: 204, g: 204, b: 204)])
            $0.font = .bodyMedium16
            $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 18, height: 0))
            $0.leftViewMode = .always
        }
        
        searchButton.do {
            var config = UIButton.Configuration.plain()
            config.image = UIImage(named: "searchIcon")
            $0.configuration = config
        }
        
        currentLocationButton.do {
            var config = UIButton.Configuration.plain()
            var attributedTitle = AttributedString("현재 위치로 찾기")
            attributedTitle.font = .bodyMedium18
            config.attributedTitle = attributedTitle
            config.image = UIImage(named: "gpsIcon")
            config.imagePadding = 9
            config.background.backgroundColor = UIColor(r: 42, g: 42, b: 44)
            config.baseForegroundColor = UIColor(named: "turquoiseGreen")
            config.cornerStyle = .medium
            config.background.strokeColor = UIColor(named: "turquoiseGreen")
            config.background.strokeWidth = 2
            $0.configuration = config
        }
        
        testLabel.do {
            $0.text = "서울 마포구 창전동"
            $0.font = UIFont(name: "NotoSansKR-Medium", size: 13.0)!
        }
    }

    //MARK: - setConstraints
    override func setConstraints() {
        view.addSubviews(searchView, currentLocationButton, scrollView)
        scrollView.addSubview(contentView)
        searchView.addSubview(searchTextField)
        searchView.addSubview(searchButton)
        contentView.addSubview(testLabel)
        
        searchView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(118)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(57)
        }
        
        searchButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(313)
            $0.trailing.equalToSuperview().offset(-18)
            $0.centerY.equalToSuperview()
        }
        
        searchTextField.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.trailing.equalTo(searchButton.snp.leading)
            $0.centerY.equalToSuperview()
        }
        
        currentLocationButton.snp.makeConstraints {
            $0.top.equalTo(searchView.snp.bottom).offset(27)
            $0.leading.equalTo(searchView)
            $0.trailing.equalTo(searchView)
            $0.height.equalTo(49)
        }
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(currentLocationButton.snp.bottom).offset(33)
            $0.bottom.equalToSuperview().offset(-141)
            $0.leading.equalToSuperview().offset(23)
            $0.trailing.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.height.greaterThanOrEqualTo(view.snp.height).priority(.low)
            $0.width.equalTo(scrollView.snp.width)
        }
        
        testLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
        }
    }
    
    private func setNavigationBar() {
        self.navigationItem.title = "동네 입력"
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        self.navigationController?.navigationBar.isHidden = true
        
    }
    
    //MARK: - setButtonAction
    private func setAddTarget() {
        searchButton.addTarget(self, action: #selector(isSearchButtonTapped), for: .touchUpInside)
        currentLocationButton.addTarget(self, action: #selector(isCurrentLocationButtonTapped), for: .touchUpInside)
    }
    
    //MARK: - @objc Func
    @objc func isSearchButtonTapped(_ sender: Any) {
        print("tapped")
    }
    
    @objc func isCurrentLocationButtonTapped(_ sender: Any) {
        print("tapped")
    }
}
