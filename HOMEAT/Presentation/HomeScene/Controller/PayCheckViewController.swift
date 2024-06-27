//
//  PayCheckViewController.swift
//  HOMEAT
//
//  Created by 강삼고 on 4/3/24.
//

import UIKit
import SnapKit
import Then
import Alamofire

class PayCheckViewController : BaseViewController {
    
    //MARK: - Property
    private let eatoutIcon = UIImageView()
    private let homefoodIcon = UIImageView()
    private let eatoutTitleLabel = UILabel()
    private let homefoodTitleLabel = UILabel()
    private let calendarView = CalendarView()
    private let payCheckView = PayCheckView()
    private let checkDetailButton = UIButton()
    //MARK: - Function
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        calendarView.delegate = self
        let currentDate = Date()
        let calendar = Calendar.current
        let year = calendar.component(.year, from: currentDate)
        let month = String(format: "%02d", calendar.component(.month, from: currentDate))
        updateCalendar(year: String(year), month: month)
        
        setNavigationBar()
        setAddTarget()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setNavigationBar()
    }
    
    //MARK: - setConfigure
    override func setConfigure() {
        view.backgroundColor = UIColor(named: "homeBackgroundColor")
        
        eatoutIcon.do {
            $0.image = UIImage(named: "eatoutIcon")
        }
        
        homefoodIcon.do {
            $0.image = UIImage(named: "homefoodIcon")
        }
        
        eatoutTitleLabel.do {
            $0.text = "외식/배달"
            $0.font = UIFont(name: "NotoSansKR-Bold", size: 10)
            $0.textColor = UIColor(r: 30, g: 32, b: 33)
            $0.textAlignment = .center
            $0.layer.cornerRadius = 2
            $0.clipsToBounds = true
            $0.backgroundColor = UIColor(r: 157, g: 110, b: 255)
        }
        
        homefoodTitleLabel.do {
            $0.text = "집밥"
            $0.font = UIFont(name: "NotoSansKR-Bold", size: 10)
            $0.textColor = UIColor(r: 30, g: 32, b: 33)
            $0.textAlignment = .center
            $0.layer.cornerRadius = 2
            $0.clipsToBounds = true
            $0.backgroundColor = UIColor(named: "turquoiseGreen")
        }
        
        checkDetailButton.do {
            $0.setTitle("세부 지출 확인", for: .normal)
            $0.titleLabel?.font = UIFont(name: "NotoSansKR-Medium", size: 13.0)
            $0.setTitleColor(UIColor(named: "turquoiseGreen"), for: .normal)
        }
    }
    
    //MARK: - setConstraints
    override func setConstraints() {
        view.addSubviews(eatoutIcon, homefoodIcon, eatoutTitleLabel, homefoodTitleLabel, calendarView, payCheckView, checkDetailButton)
        
        eatoutIcon.snp.makeConstraints {
            $0.top.equalToSuperview().offset(116)
            $0.trailing.equalToSuperview().offset(-77)
        }
        
        homefoodIcon.snp.makeConstraints {
            $0.top.equalTo(eatoutIcon.snp.bottom).offset(9)
            $0.trailing.equalTo(eatoutIcon)
        }
        
        eatoutTitleLabel.snp.makeConstraints {
            $0.top.equalTo(eatoutIcon)
            $0.leading.equalTo(eatoutIcon.snp.trailing).offset(6)
            $0.trailing.equalToSuperview().offset(-21)
        }
        
        homefoodTitleLabel.snp.makeConstraints {
            $0.top.equalTo(homefoodIcon)
            $0.leading.equalTo(homefoodIcon.snp.trailing).offset(6)
            $0.trailing.equalToSuperview().offset(-21)
        }
        
        calendarView.snp.makeConstraints {
            $0.top.equalTo(homefoodIcon.snp.bottom).offset(17)
            $0.leading.equalToSuperview().offset(19)
            $0.trailing.equalToSuperview().offset(-18)
            $0.height.equalTo(345)
        }
        
        payCheckView.snp.makeConstraints {
            $0.top.equalTo(calendarView.snp.bottom).offset(33)
            $0.leading.equalTo(calendarView)
            $0.trailing.equalTo(calendarView)
            $0.bottom.equalToSuperview().offset(-113)
        }
        
        checkDetailButton.snp.makeConstraints {
            $0.top.equalTo(payCheckView).offset(-5)
            $0.trailing.equalTo(payCheckView)
        }
        
    }
    
    private func setNavigationBar() {
        self.navigationItem.title = "지출확인"
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.tintColor = .white
    }
    private func updateCalendar(year: String, month: String) {
        let request = CalendarCheckRequestBodyDTO(year: year, month: month)
        NetworkService.shared.homeSceneService.calendarCheck(queryDTO: request) { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let data):
                guard let calendarData = data.data else { return }
                let calendarEntries = calendarData.map { (date: $0.date, jipbapPercentage: Double($0.todayJipbapPricePercent), outPricePercentage: Double($0.todayOutPricePercent)) }
                DispatchQueue.main.async {
                    guard let currentMonth = Calendar.current.dateComponents([.year, .month], from: self.calendarView.calendarDate).month else { return }
                    let incomingMonth = Int(month)
                    if currentMonth == incomingMonth {
                        self.calendarView.refreshCalendar(data: calendarEntries)
                    }
                }
            default:
                print("서버 연동 실패")
            }
        }
    }

    private func setAddTarget() {
        checkDetailButton.addTarget(self, action: #selector(checkDetailButtonTapped), for: .touchUpInside)
    }
    
    //MARK: - @objc Func
    @objc func checkDetailButtonTapped(_ sender: UIButton) {
        self.navigationController?.pushViewController(PayCheckDetailViewController(), animated: true)
    }

}

extension PayCheckViewController: CalendarViewDelegate {
    func calendarBackButtonTapped() {
        var components = Calendar.current.dateComponents([.year, .month], from: calendarView.calendarDate)
        components.month = components.month! - 1
        let newDate = Calendar.current.date(from: components)!
        
        let year = Calendar.current.component(.year, from: newDate)
        let month = String(format: "%02d", Calendar.current.component(.month, from: newDate))
        print("전 월 \(year)\(month)")
        updateCalendar(year: String(year), month: month)
    }
    
    func calendarNextButtonTapped() {
        var components = Calendar.current.dateComponents([.year, .month], from: calendarView.calendarDate)
        components.month = components.month! + 1
        let newDate = Calendar.current.date(from: components)!
        
        let year = Calendar.current.component(.year, from: newDate)
        let month = String(format: "%02d", Calendar.current.component(.month, from: newDate))
        
        updateCalendar(year: String(year), month: month)
    }
}

