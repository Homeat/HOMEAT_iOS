//
//  HOMEATTabBarViewController.swift
//  HOMEAT
//
//  Created by 강석호 on 4/1/24.
//

import Foundation
import UIKit

class HOMEATTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllers()
        setupTabBarAppearance()
    }
    
    private func setupViewControllers() {
        
        let homeVC = HomeViewController()
        let reportVC = ReportViewController()
        let talkVC = TalkViewController()
        let mypageVC = MyPageViewController()
        
        homeVC.tabBarItem = UITabBarItem(title: "홈", image: UIImage(systemName: "house"), selectedImage: nil)
        reportVC.tabBarItem = UITabBarItem(title: "홈잇리포트", image: UIImage(systemName: "star"), selectedImage: nil)
        talkVC.tabBarItem = UITabBarItem(title: "홈잇토크", image: UIImage(systemName: "plus"), selectedImage: nil)
        mypageVC.tabBarItem = UITabBarItem(title: "마이페이지", image: UIImage(systemName: "gear"), selectedImage: nil)
        
        let controllers = [homeVC, reportVC, talkVC, mypageVC]
        self.viewControllers = controllers.map { UINavigationController(rootViewController: $0) }
        
    }
    
    private func setupTabBarAppearance() {
        tabBar.isTranslucent = false
        setTabBarColors(
            backgroundColor: UIColor(r: 54, g: 56, b: 57),
            tintColor: UIColor(r: 7, g: 231, b: 149),
            unselectedItemTintColor: UIColor(r: 216, g: 216, b: 216)
        )
    }
    
    private func setTabBarColors(backgroundColor: UIColor, tintColor: UIColor, unselectedItemTintColor: UIColor) {
        tabBar.backgroundColor = backgroundColor
        tabBar.tintColor = tintColor
        tabBar.unselectedItemTintColor = unselectedItemTintColor
    }
}
