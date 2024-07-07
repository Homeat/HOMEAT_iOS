//
//  InfoViewController.swift
//  HOMEAT
//
//  Created by 김민솔 on 5/19/24.
//

import UIKit
import Alamofire

enum InfoSortOrder {
    case latest
    case oldest
    case view
    case love
    case none
}
class InfoTalkViewController: BaseViewController {
    //MARK: - Property
    private let searchBar = UISearchBar()
    private let tableView = UITableView()
    private let listButton = UIButton()
    private let floatingButton = UIButton()
    var lastest: [InfoTalk] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    var oldest: [InfoTalk] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    var viewOrder: [InfoTalk] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    var loveOrder: [InfoTalk] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    var currentSortOrder: InfoSortOrder = .none
    var lastInfoTalkId = Int.max
    var oldestInfoTalkId = Int.max
    var viewCount = Int.max
    var loveCount = Int.max
    var search : String?
    var isLoading =  false
    var hasNextPage = true
    let pageSize = 6 // 한 번에 가져올 아이템 수
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
        setSearchBar()
        setAddTarget()
        updateTableView()
        currentSortOrder = .latest
        NotificationCenter.default.addObserver(self, selector: #selector(dataChanged), name: NSNotification.Name("InfoTalkDeleteChanged"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(dataChanged), name: NSNotification.Name("InfoTalkDataChanged"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isTranslucent = false
        switch currentSortOrder {
        case .latest:
            updateTableView()
        case .oldest:
            requestOldestOrder()
        case .view:
            requestViewOrder()
        case .love:
            requestLoveOrder()
        case .none:
            break
        }
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
            $0.setImage(UIImage(named: "TalkWriteButton"), for: .normal)
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
    
    private func resetData() {
        lastInfoTalkId = Int.max
        oldestInfoTalkId = 0
        isLoading = false
        lastest.removeAll()
        oldest.removeAll()
        viewOrder.removeAll()
        loveOrder.removeAll()
        tableView.reloadData()
    }
    //MARK: - 서버 func
    // 최신 순
    private func updateTableView() {
        guard !isLoading else { return }
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
    func requestOldestOrder() {
        guard !isLoading && hasNextPage else { return }
        isLoading = true
        let bodyDTO = OldestInfoRequestBodyDTO(search: search ?? "", oldestInfoTalkId: oldestInfoTalkId)
        NetworkService.shared.infoTalkService.oldestOrder(bodyDTO: bodyDTO) { [weak self] response in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch response {
                case .success(let data):
                    print("성공 데이터가 반환되었습니다.")
                    if data.data.isEmpty {
                        print("오래된 순 데이터가 없습니다.")
                        self.hasNextPage = false
                    } else {
                        let newData = data.data.filter { newItem in
                            !self.oldest.contains(where: { $0.infoTalkId == newItem.infoTalkId })
                        }
                        self.oldest.append(contentsOf: newData)
                        if let lastInfoTalk = data.data.last {
                            self.oldestInfoTalkId = lastInfoTalk.infoTalkId - 1
                        }
                    }
                        self.hasNextPage = data.hasNext
                        self.tableView.reloadData()
                        self.tableView.performBatchUpdates(nil, completion: { _ in
                            self.tableView.setNeedsLayout()
                            self.tableView.layoutIfNeeded()
                        })
                        self.isLoading = false
                                                
                    
                default:
                    print("데이터 저장 실패")
                    self.isLoading = false
                    self.hasNextPage = false
                }
            }
        }
    }
    
    func requestViewOrder() {
        guard !isLoading && hasNextPage else { return }
                isLoading = true
        let bodyDTO = ViewInfoRequestBodyDTO(search: search ?? "", id: lastInfoTalkId, view: viewCount)
        NetworkService.shared.infoTalkService.viewOrder(bodyDTO: bodyDTO) { [weak self] response in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.isLoading = false
                switch response {
                case .success(let data):
                    if data.data.isEmpty {
                        print("조회순 데이터 요청")
                        self.hasNextPage = false
                    } else {
                        let newData = data.data.filter { newItem in
                            !self.viewOrder.contains(where: { $0.infoTalkId == newItem.infoTalkId })
                                                }
                        print("Filtered new data: \(newData.count) items")
                        self.viewOrder.append(contentsOf: newData)
                        // viewCount와 lastFoodTalkId 업데이트
                        if let lastInfoTalk = data.data.last {
                            self.lastInfoTalkId = lastInfoTalk.infoTalkId
                            self.viewCount = lastInfoTalk.view ?? 0
                        }
                        self.hasNextPage = data.hasNext
                        
                    }
                    self.isLoading = false
                    self.tableView.reloadData()
                    self.tableView.performBatchUpdates(nil, completion: { _ in
                        self.tableView.setNeedsLayout()
                        self.tableView.layoutIfNeeded()
                    })
                    
                default:
                    print("뷰 실패")
                    self.hasNextPage = false
                }
            }
            
        }
    }
    func requestLoveOrder() {
        guard !isLoading && hasNextPage else { return }
                isLoading = true
                print("공감순 데이터 요청 시작")
//        let bodyDTO =
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y + scrollView.frame.size.height > scrollView.contentSize.height - 100 {
            switch currentSortOrder {
            case .latest:
                if hasNextPage && !isLoading { updateTableView() }
            case .oldest:
                if hasNextPage && !isLoading { requestOldestOrder() }
            case .view:
                if hasNextPage && !isLoading { requestViewOrder() }
            case .love:
                if hasNextPage && !isLoading { requestLoveOrder() }
            case .none:
                break
            }
        }
    }
    
    //MARK: - @objc func
    @objc private func dataChanged() {
        resetData()
        updateTableView()
    }
    @objc func isListButtonTapped(_ sender: Any) {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "최신순", style: .default, handler: {(ACTION:UIAlertAction) in
            self.listButton.setTitle("최신순", for: .normal)
            self.lastInfoTalkId = Int.max
            self.oldestInfoTalkId = 0
            self.viewCount = 1000000
            self.loveCount = 1000000
            self.lastest.removeAll()
            self.oldest.removeAll()
            self.viewOrder.removeAll()
            self.loveOrder.removeAll()
            self.currentSortOrder = .latest
            self.hasNextPage = true
            self.isLoading = false
            self.tableView.reloadData()
            self.updateTableView()
        }))
        actionSheet.addAction(UIAlertAction(title: "공감순", style: .default, handler: {(ACTION:UIAlertAction) in
            self.listButton.setTitle("공감순", for: .normal)
            self.lastInfoTalkId = Int.max
            self.oldestInfoTalkId = 0
            self.viewCount = 1000000
            self.loveCount = 1000000
            self.lastest.removeAll()
            self.oldest.removeAll()
            self.viewOrder.removeAll()
            self.loveOrder.removeAll()
            self.currentSortOrder = .love
            self.hasNextPage = true
            self.isLoading = false
            self.tableView.reloadData()
            self.updateTableView()
        }))
        actionSheet.addAction(UIAlertAction(title: "조회순", style: .default, handler: {(ACTION:UIAlertAction) in
            self.listButton.setTitle("조회순", for: .normal)
            self.lastInfoTalkId = Int.max
            self.oldestInfoTalkId = 0
            self.viewCount = 1000000
            self.loveCount = 1000000
            self.lastest.removeAll()
            self.oldest.removeAll()
            self.viewOrder.removeAll()
            self.loveOrder.removeAll()
            self.currentSortOrder = .view
            self.hasNextPage = true
            self.isLoading = false
            self.tableView.reloadData()
            self.updateTableView()
        }))
        actionSheet.addAction(UIAlertAction(title: "오래된 순", style: .default, handler: {(ACTION:UIAlertAction) in
            self.listButton.setTitle("오래된 순", for: .normal)
            self.lastInfoTalkId = Int.max
            self.oldestInfoTalkId = 0
            self.viewCount = 1000000
            self.loveCount = 1000000
            self.lastest.removeAll()
            self.oldest.removeAll()
            self.viewOrder.removeAll()
            self.loveOrder.removeAll()
            self.currentSortOrder = .oldest
            self.hasNextPage = true
            self.isLoading = false
            self.tableView.reloadData()
            self.requestViewOrder()
        }))
        actionSheet.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    @objc func isWriteButtonTapped(_ sender: Any) {
        let nextVC = InfoWriteViewController()
        nextVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(nextVC, animated: true)
    }
    @objc func navigateToPostViewController(with postId: Int) {
        
        let postVC = InfoPostViewController(infoTalkId: postId)
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
        searchBar.delegate = self
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text {
            search = searchText
            performSearch(with: searchText)
        }
        searchBar.resignFirstResponder()
    }
    func performSearch(with searchText: String) {
        switch currentSortOrder {
            case .latest:
                resetData()
                updateTableView()
            case .oldest:
                resetData()
                requestOldestOrder()
            case .view:
                resetData()
                requestViewOrder()
            case .love:
                resetData()
                requestLoveOrder()
            case .none:
                break
        }
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
                    search = nil
                    updateTableView()
                    
                    switch currentSortOrder {
                    case .latest:
                        updateTableView()
                    case .oldest:
                        requestOldestOrder()
                    case .view:
                        requestViewOrder()
                    case .love:
                        requestLoveOrder()
                    case .none:
                        break
                    }
                }
    }
    
}

extension InfoTalkViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch currentSortOrder {
        case .latest:
            return lastest.count
        case .oldest:
            return oldest.count
        case .view:
            return viewOrder.count
        case .love:
            return loveOrder.count
        case .none:
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: InfoTalkTableViewCell.identifier, for: indexPath) as? InfoTalkTableViewCell else {
            return UITableViewCell()
        }
        let infoTalk: InfoTalk
        switch currentSortOrder {
        case .latest:
            infoTalk = lastest[indexPath.row]
        case .oldest:
            infoTalk = oldest[indexPath.row]
        case .view:
            infoTalk = viewOrder[indexPath.row]
        case .love:
            infoTalk = loveOrder[indexPath.row]
        case .none:
            return UITableViewCell()
        }
        
        cell.selectionStyle = .none
        cell.configure(with: infoTalk)
        return cell
    }
}

extension InfoTalkViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("cell click")
        let infoTalk: InfoTalk
        switch currentSortOrder {
        case .latest:
            infoTalk = lastest[indexPath.row]
        case .oldest:
            infoTalk = oldest[indexPath.row]
        case .view:
            infoTalk = viewOrder[indexPath.row]
        case .love:
            infoTalk = loveOrder[indexPath.row]
        case .none:
            return
        }
        tableView.deselectRow(at: indexPath, animated: true)
        navigateToPostViewController(with: infoTalk.infoTalkId)
        
    }
}
