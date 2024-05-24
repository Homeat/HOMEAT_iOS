//
//  InfoViewController.swift
//  HOMEAT
//
//  Created by 김민솔 on 5/19/24.
//

import UIKit

class InfoTalkViewController: BaseViewController {
    
    //MARK: - Property
    private let searchBar = UISearchBar()
    private let tableView = UITableView()
    private let listButton = UIButton()
    private let floatingButton = UIButton()
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
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
        
        tableView.do {
            $0.dataSource = self
            $0.delegate = self
            $0.allowsSelection = true
            $0.showsVerticalScrollIndicator = true
            $0.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            $0.register(InfoTalkTableViewCell.self, forCellReuseIdentifier: InfoTalkTableViewCell.identifier)
        }
        
        //asset이 없어서 기본 이미지로 구현.
        listButton.do {
            $0.setTitle("최신순", for: .normal)
            $0.setTitleColor(UIColor(named: "turquoiseGreen"), for: .normal)
            $0.titleLabel?.font = .captionMedium13
            $0.setImage(UIImage(named: "dropdown"), for: .normal)
            $0.semanticContentAttribute = .forceRightToLeft
        }
        
        floatingButton.do {
            $0.setImage(UIImage(named: "talkWriteButton"), for: .normal)
            $0.isHidden = false
        }
    }
    
    override func setConstraints() {
        view.addSubviews(searchBar,listButton,tableView,floatingButton)
        view.bringSubviewToFront(floatingButton)
        
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
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(listButton.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview()
        }
        
        floatingButton.snp.makeConstraints {
            $0.width.equalTo(51)
            $0.height.equalTo(51)
            $0.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(12)
        }
    }
    
    private func setAddTarget() {
        listButton.addTarget(self, action: #selector(isListButtonTapped), for: .touchUpInside)
        
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
}
//MARK: - Extension
extension InfoTalkViewController: UISearchBarDelegate {
    
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

extension InfoTalkViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: InfoTalkTableViewCell.identifier, for: indexPath) as? InfoTalkTableViewCell else {
            return UITableViewCell()
        }
        cell.titleLabel.text = "선재야선재야"
        cell.dateLabel.text = "11월 5일 08:00"
        cell.contentLabel.text = "꽁꽁얼어붙은 한강위에 고양이가 걸어다닌다 한강위에 고양이가 걸어다닌다 야옹야옹한강위에 고양이가 걸어다닌다 야옹야옹한강위에"
        cell.heartLabel.text = "30"
        cell.chatLabel.text = "5"
        cell.selectionStyle = .none
        cell.postImageView.image = UIImage(named: "woosuck")
        cell.heartImage.image = UIImage(named: "isSmallHeartSelected")
        cell.chatImage.image = UIImage(named: "isReply")
        
        return cell
    }
}

extension InfoTalkViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
