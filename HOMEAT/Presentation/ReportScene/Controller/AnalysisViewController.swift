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
    var availableDates: [Date] = [] //날짜
    var name: String?
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
        weekInfo()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshData()
    }
    
    private func refreshData() {
        let currentDate = Date()
        let (year, month, day) = getCurrentYearMonthDay(for: currentDate)
        monthChart(year: year, month: month)
        weekChart(year: year, month: month, day: day)
        weekInfo()
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
                    self?.monthView.updateMonthContentLabel(text: "이달 지출 기록이 없습니다.")
                    self?.monthView.pieChart.isHidden = true
                    self?.monthView.barChartView.isHidden = true
                }
            default:
                print("응답 검증 오류")
                
            }
        }
    }
    
    // MARK: Week Server Function
    private func weekChart(year: Int, month: Int, day: Int) {
        let bodyDTO = AnalysisWeekRequestBodyDTO(input_year: "\(year)", input_month: "\(month)", input_day: "\(day)")
        print("Request Parameters: \(bodyDTO)")
        
        NetworkService.shared.analysisService.analysisWeek(bodyDTO: bodyDTO) { [weak self] response in
            switch response {
            case .success(let data):
                print("Response Data: \(data)")
                switch data.code {
                case "COMMON_200":
                    guard let analysisData = data.data else { return }
                    self?.weekView.handleWeekAnalysisData(analysisData)
                    self?.weekView.jipbapWeekBarChartView.isHidden = false
                    self?.weekView.deliveryWeekBarChartView.isHidden = false
                    if analysisData.jipbap_save == 0 &&
                                       analysisData.week_jipbap_price == 0 &&
                                       analysisData.out_average == 0 &&
                                       analysisData.week_out_price == 0 &&
                                       analysisData.out_save == 0 &&
                                       analysisData.jipbap_average == 0 {
                        self?.weekView.setupMealWeekBarChart(jipbapAverage: 50, weekJipbapPrice: 50, name: self?.name ?? "")
                        self?.weekView.setupDeliveryWeekBarChart(outAverage: 50, weekOutPrice: 50, name: self?.name ?? "")
                    } else if analysisData.week_jipbap_price == 0 &&
                                analysisData.jipbap_average == 0  {
                        self?.weekView.setupMealWeekBarChart(jipbapAverage: 50, weekJipbapPrice: 50, name: self?.name ?? "")
                    } else if analysisData.out_average == 0 &&
                                analysisData.week_out_price == 0 {
                        self?.weekView.setupDeliveryWeekBarChart(outAverage: 50, weekOutPrice: 50, name: self?.name ?? "")
                    }
                    
                case "REPORT_4040":
                    self?.weekView.updateErrorMessage("이달 주간 분석을 찾을 수 없습니다.")
                    self?.weekView.jipbapWeekBarChartView.isHidden = true
                    self?.weekView.deliveryWeekBarChartView.isHidden = true
                case "REPORT_4042":
                    self?.weekView.jipbapWeekBarChartView.isHidden = true
                    self?.weekView.deliveryWeekBarChartView.isHidden = true
                default:
                    print("Unknown response code: \(data.code)")
                }
                
            case .serverErr:
                print("서버 에러")
            default:
                print("데이터 존재 안함")
                self?.weekView.updateErrorMessage("이달 주간 분석을 찾을 수 없습니다.")
                self?.weekView.jipbapWeekBarChartView.isHidden = true
                self?.weekView.deliveryWeekBarChartView.isHidden = true
            }
        }
    }

    private func weekInfo() {
        NetworkService.shared.analysisService.analysisWeekInfo() { [weak self] response in
            switch response {
            case .success(let data):
                guard let analysisInfoData = data.data else { return }
                self?.weekView.handleWeekAnalysisInfoData(analysisInfoData)
                self?.ageButton.setTitle(data.data?.ageRange, for: .normal)
                self?.incomeMoneyButton.setTitle(data.data?.income, for: .normal)
                self?.name = data.data?.nickname ?? ""
            default:
                print("데이터 존재 안함")
            }
        }
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


    func weekBackButtonTapped() {
        guard let newDate = Calendar.current.date(byAdding: .weekOfMonth, value: -1, to: currentDate) else { return }
        currentDate = newDate
        let (year, month, date) = getCurrentYearMonthDay(for: currentDate)
        print(year,month,date)
        weekChart(year: year, month: month, day: date)
    }
    
    func weekNextButtonTapped() {
        guard let newDate = Calendar.current.date(byAdding: .weekOfMonth, value: 1, to: currentDate) else { return }
        currentDate = newDate
        let (year, month, date) = getCurrentYearMonthDay(for: currentDate)
        print(year,month,date)
        weekChart(year: year, month: month, day: date)
        
    }
    
    private func handleAnalysisData(_ data: AnalysisMonthResponseDTO) {
        monthView.setupPieChart(jipbapRatio: data.jipbap_ratio ?? 0,outRatio:data.out_ratio ?? 0)
        monthView.setupBarChart(jipbapPrice: data.month_jipbap_price ?? 0, outPrice: data.month_out_price ?? 0)
        monthView.setStyledMonthContentLabel(savePercent: Double(data.save_percent ?? 0))
    }
}
