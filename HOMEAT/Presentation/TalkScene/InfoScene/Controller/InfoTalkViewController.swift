//
//  InfoViewController.swift
//  HOMEAT
//
//  Created by 김민솔 on 5/19/24.
//

import UIKit
import Alamofire

class InfoTalkViewController: BaseViewController {
    //MARK: - Property
    private let searchBar = UISearchBar()
    private let tableView = UITableView()
    private let listButton = UIButton()
    private let floatingButton = UIButton()
    var lastest: [InfoTalk] = []
    var lastInfoTalkId = Int.max
    var search : String?
    var isLoading =  false
    let pageSize = 6 // 한 번에 가져올 아이템 수
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
        setSearchBar()
        setAddTarget()
        updateTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isTranslucent = false
    }
    //MARK: - SetUI
    override func setConfigure() {
        view.do {
            $0.backgroundColor = UIColor(r: 30, g: 32, b: 33)
        }
        
        searchBar.do {
            $0.backgroundImage = UIImage()
            $0.backgroundColor = UIColor(named: "coolGray4")
            $0.searchTextField.placeholder = "관심있는 정보를 검색해보세요!"
            $0.makeBorder(width: 1, color: UIColor(r: 102, g: 102, b: 102))
            $0.makeCornerRound(radius: 7)
            $0.delegate = self
        }
        
        tableView.do {
            $0.dataSource = self
            $0.delegate = self
            $0.allowsSelection = true
            $0.backgroundColor = UIColor(r: 30, g: 32, b: 33)
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
        floatingButton.addTarget(self, action: #selector(isWriteButtonTapped), for: .touchUpInside)
    }
    //MARK: - 서버 func
    private func updateTableView() {
        isLoading = true
        let request = LatestInfoRequestBodyDTO(search: search ?? "", lastInfoTalkId: lastInfoTalkId)
        NetworkService.shared.infoTalkService.latestInfo(queryDTO: request) { [weak self] response in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch response {
                case .success(let data):
                    print("성공: 데이터가 반환되었습니다")
                    self.lastest.append(contentsOf: data.data)
                    self.lastInfoTalkId = self.lastest.last?.infoTalkId ?? Int.max
                    self.isLoading = false
                    //테이블 뷰 reload
                    self.tableView.reloadData()
                default:
                    print("데이터 저장 실패")
                    self.isLoading = false
                }
            }
        }
        
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
    
    @objc func isWriteButtonTapped(_ sender: Any) {
        let nextVC = InfoWriteViewController()
        nextVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(nextVC, animated: true)
    }
    @objc func navigateToPostViewController(with postId: Int) {
        
        let postVC = InfoPostViewController()
        postVC.postId = postId
        tabBarController?.tabBar.isHidden = true
        navigationController?.pushViewController(postVC, animated: true)
        print("present click")
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
                search = searchText
                performSearch(with: searchText)
            }
            searchBar.resignFirstResponder()
        }
        func performSearch(with searchText: String) {
            lastInfoTalkId = Int.max
            lastest.removeAll()
            tableView.reloadData()
            updateTableView()
        }
    }
}

extension InfoTalkViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        lastest.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: InfoTalkTableViewCell.identifier, for: indexPath) as? InfoTalkTableViewCell else {
            return UITableViewCell()
        }
        let post = lastest[indexPath.row]
        cell.selectionStyle = .none
        cell.configure(with: post)
        return cell
    }
}

extension InfoTalkViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("cell click")
        let selectedPost = lastest[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
        navigateToPostViewController(with: selectedPost.infoTalkId)
        print(selectedPost.infoTalkId)

    }
}
