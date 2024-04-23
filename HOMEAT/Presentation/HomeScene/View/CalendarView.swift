//
//  CalendarView.swift
//  HOMEAT
//
//  Created by 강삼고 on 4/10/24.
//

import Foundation
import UIKit
import SnapKit
import Then

class CalendarView: BaseView {
    
    //MARK: - component
    private let leftHole = UIImageView()
    private let rightHole = UIImageView()
    private let circleSize: CGFloat = 15
    private let previousButton = UIButton()
    private let nextButton = UIButton()
    private let dateLabel = UILabel()
    private let weekStackView = UIStackView()
    private let dayCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    //calendar 관련 컴포넌트
    private let calendar = Calendar.current
    private let dateFormatter = DateFormatter()
    private var calendarDate = Date()
    private var days = [String]()
    
    //MARK: - Function
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureWeekLabel()
        configureCalender()
        setAddTarget()
    }
    //MARK: - setConfigure
    override func setConfigure() {
        super.setConfigure()
        
        self.backgroundColor = UIColor(named: "coolGray4")
        self.layer.cornerRadius = 14
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
        
        previousButton.do {
            $0.setImage(UIImage(named: "previousButtonIcon"), for: .normal)
        }
        
        nextButton.do {
            $0.setImage(UIImage(named: "nextButtonIcon"), for: .normal)
        }
        
        dateLabel.do {
            $0.text = "2024년 4월"
            $0.font = .bodyMedium18
            $0.textColor = .white
        }
        
        weekStackView.do {
            $0.spacing = 33
            $0.axis = .horizontal
            $0.alignment = .fill
            $0.distribution = .fillEqually
        }
        
        dayCollectionView.do {
            $0.backgroundColor = UIColor(named: "coolGray4")
            $0.frame = .zero
            $0.collectionViewLayout = UICollectionViewFlowLayout()
            $0.dataSource = self
            $0.delegate = self
            $0.register(CalendarCollectionViewCell.self, forCellWithReuseIdentifier: CalendarCollectionViewCell.identifier)
        }
    }
    
    //MARK: - setConstraints
    override func setConstraints() {
        super.setConstraints()
        self.addSubviews(leftHole, rightHole, previousButton, nextButton, dateLabel, weekStackView, dayCollectionView)
        
        leftHole.snp.makeConstraints {
            $0.top.equalTo(self).offset(10)
            $0.width.equalTo(15)
            $0.height.equalTo(15)
            $0.leading.equalTo(self).offset(11)
        }
        
        rightHole.snp.makeConstraints {
            $0.top.equalTo(self).offset(10)
            $0.width.equalTo(15)
            $0.height.equalTo(15)
            $0.trailing.equalTo(self).offset(-11)
        }
        
        previousButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(22)
            $0.leading.equalToSuperview().offset(107)
        }
        
        nextButton.snp.makeConstraints {
            $0.top.equalTo(previousButton)
            $0.trailing.equalToSuperview().offset(-108)
        }
        
        dateLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalTo(previousButton)
        }
        
        weekStackView.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
        }
        
        dayCollectionView.snp.makeConstraints {
            $0.top.equalTo(weekStackView.snp.bottom).offset(13)
            $0.leading.equalToSuperview().offset(5)
            $0.trailing.equalToSuperview().offset(-5)
            $0.bottom.equalToSuperview()
        }
    }
    
    private func setAddTarget() {
        previousButton.addTarget(self, action: #selector(isPreviousButtonTapped), for: .touchUpInside)
        
        nextButton.addTarget(self, action: #selector(isNextButtonTapped), for: .touchUpInside)
    }
    
    //MARK: - @objc Func
    @objc func isPreviousButtonTapped(_ sender: Any) {
        minusMonth()
    }
    
    @objc func isNextButtonTapped(_ sender: Any) {
        plusMonth()
    }
}

extension CalendarView {
    
    private func configureWeekLabel() {
        let dayOfTheWeek = ["일", "월", "화", "수", "목", "금", "토"]
        
        for i in 0..<7 {
            let label = UILabel()
            label.text = dayOfTheWeek[i]
            label.textColor = UIColor.white
            label.textAlignment = .center
            label.font = .bodyMedium18
            self.weekStackView.addArrangedSubview(label)
        }
    }
    
    private func configureCalender() {
        let components = calendar.dateComponents([.year, .month], from: Date())
        calendarDate = calendar.date(from: components) ?? Date()
        dateFormatter.dateFormat = "yyyy년 MM월"
        updateCalendar()
        
    }
    //시작 요일 반환
    private func startDayOfTheWeek() -> Int {
        return calendar.component(.weekday, from: calendarDate) - 1
    }
    
    private func endDate() -> Int {
        return calendar.range(of: .day, in: .month, for: calendarDate)?.count ?? Int()
    }
    
    private func updateCalendar() {
        updateTitle()
        updateDays()
    }
    
    private func updateTitle() {
        let date = dateFormatter.string(from: calendarDate)
        dateLabel.text = date
    }
    
    private func updateDays() {
        days.removeAll()
        let startDayOfTheWeek = startDayOfTheWeek()
        let totalDays = startDayOfTheWeek + endDate()
        
        for day in Int()..<totalDays {
            if day < startDayOfTheWeek {
                days.append(String())
                continue
            }
            days.append("\(day - startDayOfTheWeek + 1)")
        }
        
        dayCollectionView.reloadData()
    }
    
    private func minusMonth() {
        calendarDate = calendar.date(byAdding: DateComponents(month: -1), to: calendarDate) ?? Date()
        updateCalendar()
    }
    
    private func plusMonth() {
        calendarDate = calendar.date(byAdding: DateComponents(month: 1), to: calendarDate) ?? Date()
        updateCalendar()
    }
    
}

extension CalendarView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return days.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CalendarCollectionViewCell.identifier, for: indexPath) as? CalendarCollectionViewCell else {return UICollectionViewCell()}
        cell.update(day: days[indexPath.item])
        
        return cell
    }
    
    //cell 높이, 넓이 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (dayCollectionView.frame.width-10) / 7
        return CGSize(width: width, height: width * 0.8)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
}
