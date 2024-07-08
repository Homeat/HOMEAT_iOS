//
//  CalendarView.swift
//  HOMEAT
//
//  Created by 강삼고 on 4/10/24.
//
import UIKit
import SnapKit
import Then

protocol CalendarViewDelegate: AnyObject {
    func calendarBackButtonTapped()
    func calendarNextButtonTapped()
    func didSelectDate(year: String, month: String, day: String)
}
class CalendarView: BaseView {
    weak var delegate : CalendarViewDelegate?
    var specialDates: Set<String> = Set()
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
    var calendarDate = Date()
    var year: Int = 2024
    var month: Int = 6
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
        delegate?.calendarBackButtonTapped()
        minusMonth()
    }
    
    @objc func isNextButtonTapped(_ sender: Any) {
        delegate?.calendarNextButtonTapped()
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
    
    private func startDayOfTheWeek() -> Int {
        return calendar.component(.weekday, from: calendarDate) - 1
    }
    
    private func endDate() -> Int {
        return calendar.range(of: .day, in: .month, for: calendarDate)?.count ?? Int()
    }
    
    private func updateCalendar() {
        updateTitle()
        updateDays()
        dayCollectionView.reloadData()
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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CalendarCollectionViewCell.identifier, for: indexPath) as? CalendarCollectionViewCell else {
            return UICollectionViewCell()
        }
        let day = self.days[indexPath.item]
        let date = "\(self.year)-\(self.month)-\(day)"
        
        cell.update(day: day)
        cell.backgroundColor = UIColor.coolGray4
        cell.dayLabel.textColor = .white
        
        for subview in cell.subviews {
            if subview != cell.dayLabel {
                subview.removeFromSuperview()
            }
        }
        
        if self.specialDates.contains(date) {
            cell.dayLabel.textColor = .black
        }
        
        self.addDayLabel(to: cell)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (dayCollectionView.frame.width - 10) / 7
        return CGSize(width: width, height: width * 0.8)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // 모든 보이는 셀의 배경색과 글자색을 초기화
        for visibleCell in collectionView.visibleCells {
            if let cell = visibleCell as? CalendarCollectionViewCell {
                let day = self.days[collectionView.indexPath(for: cell)!.item]
                cell.backgroundColor = UIColor.coolGray4
                cell.dayLabel.textColor = .white
                
            }
        }
        // 선택된 셀의 배경색과 글자색을 업데이트
        if let selectedCell = collectionView.cellForItem(at: indexPath) as? CalendarCollectionViewCell {
            //let day = self.days[indexPath.item]
            selectedCell.backgroundColor = .white
            selectedCell.dayLabel.textColor = .black
        }
        
        let selectedDate = calendar.date(byAdding: .day, value: indexPath.item - startDayOfTheWeek(), to: calendar.startOfDay(for: calendarDate))!
        // 선택된 날짜가 현재 월에 있는지 확인
        if !calendar.isDate(selectedDate, equalTo: calendarDate, toGranularity: .month) {
            return
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: selectedDate)
        var isSpecialDate = false
        for specialDate in self.specialDates {
            if specialDate == dateString {
                isSpecialDate = true
                print("specialdate=\(specialDate)")
                break
            }
        }
        if isSpecialDate {

        }
        let components = dateString.split(separator: "-")
        if components.count == 3 {
            delegate?.didSelectDate(year: String(components[0]), month: String(components[1]), day: String(components[2]))
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    func updateCellBackground(jipbapPercentage: Double, outPricePercentage: Double, forDate date: String) {
        print("Updating cell background for date: \(date) with jipbapPercentage: \(jipbapPercentage), outPricePercentage: \(outPricePercentage)")
        let components = date.split(separator: "-")
        guard let day = components.last else {
            print("Failed to extract day from date: \(date)")
            return
        }
        let dayString = String(Int(day) ?? 0)
        let jipbapColor = UIColor.turquoiseGreen
        let outPriceColor = UIColor.turquoisePurple
        print(dayString)
        DispatchQueue.main.async {
            for (index, cellDate) in self.days.enumerated() {
                print(cellDate)
                if cellDate == dayString {
                    if let cell = self.dayCollectionView.cellForItem(at: IndexPath(item: index, section: 0)) as? CalendarCollectionViewCell {
                        print("Found cell for date \(date) at index \(index)")
                        
                        let totalHeight = cell.frame.height
                        let jipbapHeight = totalHeight * CGFloat(jipbapPercentage / 100.0)
                        let outPriceHeight = totalHeight * CGFloat(outPricePercentage / 100.0)
                        cell.subviews.forEach { $0.removeFromSuperview() }
                        let jipbapView = UIView(frame: CGRect(x: 0, y: 0, width: cell.frame.width, height: jipbapHeight))
                        jipbapView.backgroundColor = jipbapColor
                        cell.addSubview(jipbapView)

                        let outPriceView = UIView(frame: CGRect(x: 0, y: jipbapHeight, width: cell.frame.width, height: outPriceHeight))
                        outPriceView.backgroundColor = outPriceColor
                        cell.addSubview(outPriceView)

                        cell.layer.cornerRadius = 10
                        cell.layer.masksToBounds = true
                        
                        // Re-add day label
                        self.addDayLabel(to: cell)
                        
                        print("Updated cell background for \(date) with jipbapHeight: \(jipbapHeight), outPriceHeight: \(outPriceHeight)")
                    } else {
                        print("Failed to find cell for date \(date) at index \(index)")
                    }
                    break
                }
            }
        }
    }
    
    private func addDayLabel(to cell: CalendarCollectionViewCell) {
        if cell.dayLabel.superview == nil {
            cell.addSubview(cell.dayLabel)
            cell.dayLabel.textColor = UIColor.white
            cell.dayLabel.font = .bodyBold18
            cell.dayLabel.snp.makeConstraints {
                $0.centerY.equalToSuperview()
                $0.centerX.equalToSuperview()
            }
        }
    }
    
    func refreshCalendar(data: [(date: String, jipbapPercentage: Double, outPricePercentage: Double)]) {
        DispatchQueue.main.async {
            for entry in data {
                self.updateCellBackground(jipbapPercentage: entry.jipbapPercentage, outPricePercentage: entry.outPricePercentage, forDate: entry.date)
                print(entry.jipbapPercentage,entry.outPricePercentage)
            }
            self.dayCollectionView.reloadData()
            
        }
    }
}
