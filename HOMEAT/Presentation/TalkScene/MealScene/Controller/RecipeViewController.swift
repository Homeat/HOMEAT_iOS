//
//  RecipeViewController.swift
//  HOMEAT
//
//  Created by 이지우 on 5/11/24.
//

import Foundation
import UIKit
import SnapKit
import Then

class RecipeViewController: BaseViewController {
    
    //MARK: - Property
    private let tableView = UITableView(frame: CGRect.zero, style: .grouped)
    private let ingredientView = IngredientView()
    
    var foodTalkRecipes: [FoodTalkRecipe]
    
    init(foodTalkRecipes: [FoodTalkRecipe]) {
        self.foodTalkRecipes = foodTalkRecipes
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        setTableView()
        setTabbar()
        print(foodTalkRecipes.count)
    }
    
    //MARK: - SetUI
    override func setConfigure() {
        
        view.do {
            $0.backgroundColor = UIColor(named: "homeBackgroundColor")
        }
        
        tableView.do {
            $0.backgroundColor = UIColor(named: "homeBackgroundColor")
        }
    }
    
    override func setConstraints() {
        view.addSubviews(tableView)
        
        tableView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    func setNavigationBar() {
        self.navigationItem.title = "연어 샐러드 레시피"
        let backbutton = UIBarButtonItem()
        backbutton.tintColor = .white
        navigationController?.navigationBar.topItem?.backBarButtonItem = backbutton
    }
    
    private func setTabbar() {
        tabBarController?.tabBar.isHidden = true
        tabBarController?.tabBar.isTranslucent = true
    }
    
    private func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.register(RecipeStepCell.self, forCellReuseIdentifier: "RecipeStepCell")
        tableView.register(IngredientView.self, forHeaderFooterViewReuseIdentifier: "IngredientView")
        tableView.separatorStyle = .none
        tableView.reloadData()
        tableView.layoutIfNeeded()
    }
    
}

//MARK: - Extension
extension RecipeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeStepCell") as! RecipeStepCell
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor(named: "homeBackgroundColor")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "IngredientView") as! IngredientView
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 320
    }
}
