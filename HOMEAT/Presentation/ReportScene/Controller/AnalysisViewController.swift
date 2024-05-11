//
//  AnalysisViewController.swift
//  HOMEAT
//
//  Created by 김민솔 on 4/3/24.
// 소비분석 UI

import UIKit
import Then
import SnapKit

class AnalysisViewController: BaseViewController,MonthViewDelegate,WeakViewDelegate {
    
    //MARK: - Property
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let deliveryImage = UIImageView()
    private let mealImage = UIImageView()
    private let deliveryLabel = UILabel()
    private let mealLabel = UILabel()
    private let monthView = MonthView()
    private let ageButton = UIButton()
    private let incomeMoneyButton = UIButton()
    private let weekView = WeakView()
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
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
            $0.setTitle("20대", for: .normal)
            $0.layer.cornerRadius = 16
            $0.clipsToBounds = true
            $0.setTitleColor(UIColor(named: "turquoiseGreen"), for: .normal)
            $0.layer.borderColor = UIColor(named: "turquoiseGreen")?.cgColor
            $0.layer.borderWidth = 1.6
            $0.titleLabel?.font = .captionMedium13
        }
        
        incomeMoneyButton.do {
            $0.setTitle("소득 100만원 이하", for: .normal)
            $0.layer.cornerRadius = 16.3
            $0.clipsToBounds = true
            $0.setTitleColor(UIColor(named: "turquoiseGreen"), for: .normal)
            $0.layer.borderColor = UIColor(named: "turquoiseGreen")?.cgColor
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
    
    // MARK: - MonthViewDelegate
    func didSelectYearMonth(year: Int, month: Int) {
        monthChart(year: year, month: month)
    }
    
    // MARK: Month Server Function
    private func monthChart(year: Int, month: Int) {
        let bodyDTO = AnalysisMonthRequestBodyDTO(inputYear: "\(year)", inputMonth: "\(month)")
        NetworkService.shared.analysisService.analysisMonth(bodyDTO: bodyDTO) { [weak self] response in
            switch response {
            case .success(let data):
                guard let analysisData = data.data else { return }
                self?.handleAnalysisData(analysisData)
            default :
                print("데이터 존재 안함 ")
            }
        }
    }
    
    // MARK: - WeekViewDelegate
    func didSelectYearMonthDay(year: Int, month: Int, day: Int) {
        weekChart(year: year, month: month, day: day)
    }
    // MARK: Week Server Function
    private func weekChart(year: Int, month: Int,day: Int) {
        let bodyDTO = AnalysisWeekRequestBodyDTO(inputYear: "\(year)", inputMonth: "\(month)", inputDay: "\(day)")
        NetworkService.shared.analysisService.analysisWeek(bodyDTO: bodyDTO) { [weak self] response in
            switch response {
            case .success(let data):
                guard let analysisData = data.data else { return }
                self?.handleWeekAnalysisData(analysisData)
                self?.updateUserInfo(analysisData)
            default:
                print("데이터 존재 안함")
            }
        }
    }
    
    // MARK: - Function
    private func updateUserInfo(_ data: AnalysisWeekResponseDTO) {
        ageButton.titleLabel?.text = data.ageRange
        incomeMoneyButton.titleLabel?.text = data.income
    }
    
    private func handleAnalysisData(_ data: AnalysisMonthResponseDTO) {
        monthView.setupPieChart(jipbapRatio: data.jipbapRatio,outRatio:data.outRatio)
        monthView.setupBarChart(jipbapPrice: Double(data.jipbapMonthPrice), outPrice: Double(data.jipbapMonthOutPrice))
        monthView.setStyledMonthContentLabel(savePercent: Double(data.savePercent) ?? 0)
    }
    
    private func handleWeekAnalysisData(_ data: AnalysisWeekResponseDTO) {
        weekView.updateGenderLabel(gender: data.gender)
        weekView.updateGipbapContentsLabel(jibapSave: data.jipbapSave)
        weekView.updateDeliveryContentsLabel(outSave: data.outSave)
        weekView.setupMealWeekBarChart(jipbapAverage: data.jipbapAverage, weekJipbapPrice: data.weekJipbapPrice)
        weekView.setupDeliveryWeekBarChart(outAverage: data.outAverage, weekOutPrice: data.weekOutPrice)
    }
}
