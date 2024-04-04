//
//  MonthView.swift
//  HOMEAT
//
//  Created by 김민솔 on 4/4/24.
//

import Foundation
import UIKit
import SnapKit
import Then
import DGCharts

final class MonthView: BaseView {
    //MARK: - Property
    private let monthBackButton = UIButton()
    private let monthNextButton = UIButton()
    private let yearMonthLabel = UILabel()
    private let monthContentLabel = UILabel()
    private let pieChart = PieChartView()
    private let barChartView = BarChartView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func setConfigure() {
        monthBackButton.do {
            $0.setImage(UIImage(named: "calendarBack"), for: .normal)
            $0.contentMode = .scaleAspectFit
            $0.clipsToBounds = true
            $0.addTarget(self, action: #selector(monthBackTapped), for: .touchUpInside)
        }
        
        monthNextButton.do {
            $0.setImage(UIImage(named: "calendarNext"), for: .normal)
            $0.contentMode = .scaleAspectFit
            $0.clipsToBounds = true
            $0.addTarget(self, action: #selector(monthNextTapped), for: .touchUpInside)
        }
        
        yearMonthLabel.do {
            $0.text = "2024년 4월"
            $0.textColor = .white
            $0.textAlignment = .center
            $0.font = .bodyMedium18
        }
        
        monthContentLabel.do {
            $0.text = "저번달 보다 8% 절약하고 있어요"
            $0.textColor = .white
            $0.textAlignment = .center
            $0.font = .bodyBold18
        }
    }
    
    override func setConstraints() {
        addSubviews(monthBackButton,monthNextButton,yearMonthLabel,monthContentLabel,pieChart,barChartView)
        
        monthBackButton.snp.makeConstraints {
            $0.height.equalTo(14.6)
            $0.top.equalToSuperview().offset(19)
            $0.trailing.equalTo(yearMonthLabel.snp.leading).offset(-11)
        }
        
        yearMonthLabel.snp.makeConstraints {
            $0.height.equalTo(26)
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(12)
        }
        
        monthNextButton.snp.makeConstraints {
            $0.height.equalTo(14.6)
            $0.top.equalToSuperview().offset(19)
            $0.leading.equalTo(yearMonthLabel.snp.trailing).offset(11)
        }
        
        monthContentLabel.snp.makeConstraints {
            $0.height.equalTo(30)
            $0.top.equalTo(yearMonthLabel.snp.bottom).offset(40)
            $0.centerX.equalToSuperview()
        }
        
        pieChart.snp.makeConstraints {
            $0.top.equalTo(monthContentLabel.snp.bottom).offset(28)
            $0.leading.equalToSuperview().inset(30)
            $0.height.equalTo(145.5)
            $0.width.equalTo(147.6)
        }
        
        barChartView.snp.makeConstraints {
            $0.top.equalTo(monthContentLabel.snp.bottom).offset(10)
            $0.leading.equalTo(pieChart.snp.trailing).offset(20)
            $0.trailing.equalToSuperview().inset(45.7)
            $0.bottom.equalToSuperview().inset(30)
        }
        
    }
    
    override func setting() {
        setupPieChart(jipbapRatio: 40,outRatio: 60)
        setupBarChart(jipbapPrice: 5, outPrice: 10)
    }
    
    func setupPieChart(jipbapRatio : Double, outRatio: Double) {
        var entries = [ChartDataEntry]()
        entries.append(PieChartDataEntry(value: jipbapRatio))
        entries.append(PieChartDataEntry(value: outRatio))
        let dataSet = PieChartDataSet(entries: entries)
        if let customGreenColor = UIColor(named: "turquoiseGreen"),
           let otherColor = UIColor(named: "turquoisePurple") {
            let nsCustomGreenColor = NSUIColor(cgColor: customGreenColor.cgColor)
            let nsWhiteColor = NSUIColor.black
            let nsOtherColor = NSUIColor(cgColor: otherColor.cgColor)
            dataSet.colors = [nsCustomGreenColor, nsOtherColor]
        }
        //piechart edge 삭제
        dataSet.selectionShift = 0
        let data = PieChartData(dataSet: dataSet)
        // 중앙 hole 생성
        pieChart.holeRadiusPercent = 0.6
        // hole 색상 투명하게 설정
        pieChart.holeColor = .clear
        //범례, 숫자 같은 부가요소 제거
        dataSet.valueTextColor = .black // 레이블 텍스트 색상 설정
        dataSet.valueFont = UIFont.systemFont(ofSize: 11.0) // 레이블 텍스트 폰트 설정
        dataSet.valueLineColor = .black // 레이블 텍스트의 라인 색상 설정
        dataSet.valueLinePart1OffsetPercentage = 0.8
        dataSet.drawValuesEnabled = true
        dataSet.drawIconsEnabled = false
        pieChart.data = data
        pieChart.legend.enabled = false
    }
    func setupBarChart(jipbapPrice: Int, outPrice: Int) {
        var names = ["집밥", "배달/외식"]
        
        var barEntries = [BarChartDataEntry]()
        
        barEntries.append(BarChartDataEntry(x: 0, y: Double(jipbapPrice), icon: UIImage(named: "homefoodLogo")))
        barEntries.append(BarChartDataEntry(x: 1, y: Double(outPrice), icon: UIImage(named: "deliveryLogo")))
        let barDataSet = BarChartDataSet(entries: barEntries)
        if let customGreenColor = UIColor(named: "turquoiseGreen"),
           let otherColor = UIColor(named: "turquoisePurple") {
            let nsCustomGreenColor = NSUIColor(cgColor: customGreenColor.cgColor)
            let nsOtherColor = NSUIColor(cgColor: otherColor.cgColor)
            barDataSet.colors = [nsCustomGreenColor, nsOtherColor]
        }
        barChartView.xAxis.labelFont = UIFont.systemFont(ofSize: 12) // 레이블 폰트 크기를 축소
        barChartView.drawGridBackgroundEnabled = false
        let barData = BarChartData(dataSet: barDataSet)
        barChartView.xAxis.labelCount = names.count // 레이블 갯수 설정
        barChartView.xAxis.spaceMin = 0.5 // 최소 간격 설정
        barChartView.xAxis.spaceMax = 0.5 // 최대 간격 설정
        
        // 바 차트 아래에 레이블 추가
        barChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: names)
        barChartView.xAxis.labelPosition = .bottom
        barChartView.xAxis.labelTextColor = .white
        let xAxis = barChartView.xAxis
        xAxis.drawGridLinesEnabled = false
        xAxis.drawLabelsEnabled = true // 레이블 표시를 가능하게 설정
        xAxis.drawAxisLineEnabled = false
        
        barChartView.leftAxis.drawLabelsEnabled = false // leftYAxis 레이블 숨김
        barChartView.leftAxis.enabled = false
        barChartView.rightAxis.enabled = false // rightYAxis 숨김
        
        barChartView.leftAxis.gridColor = UIColor.clear
        barChartView.rightAxis.gridColor = UIColor.clear
        
        barDataSet.drawValuesEnabled = false
        barDataSet.drawIconsEnabled = true // 아이콘 표시 활성화
        barData.barWidth = 0.55 // 막대의 너비를 0.5로 설정하여 줄임
        barChartView.data = barData
        barChartView.notifyDataSetChanged()
        barChartView.legend.enabled = false
    }
    //MARK: - @objc Func
    @objc func monthBackTapped() {
        
    }
    @objc func monthNextTapped() {
        
    }
}
