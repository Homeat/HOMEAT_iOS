//
//  PayCheckDetailViewController.swift
//  HOMEAT
//
//  Created by 강삼고 on 4/10/24.
//

import UIKit
import SnapKit
import Then

class PayCheckDetailViewController: BaseViewController {
    
    //MARK: - Property
    private let payCheckView = PayCheckView()
    private let devideLine = UIView()
    private let tableView = UITableView()
    private var day: String
    private var year: String
    private var month: String
    private var date: String
    private var homeAmount: String
    private var eatOutAmount: String
    private var leftAmount: String
    var payDetails: [PayDetailsResponseDTO] = []

    init(day: String,year: String, month:String,date:String, homeAmount: String, eatOutAmount: String, leftAmount: String) {
        self.day = day
        self.year = year
        self.month = month
        self.date = date
        self.homeAmount = homeAmount
        self.eatOutAmount = eatOutAmount
        self.leftAmount = leftAmount
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        payCheckView.updateDateLabel(date: day)
        payCheckView.updateSpentLabel(homeAmount: homeAmount, eatOutAmount: eatOutAmount, leftAmount: leftAmount)
        updateTableView()
    }
    
    // MARK: - 탭바제거
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let tabBarController = self.tabBarController as? HOMEATTabBarController {
            tabBarController.tabBar.isHidden = true
        }
        self.tabBarController?.tabBar.isTranslucent = true

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let tabBarController = self.tabBarController as? HOMEATTabBarController {
            tabBarController.tabBar.isHidden = false
        }
        self.tabBarController?.tabBar.isTranslucent = false

    }
    
    override func setConfigure() {
        view.backgroundColor = UIColor(named: "homeBackgroundColor")
        
        devideLine.do {
            $0.backgroundColor = UIColor(r: 102, g: 102, b: 102)
        }
        tableView.do {
            $0.dataSource = self
            $0.delegate = self
            $0.allowsSelection = true
            $0.backgroundColor = UIColor(r: 30, g: 32, b: 33)
            $0.showsVerticalScrollIndicator = true
            $0.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            $0.register(PayDetailTableViewCell.self, forCellReuseIdentifier: PayDetailTableViewCell.identifier)
           
        }
    }
    
    override func setConstraints() {
        view.addSubviews(payCheckView, devideLine,tableView)
        
        payCheckView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(40)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(150)
        }
        
        devideLine.snp.makeConstraints {
            $0.top.equalTo(payCheckView.snp.bottom)
            $0.height.equalTo(1)
            $0.leading.equalTo(payCheckView)
            $0.trailing.equalTo(payCheckView)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(devideLine.snp.bottom).offset(20)
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
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
    func updateTableView() {
        let request = PayDetailRequestBodyDTO(year: year, month: month, day: date, remainingGoal: Int(leftAmount) ?? 0)
        NetworkService.shared.homeSceneService.calendarDetailCheck(queryDTO: request) { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let data):
                if let payDetailData = data.data {
                    self.payDetails = payDetailData.sorted(by: { $0.remainingGoal > $1.remainingGoal })
                    self.tableView.reloadData()
                } else {
                    print("No data available")
                }
                print("서버연동 성공 ")
            default:
                print("서버 연동 실패")
            }
        }
    }



}


// MARK: - UITableViewDataSource
extension PayCheckDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return payDetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PayDetailTableViewCell.identifier, for: indexPath) as? PayDetailTableViewCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        let detail = payDetails[indexPath.row]
        let type = (detail.type == "외식비" || detail.type == "배달비") ? "배달/외식" : "집밥"
        let formattedUsedMoney = detail.usedMoney.formattedWithSeparator
        let formattedRemainingGoal = detail.remainingGoal.formattedWithSeparator
                
        cell.configure(type: type, amount: formattedUsedMoney, tag: "#\(detail.type)", leftAmount: formattedRemainingGoal, memo: detail.memo)
                
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension PayCheckDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

