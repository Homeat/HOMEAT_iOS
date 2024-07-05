//
//  WeakView.swift
//  HOMEAT
//
//  Created by 김민솔 on 4/4/24.
//

import Foundation
import UIKit
import SnapKit
import Then
import DGCharts

protocol WeekViewDelegate: AnyObject {
    func weekBackButtonTapped()
    func weekNextButtonTapped()
}
final class WeekView: BaseView {
    //MARK: - Property
    weak var delegate : WeekViewDelegate?
    private var currentDate = Date()
    private let weakMonthLabel = UILabel()
    private let weekBackButton = UIButton()
    private let weekNextButton = UIButton()
    let genderLabel = UILabel()
    let jipbapContentsLabel = UILabel()
    let deliveryContentsLabel = UILabel()
    let jipbapWeekBarChartView = BarChartView()
    let deliveryWeekBarChartView = BarChartView()
    let errorMessageLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    // MARK: - UI
    override func setConfigure() {
        weekBackButton.do {
            $0.setImage(UIImage(named: "calendarBack"), for: .normal)
            $0.contentMode = .scaleAspectFit
            $0.clipsToBounds = true
            $0.addTarget(self, action: #selector(weekBackTapped), for: .touchUpInside)
        }
        
        weekNextButton.do {
            $0.setImage(UIImage(named: "calendarNext"), for: .normal)
            $0.contentMode = .scaleAspectFit
            $0.clipsToBounds = true
            $0.addTarget(self, action: #selector(weekNextTapped), for: .touchUpInside)
        }
        
        weakMonthLabel.do {
            $0.textColor = .white
            $0.textAlignment = .center
            $0.font = .bodyMedium18
        }
        
        genderLabel.do {
            $0.text = "소득이 비슷한 또래 여성 대비"
            $0.textColor = .white
            $0.textAlignment = .center
            $0.font = .bodyBold18
            $0.numberOfLines = 0
        }
        
        jipbapContentsLabel.do {
            $0.textColor = .white
            $0.textAlignment = .center
            $0.font = .bodyBold18
            $0.numberOfLines = 0
        }
        
        deliveryContentsLabel.do {
            $0.textColor = .white
            $0.textAlignment = .center
            $0.font = .bodyBold18
            $0.numberOfLines = 0
        }
        errorMessageLabel.do {
           $0.textColor = .white
           $0.textAlignment = .center
           $0.font = .bodyBold18
           $0.numberOfLines = 0
           $0.isHidden = true
       }
        
    }
    
    override func setConstraints() {
        addSubviews(weekBackButton,weakMonthLabel,weekNextButton,genderLabel,jipbapContentsLabel,deliveryContentsLabel,jipbapWeekBarChartView,deliveryWeekBarChartView,errorMessageLabel)
        
        weekBackButton.snp.makeConstraints {
            $0.height.equalTo(14.6)
            $0.top.equalToSuperview().offset(19)
            $0.trailing.equalTo(weakMonthLabel.snp.leading).offset(-11)
        }
        
        weakMonthLabel.snp.makeConstraints {
            $0.height.equalTo(26)
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(12)
        }
        
        weekNextButton.snp.makeConstraints {
            $0.height.equalTo(14.6)
            $0.top.equalToSuperview().offset(19)
            $0.leading.equalTo(weakMonthLabel.snp.trailing).offset(11)
        }
        
        genderLabel.snp.makeConstraints {
            $0.top.equalTo(weakMonthLabel.snp.bottom).offset(30)
            $0.centerX.equalToSuperview()
        }
        
        jipbapContentsLabel.snp.makeConstraints {
            $0.top.equalTo(genderLabel.snp.bottom)
            $0.centerX.equalToSuperview()
        }
        
        deliveryContentsLabel.snp.makeConstraints {
            $0.top.equalTo(jipbapContentsLabel.snp.bottom)
            $0.centerX.equalToSuperview()
        }
        
        jipbapWeekBarChartView.snp.makeConstraints {
            $0.top.equalTo(deliveryContentsLabel.snp.bottom).offset(40)
            $0.height.equalTo(125)
            $0.leading.trailing.equalToSuperview().inset(100)
        }
        
        deliveryWeekBarChartView.snp.makeConstraints {
            $0.top.equalTo(jipbapWeekBarChartView.snp.bottom).offset(40)
            $0.height.equalTo(125)
            $0.leading.trailing.equalToSuperview().inset(100)
        }
        errorMessageLabel.snp.makeConstraints {
                    $0.center.equalToSuperview()
        }
    }
    
    override func setting() {
        updateWeekMonthLabel(for: currentDate)
    }
    
    // MARK: - Function
    func updateGenderLabel(gender: String) {
        self.genderLabel.text = "소득이 비슷한 또래 \(gender) 대비"
    }
    private func updateAttributedString(label: UILabel, text: String, highlightTextWithColors: [(String, UIColor)]) {
        let attributedString = NSMutableAttributedString(string: text)
        for (highlight, color) in highlightTextWithColors {
            if let range = (text as NSString).range(of: highlight) as NSRange? {
                attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
            }
        }
        label.attributedText = attributedString
    }
    
    func updateGipbapContentsLabel(jibapSave: Int) {
        let jibapText = jibapSave < 0 ? "집밥은 \(abs(jibapSave))원을 더 쓰고," : "집밥은 \(jibapSave)원을 덜 쓰고,"
        let highlightTextWithColors = [
            ("집밥", UIColor(named: "turquoiseGreen") ?? .green),
            ("\(abs(jibapSave))원을 더", UIColor(named: "turquoiseGreen") ?? .green),
            ("\(jibapSave)원을 덜", UIColor(named: "turquoiseGreen") ?? .green)
        ]
        updateAttributedString(label: jipbapContentsLabel, text: jibapText, highlightTextWithColors: highlightTextWithColors)
    }

    func updateDeliveryContentsLabel(outSave: Int) {
        let outText = outSave < 0 ? "외식과 배달은 \(abs(outSave))원을 더 썼어요" : "외식과 배달은 \(outSave)원을 덜 썼어요"
        let highlightTextWithColors = [
            ("외식과 배달", UIColor(named: "turquoisePurple") ?? .purple),
            ("\(abs(outSave))원을 더", UIColor(named: "turquoisePurple") ?? .purple),
            ("\(outSave)원을 덜", UIColor(named: "turquoisePurple") ?? .purple)
        ]
        updateAttributedString(label: deliveryContentsLabel, text: outText, highlightTextWithColors: highlightTextWithColors)
    }
    
    func updateWeekMonthLabel(for date: Date) {
        let (year, month, weekOfMonth) = getCurrentYearMonthWeek(for: date)
        var weekLabel : String
        
        switch weekOfMonth {
        case 1:
            weekLabel = "첫째 주"
        case 2:
            weekLabel = "둘째 주"
        case 3:
            weekLabel = "셋째 주"
        case 4:
            weekLabel = "넷째 주"
        case 5:
            weekLabel = "다섯째 주"
        default:
            weekLabel = ""
        }
        weakMonthLabel.text = "\(year)년 \(month)월 \(weekLabel)"
        print(weakMonthLabel)
    }
    
    func getCurrentYearMonthWeek(for date: Date) -> (year: Int, month: Int, weekOfMonth: Int) {
        let calendar = Calendar.current
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        let weekOfMonth = calendar.component(.weekOfMonth, from: date)
        return (year, month, weekOfMonth)
    }
    
    func setupMealWeekBarChart(jipbapAverage: Int,weekJipbapPrice: Int, name: String) {
        let nameWithSuffix = "\(name) 님" // 닉네임 뒤에 "님"을 붙임
            let names = ["집밥 평균", nameWithSuffix]
            var barEntries = [BarChartDataEntry]()
            barEntries.append(BarChartDataEntry(x: 0, y: Double(jipbapAverage)))
            barEntries.append(BarChartDataEntry(x: 1, y: Double(weekJipbapPrice)))
            barEntries.append(BarChartDataEntry(x: 1, y: 0))
            let barDataSet = BarChartDataSet(entries: barEntries)
            if let customGreenColor = UIColor(named: "warmgray") ,
               let otherColor = UIColor(named: "turquoiseGreen") {
                let nsCustomGreenColor = NSUIColor(cgColor: customGreenColor.cgColor)
                let nsOtherColor = NSUIColor(cgColor: otherColor.cgColor)
                barDataSet.colors = [nsCustomGreenColor, nsOtherColor]
            }
            jipbapWeekBarChartView.xAxis.labelFont = UIFont.systemFont(ofSize: 12)
            jipbapWeekBarChartView.drawGridBackgroundEnabled = false
            let barData = BarChartData(dataSet: barDataSet)
            jipbapWeekBarChartView.xAxis.labelCount = names.count
            jipbapWeekBarChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: names)
            jipbapWeekBarChartView.xAxis.labelPosition = .bottom
            jipbapWeekBarChartView.xAxis.labelTextColor = .white
            let xAxis = jipbapWeekBarChartView.xAxis
            xAxis.drawGridLinesEnabled = false
            xAxis.drawLabelsEnabled = true
            xAxis.drawAxisLineEnabled = false
            
            jipbapWeekBarChartView.leftAxis.drawLabelsEnabled = false
            jipbapWeekBarChartView.leftAxis.enabled = false
            jipbapWeekBarChartView.rightAxis.enabled = false
            
            jipbapWeekBarChartView.leftAxis.gridColor = UIColor.clear
            jipbapWeekBarChartView.rightAxis.gridColor = UIColor.clear
            
            barDataSet.drawValuesEnabled = false
            barDataSet.drawIconsEnabled = true
            barData.barWidth = 0.7
            jipbapWeekBarChartView.data = barData
            jipbapWeekBarChartView.notifyDataSetChanged()
            jipbapWeekBarChartView.legend.enabled = false
            jipbapWeekBarChartView.isUserInteractionEnabled = false
        
    }
    
    func setupDeliveryWeekBarChart(outAverage: Int,weekOutPrice: Int, name: String) {
        let nameWithSuffix = "\(name) 님" // 닉네임 뒤에 "님"을 붙임
            
            let names = ["외식/배달 평균", nameWithSuffix]
            var barEntries = [BarChartDataEntry]()
            barEntries.append(BarChartDataEntry(x: 0, y: Double(35)))
            barEntries.append(BarChartDataEntry(x: 1, y: Double(75)))
            barEntries.append(BarChartDataEntry(x: 1, y: 0))
            let barDataSet = BarChartDataSet(entries: barEntries)
            if let customGreenColor = UIColor(named: "warmgray"),
               let otherColor = UIColor(named: "turquoisePurple") {
                let nsCustomGreenColor = NSUIColor(cgColor: customGreenColor.cgColor)
                let nsOtherColor = NSUIColor(cgColor: otherColor.cgColor)
                barDataSet.colors = [nsCustomGreenColor, nsOtherColor]
            }
            
            deliveryWeekBarChartView.xAxis.labelFont = UIFont.systemFont(ofSize: 12)
            deliveryWeekBarChartView.drawGridBackgroundEnabled = false
            let barData = BarChartData(dataSet: barDataSet)
            deliveryWeekBarChartView.xAxis.labelCount = names.count
            deliveryWeekBarChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: names)
            deliveryWeekBarChartView.xAxis.labelPosition = .bottom
            deliveryWeekBarChartView.xAxis.labelTextColor = .white
            let xAxis = deliveryWeekBarChartView.xAxis
            xAxis.drawGridLinesEnabled = false
            xAxis.drawLabelsEnabled = true
            xAxis.drawAxisLineEnabled = false
            
            deliveryWeekBarChartView.leftAxis.drawLabelsEnabled = false
            deliveryWeekBarChartView.leftAxis.enabled = false
            deliveryWeekBarChartView.rightAxis.enabled = false
            
            deliveryWeekBarChartView.leftAxis.gridColor = UIColor.clear
            deliveryWeekBarChartView.rightAxis.gridColor = UIColor.clear
            
            barDataSet.drawValuesEnabled = false
            barDataSet.drawIconsEnabled = true
            barData.barWidth = 0.7
            deliveryWeekBarChartView.data = barData
            deliveryWeekBarChartView.notifyDataSetChanged()
            deliveryWeekBarChartView.legend.enabled = false
            deliveryWeekBarChartView.isUserInteractionEnabled = false
        
    }
    //MARK: - Action
    @objc func weekBackTapped() {
        currentDate = Calendar.current.date(byAdding: .day, value: -7, to: currentDate) ?? Date()
        updateWeekMonthLabel(for: currentDate)
        delegate?.weekBackButtonTapped()
        
    }
    
    @objc func weekNextTapped() {
        currentDate = Calendar.current.date(byAdding: .day, value: +7, to: currentDate) ?? Date()
        updateWeekMonthLabel(for: currentDate)
        delegate?.weekNextButtonTapped()
    }
    func handleWeekAnalysisData(_ data: AnalysisWeekResponseDTO) {
        errorMessageLabel.isHidden = true
        genderLabel.isHidden = false
        jipbapContentsLabel.isHidden = false
        deliveryContentsLabel.isHidden = false
        updateGenderLabel(gender: data.gender)
        updateGipbapContentsLabel(jibapSave: data.jipbap_save ?? 0)
        updateDeliveryContentsLabel(outSave: data.out_save ?? 0)
        setupMealWeekBarChart(jipbapAverage: data.jipbap_average ?? 0, weekJipbapPrice: data.week_jipbap_price ?? 0, name: data.nickname)
        setupDeliveryWeekBarChart(outAverage: data.out_average ?? 0, weekOutPrice: data.week_out_price ?? 0 , name: data.nickname)
    }
}
extension WeekView {
    func updateErrorMessage(_ message: String) {
        errorMessageLabel.text = message
        errorMessageLabel.isHidden = false
        genderLabel.isHidden = true
        jipbapContentsLabel.isHidden = true
        deliveryContentsLabel.isHidden = true
        jipbapWeekBarChartView.isHidden = true
        deliveryWeekBarChartView.isHidden = true
    }
}
