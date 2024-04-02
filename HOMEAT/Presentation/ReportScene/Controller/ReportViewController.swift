//
//  ReportViewController.swift
//  HOMEAT
//
//  Created by 강석호 on 4/1/24.
//

import Foundation
import UIKit
import Charts
import Tabman
import Pageboy

class ReportViewController: TabmanViewController {
    private var viewcontrollers : Array<UIViewController> = [] //뷰 컨트롤러의 뷰를 넣을 배열
    private let containerView = UIView()
    
    private let tabBar = TMBar.ButtonBar().then {
            $0.backgroundView.style = .clear
            $0.layout.transitionStyle = .snap
            $0.layout.contentMode = .fit
            $0.buttons.customize { button in
                button.selectedTintColor = .white
                button.tintColor = .gray
            }
            $0.indicator.weight = .custom(value: 2)
            $0.indicator.tintColor = .white
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "홈잇리포트"
        setViewControllers()
        setConstraints()
        setupUI()
    }
   
    // MARK: - UI Setup
    private func setupUI() {
        view.backgroundColor = .white
    }
    private func setViewControllers() {
        let analysisViewController = AnalysisViewController()
        let weeklookViewController = WeekLookViewController()
        
        viewcontrollers.append(contentsOf: [analysisViewController, weeklookViewController])
    }
    func setConstraints() {
        view.addSubview(containerView)
        containerView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(40)
        }
    }
    
}
