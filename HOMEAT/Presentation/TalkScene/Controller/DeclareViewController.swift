//
//  declareViewController.swift
//  HOMEAT
//
//  Created by 이지우 on 5/5/24.
//

import UIKit

class DeclareViewController: BaseViewController {
    
    //MARK: - Property
    private let declareView = DeclareView()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isTranslucent = true
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isTranslucent = false
        self.tabBarController?.tabBar.isHidden = false
    }
    
    //MARK: - SetUI
    override func setConstraints() {
        view.addSubview(declareView)
        
        declareView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    private func setNavigationBar() {
        navigationItem.title = "게시글 신고하기"
        let backbutton = UIBarButtonItem()
        backbutton.tintColor = .white
        navigationController?.navigationBar.topItem?.backBarButtonItem = backbutton
    }
    
}
