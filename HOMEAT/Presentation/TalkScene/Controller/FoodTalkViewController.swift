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
    //private let collectionView = UICollectionView()
    private let writeButton = UIButton()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setSearchBar()
        setAddTarget()
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
            $0.setImage(UIImage(systemName: "chevron.down"), for: .normal)
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
    }
    
    override func setConstraints() {
        
        view.addSubviews(searchBar, listButton, scrollView, mainButton, weekButton,
                         breakfastButton, lunchButton, dinnerButton)
        
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
    }
    
    private func setAddTarget() {
        listButton.addTarget(self, action: #selector(isListButtonTapped), for: .touchUpInside)
        mainButton.addTarget(self, action: #selector(isHashTagButtonTapped), for: .touchUpInside)
        weekButton.addTarget(self, action: #selector(isHashTagButtonTapped), for: .touchUpInside)
        breakfastButton.addTarget(self, action: #selector(isHashTagButtonTapped), for: .touchUpInside)
        lunchButton.addTarget(self, action: #selector(isHashTagButtonTapped), for: .touchUpInside)
        dinnerButton.addTarget(self, action: #selector(isHashTagButtonTapped), for: .touchUpInside)
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
            //searchBar 백그라운드 컬러
            textfield.backgroundColor = UIColor(named: "coolGray4")
            //플레이스홀더 글씨 색 정하기
            textfield.attributedPlaceholder = NSAttributedString(string: textfield.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor : UIColor(r: 216, g: 216, b: 216)])
            //searchBar 텍스트입력시 색 정하기
            textfield.textColor = UIColor(r: 216, g: 216, b: 216)
            //왼쪽 아이콘 이미지넣기
            if let leftView = textfield.leftView as? UIImageView {
                leftView.image = leftView.image?.withRenderingMode(.alwaysTemplate)
                //이미지 틴트컬러 정하기
                leftView.tintColor = UIColor(r: 216, g: 216, b: 216)
            }
        }
        
        // UISearchBarDelegate 메서드 구현.
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            
            // 검색 버튼을 눌렀을 때 호출되는 메서드.
            if let searchText = searchBar.text {
                // 검색어를 사용하여 검색을 수행.
                performSearch(with: searchText)
            }
            searchBar.resignFirstResponder() // 키보드 숨기기
        }
        
        func performSearch(with searchText: String) {
            // 검색 로직 구현하는 부분. 네트워크.
            print("검색어: \(searchText)")
        }
    }
}
