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
import Charts
import DGCharts

protocol MonthViewDelegate: AnyObject {
    func didSelectYearMonth(year: Int, month: Int)
}

final class MonthView: BaseView {
    weak var delegate: MonthViewDelegate?
    //MARK: - Property
    private var currentDate = Date()
    private let monthBackButton = UIButton()
    private let monthNextButton = UIButton()
    private let yearMonthLabel = UILabel()
    private let monthContentLabel = UILabel()
    private let pieChart = PieChartView()
    private let barChartView = BarChartView()
    internal let barCornerRadius = CGFloat(5.0)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    // MARK: - UI
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
    }
    
    override func setting() {
        let (year, month) = getCurrentYearMonth()
        yearMonthLabel.text = "\(year)년 \(month)월"
//        setupPieChart(jipbapRatio: 40,outRatio: 60)
//        setupBarChart(jipbapPrice: 4.3, outPrice: 5.7)
//        setStyledMonthContentLabel(savePercent: <#T##String#>)
    }
    
    // MARK: - Function
    func setStyledMonthContentLabel(savePercent: Double) {
        var text = ""
        if savePercent >= 0 {
            text = String(format: "저번달 보다 %.0f%% 절약했어요", savePercent)
        } else {
            text = String(format: "저번달 보다 %.0f%% 추가지출 했어요", abs(savePercent))
        }
        let attributedString = NSMutableAttributedString(string: text)
        
        // 텍스트에서 %.0f%%를 찾아서 색상을 변경
        let range = (text as NSString).range(of: String(format: "%.0f%%", abs(savePercent)))
        attributedString.addAttribute(.foregroundColor, value: UIColor(named: "green"), range: range)
        monthContentLabel.attributedText = attributedString
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
        dataSet.selectionShift = 0
        let data = PieChartData(dataSet: dataSet)
        pieChart.holeRadiusPercent = 0.6
        pieChart.holeColor = .clear
        dataSet.valueTextColor = .black
        dataSet.valueFont = UIFont.systemFont(ofSize: 11.0)
        dataSet.valueLineColor = .black
        dataSet.valueLinePart1OffsetPercentage = 0.8
        dataSet.drawValuesEnabled = true
        dataSet.drawIconsEnabled = false
        pieChart.data = data
        pieChart.legend.enabled = false
        
    }
    
    func setupBarChart(jipbapPrice: Double, outPrice: Double) {
        let names = ["집밥", "배달/외식"]
        
        let barChartHeight = 120
        // 각 막대의 비율을 계산합니다.
        let jipbapBarHeight = CGFloat(jipbapPrice / (jipbapPrice + outPrice) * Double(barChartHeight))
        let outBarHeight = CGFloat(outPrice / (jipbapPrice + outPrice) * Double(barChartHeight))
        print("집밥 높이:\(jipbapBarHeight)")
        print("배달 높이:\(outBarHeight)")
        
        var barEntries = [BarChartDataEntry]()
        barEntries.append(BarChartDataEntry(x: 0, y: Double(jipbapBarHeight), icon: UIImage(named: "homefoodLogo")))
        barEntries.append(BarChartDataEntry(x: 1, y: Double(outBarHeight), icon: UIImage(named: "deliveryLogo")))
        barEntries.append(BarChartDataEntry(x: 1, y: 0, icon: nil))
        
        let barDataSet = BarChartDataSet(entries: barEntries)
        if let customGreenColor = UIColor(named: "turquoiseGreen"),
           let otherColor = UIColor(named: "turquoisePurple") {
            let nsCustomGreenColor = NSUIColor(cgColor: customGreenColor.cgColor)
            let nsOtherColor = NSUIColor(cgColor: otherColor.cgColor)
            barDataSet.colors = [nsCustomGreenColor, nsOtherColor]
        }
        
        barChartView.xAxis.labelFont = UIFont.systemFont(ofSize: 12)
        barChartView.drawGridBackgroundEnabled = false
        let barData = BarChartData(dataSet: barDataSet)
        barChartView.xAxis.labelCount = names.count
        barChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: names)
        barChartView.xAxis.labelPosition = .bottom
        barChartView.xAxis.labelTextColor = .white
        let xAxis = barChartView.xAxis
        xAxis.drawGridLinesEnabled = false
        xAxis.drawLabelsEnabled = true
        xAxis.drawAxisLineEnabled = false
        
        barChartView.leftAxis.drawLabelsEnabled = false
        barChartView.leftAxis.enabled = false
        barChartView.rightAxis.enabled = false
        barChartView.layer.cornerRadius = 10
        barChartView.layer.masksToBounds = true
        barChartView.leftAxis.gridColor = UIColor.clear
        barChartView.rightAxis.gridColor = UIColor.clear
        
        barDataSet.drawValuesEnabled = false
        barDataSet.drawIconsEnabled = true
        barData.barWidth = 0.55
        barChartView.data = barData
        barChartView.notifyDataSetChanged()
        barChartView.legend.enabled = false
        barChartView.snp.makeConstraints {
            $0.top.equalTo(monthContentLabel.snp.bottom).offset(10)
            $0.leading.equalTo(pieChart.snp.trailing).offset(20)
            $0.trailing.equalToSuperview().inset(45.7)
            $0.bottom.equalToSuperview().inset(30)
        }
        barChartView.isUserInteractionEnabled = false
        print(barChartHeight)
    }
    
    func updateYearMonthLabel() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월"
        let formattedDate = formatter.string(from: currentDate)
        yearMonthLabel.text = formattedDate
    }
    
    func getCurrentYearMonth() -> (year: Int, month: Int) {
        let currentDate = Date()
        let calendar = Calendar.current
        let year = calendar.component(.year, from: currentDate)
        let month = calendar.component(.month, from: currentDate)
        yearMonthLabel.text = "\(year)년 \(month)월"
        return (year, month)
    }
    
    //MARK: - Action
    @objc func monthBackTapped() {
        currentDate = Calendar.current.date(byAdding: .month, value: -1, to: currentDate) ?? Date()
        updateYearMonthLabel()
        let (year, month) = getCurrentYearMonth()
        delegate?.didSelectYearMonth(year: year, month: month)
    }
    
    @objc func monthNextTapped() {
        currentDate = Calendar.current.date(byAdding: .month, value: +1, to: currentDate) ?? Date()
        updateYearMonthLabel()
        let (year, month) = getCurrentYearMonth()
        delegate?.didSelectYearMonth(year: year, month: month)
    }
    
}
