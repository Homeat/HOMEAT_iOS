//
//  FoodTalkController.swift
//  HOMEAT
//
//  Created by 이지우 on 4/4/24.
//

import Foundation
import UIKit
import Then

class FoodTalkViewController: BaseViewController {
    
    //MARK: - Property
    
    private let searchBar = UISearchBar()
    private let listButton = UIButton()
    private let scrollView = UIScrollView()
    //버튼이 여러개 존재하는데 재사용 파일을 만들어야 하나?
    private let mainButton = UIButton()
    private let weekButton = UIButton()
    private let breakfastButton = UIButton()
    private let lunchButton = UIButton()
    private let dinnerButton = UIButton()
    private let foodCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    private let writeButton = UIButton(type: .custom)
    
    let interval = UIEdgeInsets(top: 19, left: 20, bottom: 10, right: 20)
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setSearchBar()
        setAddTarget()
        setUpCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isTranslucent = false
    }
    //MARK: - SetUI
    override func setConfigure() {
        view.do {
            $0.backgroundColor = UIColor(r: 30, g: 32, b: 33)
        }
        
        searchBar.do {
            $0.backgroundImage = UIImage()
            $0.backgroundColor = UIColor(named: "coolGray4")
            $0.searchTextField.placeholder = "관심있는 집밥을 검색해보세요!"
            $0.makeBorder(width: 1, color: UIColor(r: 102, g: 102, b: 102))
            $0.makeCornerRound(radius: 7)
            $0.delegate = self
        }
        
        //asset이 없어서 기본 이미지로 구현.
        listButton.do {
            $0.setTitle("최신순", for: .normal)
            $0.setTitleColor(UIColor(named: "turquoiseGreen"), for: .normal)
            $0.titleLabel?.font = .captionMedium13
            $0.setImage(UIImage(named: "dropdown"), for: .normal)
            $0.semanticContentAttribute = .forceRightToLeft
        }
        
        scrollView.do {
            $0.backgroundColor = UIColor(r: 30, g: 32, b: 33)
            $0.showsHorizontalScrollIndicator = false
        }
        
        mainButton.do {
            $0.backgroundColor = UIColor(r: 30, g: 32, b: 33)
            $0.setTitle("#전체글", for: .normal)
            $0.setTitleColor(UIColor(r: 204, g: 204, b: 204), for: .normal)
            $0.titleLabel?.font = .captionMedium13
            $0.makeBorder(width: 1.56, color: UIColor(r: 204, g: 204, b: 204))
            $0.makeCornerRound(radius: 17.5)
        }
        
        weekButton.do {
            $0.backgroundColor = UIColor(r: 30, g: 32, b: 33)
            $0.setTitle("#주간_BEST", for: .normal)
            $0.setTitleColor(UIColor(r: 204, g: 204, b: 204), for: .normal)
            $0.titleLabel?.font = .captionMedium13
            $0.makeBorder(width: 1.56, color: UIColor(r: 204, g: 204, b: 204))
            $0.makeCornerRound(radius: 17.5)
        }
        
        breakfastButton.do {
            $0.backgroundColor = UIColor(r: 30, g: 32, b: 33)
            $0.setTitle("#아침", for: .normal)
            $0.setTitleColor(UIColor(r: 204, g: 204, b: 204), for: .normal)
            $0.titleLabel?.font = .captionMedium13
            $0.makeBorder(width: 1.56, color: UIColor(r: 204, g: 204, b: 204))
            $0.makeCornerRound(radius: 17.5)
        }
        
        lunchButton.do {
            $0.backgroundColor = UIColor(r: 30, g: 32, b: 33)
            $0.setTitle("#점심", for: .normal)
            $0.setTitleColor(UIColor(r: 204, g: 204, b: 204), for: .normal)
            $0.titleLabel?.font = .captionMedium13
            $0.makeBorder(width: 1.56, color: UIColor(r: 204, g: 204, b: 204))
            $0.makeCornerRound(radius: 17.5)
        }
        
        dinnerButton.do {
            $0.backgroundColor = UIColor(r: 30, g: 32, b: 33)
            $0.setTitle("#저녁", for: .normal)
            $0.setTitleColor(UIColor(r: 204, g: 204, b: 204), for: .normal)
            $0.titleLabel?.font = .captionMedium13
            $0.makeBorder(width: 1.56, color: UIColor(r: 204, g: 204, b: 204))
            $0.makeCornerRound(radius: 17.5)
        }
        
        foodCollectionView.do {
            $0.backgroundColor = UIColor(r: 30, g: 32, b: 33)
            $0.showsVerticalScrollIndicator = false
        }
        
        writeButton.do {
            $0.setImage(UIImage(named: "icon"), for: .normal)
        }
    }
    
    override func setConstraints() {
        
        view.addSubviews(searchBar, listButton, scrollView, mainButton, weekButton,
                         breakfastButton, lunchButton, dinnerButton, foodCollectionView, writeButton)
        
        searchBar.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(164)
            $0.width.equalTo(351)
            $0.height.equalTo(35)
        }
        
        listButton.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(16)
            $0.leading.equalTo(searchBar.snp.leading)
        }
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(listButton.snp.bottom).offset(11)
            $0.leading.equalToSuperview().inset(20)
            $0.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(31)
        }
        
        mainButton.snp.makeConstraints {
            $0.top.equalTo(scrollView.snp.top)
            $0.bottom.equalTo(scrollView.snp.bottom)
            $0.leading.equalTo(scrollView.snp.leading)
            $0.width.equalTo(68)
        }
        
        weekButton.snp.makeConstraints {
            $0.top.equalTo(scrollView.snp.top)
            $0.bottom.equalTo(scrollView.snp.bottom)
            $0.leading.equalTo(mainButton.snp.trailing).offset(8)
            $0.width.equalTo(95)
        }
        
        breakfastButton.snp.makeConstraints {
            $0.top.equalTo(scrollView.snp.top)
            $0.bottom.equalTo(scrollView.snp.bottom)
            $0.leading.equalTo(weekButton.snp.trailing).offset(8)
            $0.width.equalTo(56)
        }
        
        lunchButton.snp.makeConstraints {
            $0.top.equalTo(scrollView.snp.top)
            $0.bottom.equalTo(scrollView.snp.bottom)
            $0.leading.equalTo(breakfastButton.snp.trailing).offset(8)
            $0.width.equalTo(56)
        }
        
        dinnerButton.snp.makeConstraints {
            $0.top.equalTo(scrollView.snp.top)
            $0.bottom.equalTo(scrollView.snp.bottom)
            $0.leading.equalTo(lunchButton.snp.trailing).offset(8)
            $0.width.equalTo(56)
        }
        
        foodCollectionView.snp.makeConstraints {
            $0.top.equalTo(scrollView.snp.bottom).offset(22)
            $0.leading.trailing.equalToSuperview().inset(25)
            $0.bottom.equalToSuperview()
        }
        
        writeButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(100)
            $0.height.equalTo(51)
            $0.width.equalTo(51)
        }
    }
    
    private func setAddTarget() {
        listButton.addTarget(self, action: #selector(isListButtonTapped), for: .touchUpInside)
        mainButton.addTarget(self, action: #selector(isHashTagButtonTapped), for: .touchUpInside)
        weekButton.addTarget(self, action: #selector(isHashTagButtonTapped), for: .touchUpInside)
        breakfastButton.addTarget(self, action: #selector(isHashTagButtonTapped), for: .touchUpInside)
        lunchButton.addTarget(self, action: #selector(isHashTagButtonTapped), for: .touchUpInside)
        dinnerButton.addTarget(self, action: #selector(isHashTagButtonTapped), for: .touchUpInside)
    }
    
    private func setUpCollectionView() {
        foodCollectionView.dataSource = self
        foodCollectionView.delegate = self
        foodCollectionView.register(FoodTalkCollectionViewCell.self, forCellWithReuseIdentifier: FoodTalkCollectionViewCell.identifier)
        let flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: 161, height: 161)
        foodCollectionView.collectionViewLayout = flowLayout
    }
    
    //MARK: - @objc func
    @objc func isListButtonTapped(_ sender: Any) {
        
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        actionSheet.addAction(UIAlertAction(title: "최신순", style: .default, handler: {(ACTION:UIAlertAction) in self.listButton.setTitle("최신순", for: .normal)}))
        actionSheet.addAction(UIAlertAction(title: "공감순", style: .default, handler: {(ACTION:UIAlertAction) in self.listButton.setTitle("공감순", for: .normal)}))
        actionSheet.addAction(UIAlertAction(title: "조회순", style: .default, handler: {(ACTION:UIAlertAction) in self.listButton.setTitle("조회순", for: .normal)}))
        actionSheet.addAction(UIAlertAction(title: "오래된 순", style: .default, handler: {(ACTION:UIAlertAction) in self.listButton.setTitle("오래된 순", for: .normal)}))
        actionSheet.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    @objc func isHashTagButtonTapped(_ sender: Any) {
        var button = UIButton()
        button = sender as! UIButton
        button.layer.borderColor = UIColor(named: "turquoiseGreen")?.cgColor
        button.setTitleColor(UIColor(named: "turquoiseGreen"), for: .normal)
    }
}

//MARK: - Extension
extension FoodTalkViewController: UISearchBarDelegate {
    
    func setSearchBar(){
        if let textfield = searchBar.value(forKey: "searchField") as? UITextField {
            textfield.backgroundColor = UIColor(named: "coolGray4")
            textfield.attributedPlaceholder = NSAttributedString(string: textfield.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor : UIColor(r: 216, g: 216, b: 216)])
            textfield.textColor = UIColor(r: 216, g: 216, b: 216)
            if let leftView = textfield.leftView as? UIImageView {
                leftView.image = leftView.image?.withRenderingMode(.alwaysTemplate)
                leftView.tintColor = UIColor(r: 216, g: 216, b: 216)
            }
        }
        
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            if let searchText = searchBar.text {
                performSearch(with: searchText)
            }
            searchBar.resignFirstResponder() // 키보드 숨기기
        }
        
        func performSearch(with searchText: String) {
            // 검색 로직 구현하는 부분. 네트워크.
        }
    }
}

extension FoodTalkViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FoodTalkCollectionViewCell", for: indexPath) as? FoodTalkCollectionViewCell else {
                return UICollectionViewCell()
        }
        
        cell.backgroundColor = UIColor(r: 42, g: 42, b: 44)
        cell.foodName.text = "샐러드"
        
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let nextVC = FoodPostViewController()
        navigationController?.pushViewController(nextVC, animated: true)
    
    }
}

extension FoodTalkViewController: UICollectionViewDelegateFlowLayout{
  
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let spacing: CGFloat = 20
            let width = (collectionView.bounds.width - 8 - 8 - spacing) / 2 // 총 가로길이 - leading - trailing - 간격
            let height = (collectionView.bounds.height - spacing * 2) / 3 // 총 세로길이 - top - bottom - 간격
            return CGSize(width: width, height: height)
    }
    
}

