//
//  TalkViewController.swift
//  HOMEAT
//
//  Created by 강석호 on 4/1/24.
//

import Foundation
import UIKit
import SnapKit
import Tabman
import Pageboy

class TalkViewController: TabmanViewController {
    
    private var viewcontrollers : Array<UIViewController> = [] //뷰 컨트롤러의 뷰를 넣을 배열
    private let containerView = UIView()
    private let tabBar = TMBar.ButtonBar()
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "홈잇토크"
        setViewControllers()
        setConstraints()
        setConfigure()
        setupUI()
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        self.navigationController?.navigationBar.titleTextAttributes =  [NSAttributedString.Key.foregroundColor: UIColor.white]
        view.backgroundColor = UIColor(r: 30, g: 32, b: 33)
    }
    
    private func setConfigure() {
        tabBar.do {
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
        containerView.do {
            $0.backgroundColor = .clear
        }
    }
    
    private func setViewControllers() {
        let foodTalkViewController = FoodTalkViewController()
        let infoTalkViewController = InfoTalkViewController()     
        viewcontrollers.append(contentsOf: [foodTalkViewController, infoTalkViewController])
    }
    
    private func setConstraints() {
        tabBar.dataSource = self
        dataSource = self
        addBar(tabBar, dataSource: self, at: .custom(view: containerView, layout: nil))
        view.addSubview(containerView)
        containerView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(40)
        }
    }
    func switchToInfoTalk() {
        self.scrollToPage(.at(index: 1), animated: true)
    }
}

// MARK: - Extension
extension TalkViewController: PageboyViewControllerDataSource, TMBarDataSource {
    
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return viewcontrollers.count
    }
    
    func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController? {
        return viewcontrollers[index]
    }
    
    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return nil
    }
    
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        let title = index == 0 ? "집밥토크" : "정보토크"
        return TMBarItem(title: title)
    }
}
