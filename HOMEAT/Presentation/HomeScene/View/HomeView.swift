//
//  StartView.swift
//  HOMEAT
//
//  Created by 강석호 on 3/27/24.
//

import Foundation
import UIKit
import SnapKit
import Then
import DGCharts

class HomeView: BaseView {
    
    //MARK: - component
    private let leftHole = UIImageView()
    private let rightHole = UIImageView()
    private let character = UIImageView()
    private let goalLabel = UILabel()
    private let leftMoneyLabel = UILabel()
    private let pieChart = PieChartView()
    private let editButton = UIButton()

    weak var delegate: HomeViewDelegate?
    
    //MARK: - Function
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupPieChart(remainingPercent: 3)
        setAddTarget()
    }
    
    //MARK: - setConfigure
    override func setConfigure() {
        let circleSize: CGFloat = 16
        self.backgroundColor = UIColor(named: "coolGray4")
        self.layer.cornerRadius = 13.2
        self.clipsToBounds = true
        
        leftHole.do {
            $0.frame.size = CGSize(width: circleSize, height: circleSize)
            $0.backgroundColor = UIColor(named: "homeBackgroundColor")
            $0.layer.cornerRadius = circleSize / 2
            $0.clipsToBounds = true
        }
        
        rightHole.do {
            $0.frame.size = CGSize(width: circleSize, height: circleSize)
            $0.backgroundColor = UIColor(named: "homeBackgroundColor")
            $0.layer.cornerRadius = circleSize / 2
            $0.clipsToBounds = true
        }
        
        character.do {
            $0.image = UIImage(named: "baseCharacter")
        }
        
        goalLabel.do {
            $0.text = StringLiterals.Home.main.HomeView.goal
            $0.font = .bodyBold16
            $0.textColor = .white
        }
        
        leftMoneyLabel.do {
            $0.text = StringLiterals.Home.main.HomeView.left
            $0.font = .headBold30
            $0.textColor = UIColor(named: "turquoiseGreen")
        }
        
        editButton.do {
            $0.setImage(UIImage(named: "pencilIcon"), for: .normal)
        }
    }
    
    //MARK: - setConstraints
    override func setConstraints() {
        super.setConstraints()
        self.addSubviews(leftHole, rightHole, character, goalLabel, leftMoneyLabel, pieChart, editButton)
        
        leftHole.snp.makeConstraints {
            $0.top.equalTo(self).offset(15)
            $0.width.equalTo(15.1)
            $0.height.equalTo(15.1)
            $0.leading.equalTo(self).offset(15)
        }
        
        rightHole.snp.makeConstraints {
            $0.top.equalTo(self).offset(15)
            $0.width.equalTo(15.1)
            $0.height.equalTo(15.1)
            $0.trailing.equalTo(self).offset(-15)
        }
        
        goalLabel.snp.makeConstraints {
            $0.top.equalTo(self).offset(42)
            $0.centerX.equalToSuperview()
        }
        
        leftMoneyLabel.snp.makeConstraints {
            $0.top.equalTo(goalLabel.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
        }
        
        editButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(44)
            $0.leading.equalTo(goalLabel.snp.trailing).offset(6)
        }
        
        pieChart.snp.makeConstraints {
            $0.top.equalTo(leftMoneyLabel.snp.bottom)
            $0.centerX.equalTo(leftMoneyLabel)
            $0.width.equalTo(206)
            $0.height.equalTo(206)
        }
        
        character.snp.makeConstraints {
            $0.top.equalTo(pieChart.snp.top).offset(67)
            $0.centerX.equalToSuperview()
        }
    }
    
    //MARK: - setButtonAction
    private func setAddTarget() {
        editButton.addTarget(self, action: #selector(isEditButtonTapped), for: .touchUpInside)
    }
    
    func setupPieChart(remainingPercent : Int) {
        var entries = [ChartDataEntry]()
        entries.append(PieChartDataEntry(value: Double(remainingPercent)))
        entries.append(PieChartDataEntry(value: Double(100-remainingPercent)))
        let dataSet = PieChartDataSet(entries: entries)
        if let customGreenColor = UIColor(named: "turquoiseGreen") {
                let otherColor = UIColor.black
                dataSet.colors = [customGreenColor, otherColor]
        }
        dataSet.selectionShift = 0
        let data = PieChartData(dataSet: dataSet)
        pieChart.holeRadiusPercent = 0.8
        pieChart.holeColor = .clear
        dataSet.drawValuesEnabled = false
        dataSet.drawIconsEnabled = false
        pieChart.data = data
        pieChart.legend.enabled = false
    }
    
    //MARK: - @objc Func
    @objc func isEditButtonTapped(_ sender: Any) {
        self.delegate?.editButtonTapped()
    }
}

//MARK: - Protocol
protocol HomeViewDelegate: AnyObject {
    func editButtonTapped()
}
