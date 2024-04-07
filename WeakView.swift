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

final class WeakView: BaseView {
    //MARK: - Property
    private var currentDate = Date() // 현재 날짜를 가져옴
    private let weakMonthLabel = UILabel()
    private let weekBackButton = UIButton()
    private let weekNextButton = UIButton()
    private let genderLabel = UILabel()
    private let jipbapContentsLabel = UILabel()
    private let deliveryContentsLabel = UILabel()
    private let jipbapWeekBarChartView = BarChartView()
    private let deliveryWeekBarChartView = BarChartView()
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
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
            $0.text = "2024년 4월 첫째 주"
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
            $0.text = "집밥은 50,000원을 덜 쓰고,"
            $0.textColor = .white
            $0.textAlignment = .center
            $0.font = .bodyBold18
            $0.numberOfLines = 0
            let attributedString3 = NSMutableAttributedString(string: jipbapContentsLabel.text ?? "")
            let range3 = (jipbapContentsLabel.text as NSString?)?.range(of: "집밥")
            attributedString3.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.init(named: "turquoiseGreen"), range: range3 ?? NSRange())
            
            let range4 = (jipbapContentsLabel.text as NSString?)?.range(of: "50,000원을 덜")
            attributedString3.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.init(named: "turquoiseGreen"), range: range4 ?? NSRange())
            jipbapContentsLabel.attributedText = attributedString3
        }
        deliveryContentsLabel.do {
            $0.text = "외식과 배달은 120,000원을 더 썼어요"
            $0.textColor = .white
            $0.textAlignment = .center
            $0.font = .bodyBold18
            $0.numberOfLines = 0
            // "외식과 배달"을 purple로 변경
            let attributedString3 = NSMutableAttributedString(string: deliveryContentsLabel.text ?? "")
            let range3 = (deliveryContentsLabel.text as NSString?)?.range(of: "외식과 배달")
            attributedString3.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.init(named: "turquoisePurple"), range: range3 ?? NSRange())
            
            let range4 = (deliveryContentsLabel.text as NSString?)?.range(of: "120,000원을 더")
            attributedString3.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.init(named: "turquoisePurple"), range: range4 ?? NSRange())
            deliveryContentsLabel.attributedText = attributedString3
        }
    }
    override func setConstraints() {
        addSubviews(weekBackButton,weakMonthLabel,weekNextButton,genderLabel,jipbapContentsLabel,deliveryContentsLabel,jipbapWeekBarChartView,deliveryWeekBarChartView)
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
    }
    
    override func setting() {
        setupMealWeekBarChart(jipbapAverage: 40, weekJipbapPrice: 50)
        setupDeliveryWeekBarChart(outAverage: 40,weekOutPrice: 50)
    }
    
    func updateWeekMonthLabel() {
        let calendar = Calendar.current
        let weekOfMonth = calendar.component(.weekOfMonth, from: currentDate)
        var weekLabel = ""
        
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
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월"
        let formattedDate = formatter.string(from: currentDate)
        
        weakMonthLabel.text = "\(formattedDate) \(weekLabel)"
    }
    
    func setupMealWeekBarChart(jipbapAverage: Int,weekJipbapPrice: Int) {
        let nameWithSuffix = "예진 님" // 닉네임 뒤에 "님"을 붙임
        var names = ["집밥 평균", nameWithSuffix]
        var barEntries = [BarChartDataEntry]()
        barEntries.append(BarChartDataEntry(x: 0, y: Double(jipbapAverage)))
        barEntries.append(BarChartDataEntry(x: 1, y: Double(weekJipbapPrice)))
        barEntries.append(BarChartDataEntry(x: 1, y: 0))
        let barDataSet = BarChartDataSet(entries: barEntries)
        if let customGreenColor = UIColor(named: "warmgray"),
           let otherColor = UIColor(named: "turquoiseGreen") {
            let nsCustomGreenColor = NSUIColor(cgColor: customGreenColor.cgColor)
            let nsOtherColor = NSUIColor(cgColor: otherColor.cgColor)
            barDataSet.colors = [nsCustomGreenColor, nsOtherColor]
        }
        jipbapWeekBarChartView.xAxis.labelFont = UIFont.systemFont(ofSize: 12) // 레이블 폰트 크기를 축소
        jipbapWeekBarChartView.drawGridBackgroundEnabled = false
        let barData = BarChartData(dataSet: barDataSet)
        jipbapWeekBarChartView.xAxis.labelCount = names.count // 레이블 갯수 설정
        
        // 바 차트 아래에 레이블 추가
        jipbapWeekBarChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: names)
        jipbapWeekBarChartView.xAxis.labelPosition = .bottom
        jipbapWeekBarChartView.xAxis.labelTextColor = .white
        let xAxis = jipbapWeekBarChartView.xAxis
        xAxis.drawGridLinesEnabled = false
        xAxis.drawLabelsEnabled = true // 레이블 표시를 가능하게 설정
        xAxis.drawAxisLineEnabled = false
        
        jipbapWeekBarChartView.leftAxis.drawLabelsEnabled = false // leftYAxis 레이블 숨김
        jipbapWeekBarChartView.leftAxis.enabled = false
        jipbapWeekBarChartView.rightAxis.enabled = false // rightYAxis 숨김
        
        jipbapWeekBarChartView.leftAxis.gridColor = UIColor.clear
        jipbapWeekBarChartView.rightAxis.gridColor = UIColor.clear
        
        barDataSet.drawValuesEnabled = false
        barDataSet.drawIconsEnabled = true // 아이콘 표시 활성화
        barData.barWidth = 0.7 // 막대의 너비를 0.5로 설정하여 줄임
        jipbapWeekBarChartView.data = barData
        jipbapWeekBarChartView.notifyDataSetChanged()
        jipbapWeekBarChartView.legend.enabled = false
        
    }
    
    
    func setupDeliveryWeekBarChart(outAverage: Int,weekOutPrice: Int) {
        let nameWithSuffix = "예진 님"
        var names = ["외식/배달 평균", nameWithSuffix]
        
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
        deliveryWeekBarChartView.xAxis.labelFont = UIFont.systemFont(ofSize: 12) // 레이블 폰트 크기를 축소
        deliveryWeekBarChartView.drawGridBackgroundEnabled = false
        let barData = BarChartData(dataSet: barDataSet)
        deliveryWeekBarChartView.xAxis.labelCount = names.count // 레이블 갯수 설정
        
        deliveryWeekBarChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: names)
        deliveryWeekBarChartView.xAxis.labelPosition = .bottom
        deliveryWeekBarChartView.xAxis.labelTextColor = .white
        let xAxis = deliveryWeekBarChartView.xAxis
        xAxis.drawGridLinesEnabled = false
        xAxis.drawLabelsEnabled = true // 레이블 표시를 가능하게 설정
        xAxis.drawAxisLineEnabled = false
        
        deliveryWeekBarChartView.leftAxis.drawLabelsEnabled = false // leftYAxis 레이블 숨김
        deliveryWeekBarChartView.leftAxis.enabled = false
        deliveryWeekBarChartView.rightAxis.enabled = false // rightYAxis 숨김
        
        deliveryWeekBarChartView.leftAxis.gridColor = UIColor.clear
        deliveryWeekBarChartView.rightAxis.gridColor = UIColor.clear
        
        barDataSet.drawValuesEnabled = false
        barDataSet.drawIconsEnabled = true // 아이콘 표시 활성화
        barData.barWidth = 0.7 // 막대의 너비를 0.5로 설정하여 줄임
        deliveryWeekBarChartView.data = barData
        deliveryWeekBarChartView.notifyDataSetChanged()
        deliveryWeekBarChartView.legend.enabled = false
    }
//MARK: - @objc Func
@objc func weekBackTapped() {
    currentDate = Calendar.current.date(byAdding: .day, value: -7, to: currentDate) ?? Date()
    updateWeekMonthLabel()
}

@objc func weekNextTapped() {
    currentDate = Calendar.current.date(byAdding: .day, value: +7, to: currentDate) ?? Date()
    updateWeekMonthLabel()
}

}
