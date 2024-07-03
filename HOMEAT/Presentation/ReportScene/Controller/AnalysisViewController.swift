//
//  AnalysisViewController.swift
//  HOMEAT
//
//  Created by 김민솔 on 4/3/24.
// 소비분석 UI

import UIKit
import Then
import SnapKit
import Alamofire

class AnalysisViewController: BaseViewController,MonthViewDelegate,WeekViewDelegate {
    //MARK: - Property
    private var currentDate = Date()
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let deliveryImage = UIImageView()
    private let mealImage = UIImageView()
    private let deliveryLabel = UILabel()
    private let mealLabel = UILabel()
    private let monthView = MonthView()
    private let ageButton = UIButton()
    private let incomeMoneyButton = UIButton()
    private let weekView = WeekView()
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        let currentDate = Date()
        let (year, month, day) = getCurrentYearMonthDay(for: currentDate)
        print(year, month, day)
        monthChart(year: year, month: month)
        monthView.delegate = self
        weekView.delegate = self
        weekChart(year: year, month: month, day: day)
    }
    
    func getCurrentYearMonth(for date: Date) -> (year: Int, month: Int) {
        let calendar = Calendar.current
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        return (year, month)
    }
    func getCurrentYearMonthDay(for date: Date) -> (year: Int, month: Int, day: Int) {
        let calendar = Calendar.current
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        return (year, month, day)
    }
    override func setConfigure() {
        view.do {
            $0.backgroundColor = UIColor(r: 30, g: 32, b: 33)
        }
        
        deliveryImage.do {
            $0.image = UIImage(named: "deliveryLogo")
            $0.contentMode = .scaleAspectFit
            $0.clipsToBounds = true
        }
        
        mealImage.do {
            $0.image = UIImage(named: "homefoodLogo")
            $0.contentMode = .scaleAspectFit
            $0.clipsToBounds = true
        }
        
        deliveryLabel.do {
            $0.text = "외식/배달"
            $0.textColor = .black
            $0.textAlignment = .center
            $0.layer.cornerRadius = 2
            $0.layer.masksToBounds = true
            $0.font = .captionMedium10
            $0.backgroundColor = UIColor(named: "turquoisePurple")
        }
        
        mealLabel.do {
            $0.text = "집밥"
            $0.textColor = .black
            $0.textAlignment = .center
            $0.layer.cornerRadius = 2
            $0.layer.masksToBounds = true
            $0.font = .captionMedium10
            $0.backgroundColor = UIColor(named: "turquoiseGreen")
        }
        
        monthView.do {
            $0.layer.cornerRadius = 14
            $0.layer.masksToBounds = true
            $0.backgroundColor = UIColor(named: "turquoiseGray")
        }
        
        ageButton.do {
            $0.layer.cornerRadius = 16
            $0.clipsToBounds = true
            $0.setTitleColor(UIColor(named: "turquoiseGreen"), for: .normal)
            $0.layer.borderColor = UIColor(named: "turquoiseGreen")?.cgColor ?? UIColor.green.cgColor
            $0.layer.borderWidth = 1.6
            $0.titleLabel?.font = .captionMedium13
        }
        
        incomeMoneyButton.do {
            $0.layer.cornerRadius = 16.3
            $0.clipsToBounds = true
            $0.setTitleColor(UIColor(named: "turquoiseGreen"), for: .normal)
            $0.layer.borderColor = UIColor(named: "turquoiseGreen")?.cgColor ?? UIColor.green.cgColor
            $0.layer.borderWidth = 1.6
            $0.titleLabel?.font = .captionMedium13
        }
        
        weekView.do {
            $0.layer.cornerRadius = 14
            $0.layer.masksToBounds = true
            $0.backgroundColor = UIColor(named: "turquoiseGray")
        }
    }
    
    override func setConstraints() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubviews(deliveryImage,deliveryLabel,mealImage,mealLabel,monthView,ageButton,incomeMoneyButton,weekView)
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(40)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalTo(scrollView.frameLayoutGuide)
            $0.height.equalTo(1130)
        }
        
        deliveryImage.snp.makeConstraints {
            $0.width.equalTo(15)
            $0.top.equalTo(deliveryLabel.snp.top)
            $0.bottom.equalTo(deliveryLabel.snp.bottom)
            $0.trailing.equalTo(deliveryLabel.snp.leading).offset(-10)
        }
        
        deliveryLabel.snp.makeConstraints {
            $0.height.equalTo(15)
            $0.top.equalToSuperview().inset(20)
            $0.leading.equalTo(deliveryImage.snp.trailing).offset(6)
            $0.trailing.equalToSuperview().inset(21)
        }
        
        mealImage.snp.makeConstraints {
            $0.width.equalTo(15)
            $0.top.equalTo(mealLabel.snp.top)
            $0.bottom.equalTo(mealLabel.snp.bottom)
            $0.leading.equalTo(deliveryImage.snp.leading)
        }
        
        mealLabel.snp.makeConstraints {
            $0.height.equalTo(15)
            $0.top.equalTo(deliveryLabel.snp.bottom).offset(9)
            $0.leading.equalTo(deliveryLabel.snp.leading)
            $0.trailing.equalToSuperview().inset(21)
        }
        
        monthView.snp.makeConstraints {
            $0.height.equalTo(345)
            $0.top.equalTo(mealImage.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(19)
        }
        
        ageButton.snp.makeConstraints {
            $0.top.equalTo(monthView.snp.bottom).offset(46)
            $0.leading.equalToSuperview().inset(21)
            $0.width.equalTo(81.7)
            $0.height.equalTo(31.1)
        }
        
        incomeMoneyButton.snp.makeConstraints {
            $0.top.equalTo(ageButton.snp.top)
            $0.leading.equalTo(ageButton.snp.trailing).offset(11.7)
            $0.width.equalTo(120.6)
            $0.height.equalTo(31.1)
        }
        
        weekView.snp.makeConstraints {
            $0.top.equalTo(ageButton.snp.bottom).offset(18.9)
            $0.leading.trailing.equalToSuperview().inset(19)
            $0.height.equalTo(570)
            
        }
    }
    
    // MARK: Month Server Function
    private func monthChart(year: Int, month: Int) {
        let bodyDTO = AnalysisMonthRequestBodyDTO(input_year: "\(year)", input_month: "\(month)")
        NetworkService.shared.analysisService.analysisMonth(bodyDTO: bodyDTO) { [weak self] response in
            switch response {
            case .success(let data):
                if data.code == "COMMON_200" {
                    guard let analysisData = data.data else {
                        self?.updateMonthContentLabel(text: "이달 지출 기록이 없습니다.")
                        self?.monthView.pieChart.isHidden = true
                        self?.monthView.barChartView.isHidden = true
                        return
                    }
                    self?.handleAnalysisData(analysisData)
                    self?.monthView.pieChart.isHidden = false
                    self?.monthView.barChartView.isHidden = false
                } else if data.code == "REPORT_4041" {
                    
                    self?.monthView.updateMonthContentLabel(text: "이달 지출 기록이 없습니다.")
                    self?.monthView.pieChart.isHidden = true
                    self?.monthView.barChartView.isHidden = true
                } else if data.code == "REPORT_4222" {
                    self?.monthView.updateMonthContentLabel(text: "이달 지출 기록이 없습니다.")
                    self?.monthView.pieChart.isHidden = true
                    self?.monthView.barChartView.isHidden = true
                } else {
                    self?.monthView.updateMonthContentLabel(text: "알 수 없는 오류가 발생했습니다.")
                    self?.monthView.pieChart.isHidden = true
                    self?.monthView.barChartView.isHidden = true
                }
            default:
                print("응답 검증 오류")
                
            }
        }
    }
    
    // MARK: Week Server Function
    private func weekChart(year: Int, month: Int,day: Int) {
        let bodyDTO = AnalysisWeekRequestBodyDTO(input_year: "\(year)", input_month: "\(month)", input_day: "\(day)")
        print("Request Parameters: \(bodyDTO)")
        NetworkService.shared.analysisService.analysisWeek(bodyDTO: bodyDTO) { [weak self] response in
            switch response {
            case .success(let data):
                print("Response Data: \(data)")
                print("Response Code: \(data.code)")
                if data.code == "COMMON_200" {
                    guard let analysisData = data.data else { return }
                    self?.ageButton.setTitle(analysisData.age_range, for: .normal)
                    self?.incomeMoneyButton.setTitle(analysisData.income, for: .normal)
                    self?.handleWeekAnalysisData(analysisData)
                } else if data.code == "REPORT_4040" {
                    self?.weekView.updateWeekContentLabel(text: "이달 주간 분석을 찾을 수 없습니다.")
                    self?.weekView.jipbapWeekBarChartView.isHidden = true
                    self?.weekView.deliveryWeekBarChartView.isHidden = true
                } else if data.code == "REPORT_4221" {
                    self?.weekView.updateWeekContentLabel(text: "주간 분석 없어요")
                    self?.weekView.jipbapWeekBarChartView.isHidden = true
                    self?.weekView.deliveryWeekBarChartView.isHidden = true
                } else if data.code == "COMMON_500" {
                    if let errorDataString = data.data as? String,
                       let errorData = self?.parseErrorData(errorDataString) {
                        print("Error Data: AgeRange=\(errorData.ageRange), Income=\(errorData.income)")
                        self?.ageButton.setTitle(errorData.ageRange, for: .normal)
                        self?.incomeMoneyButton.setTitle(errorData.income, for: .normal)
                    } else {
                        self?.weekView.updateWeekContentLabel(text: "서버 에러 발생")
                    }
                } else {
                    print("Unknown response code: \(data.code)")
                }

            case .serverErr:
                print("서버 에러")

            default:
                print("데이터 존재 안함")
            }
        }
    }
    
    // MARK: - Function
    private func parseErrorData(_ errorDataString: String) -> ErrorData? {
        let components = errorDataString.components(separatedBy: ", ")
        var ageRange = ""
        var income = ""
        
        for component in components {
            if component.hasPrefix("AgeRange") {
                ageRange = component.replacingOccurrences(of: "AgeRange: ", with: "")
            } else if component.hasPrefix("Income") {
                income = component.replacingOccurrences(of: "Income: ", with: "")
            }
        }
        
        return ErrorData(ageRange: ageRange, income: income)
    }
    
    func updateMonthContentLabel(text: String) {
        monthView.updateMonthContentLabel(text: text)
    }
    
    func monthBackButtonTapped() {
        currentDate = Calendar.current.date(byAdding: .month, value: -1, to: currentDate) ?? Date()
        let (year, month) = getCurrentYearMonth(for: currentDate)
        print(year,month)
        monthChart(year: year, month: month)
    }
    
    func monthNextButtonTapped() {
        currentDate = Calendar.current.date(byAdding: .month, value: +1, to: currentDate) ?? Date()
        let (year, month) = getCurrentYearMonth(for: currentDate)
        print(year,month)
        monthChart(year: year, month: month)
    }
    func updateWeekContentLabel(text: String) {
        weekView.updateWeekContentLabel(text: text)
    }
    //전 달 버튼 tapp
    func weekBackButtonTapped() {
        currentDate = Calendar.current.date(byAdding: .day, value: -7, to: currentDate) ?? Date()
        let (year, month, date) = getCurrentYearMonthDay(for: currentDate)
        print(year,month,date)
        weekChart(year: year, month: month, day: date)
    }
    
    func weekNextButtonTapped() {
        currentDate = Calendar.current.date(byAdding: .day, value: +7, to: currentDate) ?? Date()
        let (year, month, date) = getCurrentYearMonthDay(for: currentDate)
        print(year,month,date)
        weekChart(year: year, month: month, day: date)
        
    }
    private func updateUserInfo(_ data: AnalysisWeekResponseDTO) {
        ageButton.titleLabel?.text = data.age_range
        incomeMoneyButton.titleLabel?.text = data.income
    }
    
    private func handleAnalysisData(_ data: AnalysisMonthResponseDTO) {
        monthView.setupPieChart(jipbapRatio: data.jipbap_ratio ?? 0,outRatio:data.out_ratio ?? 0)
        monthView.setupBarChart(jipbapPrice: data.month_jipbap_price ?? 0, outPrice: data.month_out_price ?? 0)
        monthView.setStyledMonthContentLabel(savePercent: Double(data.save_percent ?? 0))
    }
    
    private func handleWeekAnalysisData(_ data: AnalysisWeekResponseDTO) {
        weekView.updateGenderLabel(gender: data.gender)
        //        weekView.updateGipbapContentsLabel(jibapSave: data.jipbapSave)
        //        weekView.updateDeliveryContentsLabel(outSave: data.outSave)
        weekView.setupMealWeekBarChart(jipbapAverage: data.jipbap_average ?? 0, weekJipbapPrice: data.week_jipbap_price ?? 0)
        weekView.setupDeliveryWeekBarChart(outAverage: data.out_average ?? 0, weekOutPrice: data.week_out_price ?? 0)
    }
}
