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

protocol WeakViewDelegate: AnyObject {
    func didSelectYearMonthDay(year: Int, month: Int, day: Int)
}

final class WeakView: BaseView {
    weak var delegate: WeakViewDelegate?
    //MARK: - Property
    private var currentDate = Date()
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
            $0.text = "집밥은 50,000원을 덜 쓰고,"
            $0.textColor = .white
            $0.textAlignment = .center
            $0.font = .bodyBold18
            $0.numberOfLines = 0
            let attributedString3 = NSMutableAttributedString(string: jipbapContentsLabel.text ?? "")
            let jipbapRange = (jipbapContentsLabel.text as NSString?)?.range(of: "집밥")
            attributedString3.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.init(named: "turquoiseGreen") as Any, range: jipbapRange ?? NSRange())
            
            let jipbapPriceRange = (jipbapContentsLabel.text as NSString?)?.range(of: "50,000원을 덜")
            attributedString3.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.init(named: "turquoiseGreen") as Any, range: jipbapPriceRange ?? NSRange())
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
            let deliveryRange = (deliveryContentsLabel.text as NSString?)?.range(of: "외식과 배달")
            attributedString3.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.init(named: "turquoisePurple") as Any, range: deliveryRange ?? NSRange())
            
            let deliveryPriceRange = (deliveryContentsLabel.text as NSString?)?.range(of: "120,000원을 더")
            attributedString3.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.init(named: "turquoisePurple") as Any, range: deliveryPriceRange ?? NSRange())
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
        updateWeekMonthLabel(for: currentDate)
        setupMealWeekBarChart(jipbapAverage: 40, weekJipbapPrice: 50)
        setupDeliveryWeekBarChart(outAverage: 40, weekOutPrice: 50)
    }
    
    // MARK: - Function
    
    func updateGenderLabel(gender: String) {
        self.genderLabel.text = "소득이 비슷한 또래 \(gender) 대비"
    }
    
    func updateGipbapContentsLabel(jibapSave: Int) {
        let attributedString3 = NSMutableAttributedString(string: jipbapContentsLabel.text ?? "")
        let jipbapRange = (jipbapContentsLabel.text as NSString?)?.range(of: "집밥")
        attributedString3.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.init(named: "turquoiseGreen") as Any, range: jipbapRange ?? NSRange())
        if jibapSave < 0 {
            // 음수인 경우 "더" 사용
            self.jipbapContentsLabel.text = "집밥은 \(abs(jibapSave))원을 더 쓰고,"
        } else {
            // 양수인 경우 "덜" 사용
            self.jipbapContentsLabel.text = "집밥은 \(jibapSave)원을 덜 쓰고,"
        }
        let jipbapPriceRange = (jipbapContentsLabel.text as NSString?)?.range(of: "\(jibapSave)원을 덜")
        attributedString3.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.init(named: "turquoiseGreen") as Any, range: jipbapPriceRange ?? NSRange())
        jipbapContentsLabel.attributedText = attributedString3
    }

    
    func updateDeliveryContentsLabel(outSave: Int) {
        let attributedString3 = NSMutableAttributedString(string: deliveryContentsLabel.text ?? "")
        let deliveryRange = (deliveryContentsLabel.text as NSString?)?.range(of: "외식과 배달")
        attributedString3.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.init(named: "turquoisePurple") as Any, range: deliveryRange ?? NSRange())
        if outSave < 0 {
            // 음수인 경우 "덜" 사용
            self.deliveryContentsLabel.text = "외식과 배달은 \(abs(outSave))원을 덜 썼어요"
        } else {
            // 양수인 경우 "더" 사용
            self.deliveryContentsLabel.text = "외식과 배달은 \(outSave)원을 더 썼어요"
        }
        let deliveryPriceRange = (deliveryContentsLabel.text as NSString?)?.range(of: "\(outSave)원을 더")
        attributedString3.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.init(named: "turquoisePurple") as Any, range: deliveryPriceRange ?? NSRange())
        deliveryContentsLabel.attributedText = attributedString3
    }
    
    func updateWeekMonthLabel(for date: Date) {
        //let currentDate = Date()
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
    
    func setupMealWeekBarChart(jipbapAverage: Int,weekJipbapPrice: Int) {
        if let name = UserDefaults.standard.string(forKey: "userNickname") {
            let nameWithSuffix = "\(name) 님" // 닉네임 뒤에 "님"을 붙임
            let names = ["집밥 평균", nameWithSuffix]
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
        } else {
            print("사용자 닉네임이 존재하지 않습니다.")
        }
    }
    
    func setupDeliveryWeekBarChart(outAverage: Int,weekOutPrice: Int) {
        if let name = UserDefaults.standard.string(forKey: "userNickname") {
            let nameWithSuffix = "\(name) 님"
            
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
        } else {
            print("사용자 닉네임이 존재하지 않습니다.")
        }
    }
    //MARK: - Action
    @objc func weekBackTapped() {
        currentDate = Calendar.current.date(byAdding: .day, value: -7, to: currentDate) ?? Date()
        updateWeekMonthLabel(for: currentDate)
        let (year, month, date) = getCurrentYearMonthWeek(for: currentDate)
        delegate?.didSelectYearMonthDay(year: year, month: month, day: date)
    }
    
    @objc func weekNextTapped() {
        currentDate = Calendar.current.date(byAdding: .day, value: +7, to: currentDate) ?? Date()
        updateWeekMonthLabel(for: currentDate)
        let (year, month, date) = getCurrentYearMonthWeek(for: currentDate)
        delegate?.didSelectYearMonthDay(year: year, month: month, day: date)
    }
    
}
