//
//  UserInfoModifyViewController.swift
//  HOMEAT
//
//  Created by 강석호 on 4/5/24.
//

import Foundation
import UIKit


class UserInfoModifyViewController : BaseViewController {
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigation()
    }
    
    // MARK: UI
    override func setConfigure() {
        view.do {
            $0.backgroundColor = UIColor(r: 30, g: 32, b: 33)
        }
    }
    
    override func setConstraints() {
        
    }
    
    private func setNavigation() {
        self.navigationItem.title = "닉네임 변경"
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.tintColor = .white
    }
}
