//
//  RecipeWriteViewController.swift
//  HOMEAT
//
//  Created by 이지우 on 5/19/24.
//

import Foundation
import UIKit
import SnapKit
import Then

class RecipeWriteViewController: BaseViewController {
    
    //MARK: - Property
    
    
    //MARK: - LIfeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
    }
    
    //MARK: - SetUI
    private func setNavigationBar() {
        self.navigationController?.navigationItem.title = "집밥토크 글쓰기"
        self.navigationController?.navigationBar.tintColor = .white
    }
}
