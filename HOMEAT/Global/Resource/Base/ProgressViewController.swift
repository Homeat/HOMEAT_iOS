//
//  ProgressViewController.swift
//  HOMEAT
//
//  Created by 강삼고 on 5/8/24.
//

import Foundation
import UIKit

class ProgressViewController: UIViewController {

    var progressBar = UIProgressView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setConfigure()
        setProgressBar()
        setConstraints()
    }
    
    func setProgressBar() {
        progressBar.do {
            $0.progressViewStyle = .default
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.progressTintColor = UIColor(named: "turquoiseGreen")
            $0.progress = 0.0
        }
    }
    
    func setConstraints() {
        view.addSubview(progressBar)
        progressBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
    }
    
    func setConfigure() { 
        view.backgroundColor = UIColor(named: "homeBackgroundColor")
    }

    func updateProgressBar(progress: Float) {
        progressBar.progress = progress
    }
}
