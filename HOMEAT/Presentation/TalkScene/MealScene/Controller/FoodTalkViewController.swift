//  FoodTalkController.swift
//  HOMEAT
//
//  Created by 이지우 on 4/4/24.
//

import UIKit
import Then
import SnapKit

class FoodTalkViewController: BaseViewController {
    var selectedButton: UIButton?
    var lastest: [FoodTalk] = [] {
        didSet {
            foodCollectionView.reloadData()
            updateContentSize()
        }
    }
    var lastFoodTalkId = Int.max
    var foodTalkId: Int?
    var search: String?
    var selectedTag: String?
    var isLoading = false
    
    //MARK: - Property
    private let searchBar = UISearchBar()
    private let listButton = UIButton()
    private let scrollView = UIScrollView()
    private let mainButton = UIButton()
    private let weekButton = UIButton()
    private let breakfastButton = UIButton()
    private let lunchButton = UIButton()
    private let dinnerButton = UIButton()
    private let foodCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 161, height: 161)
        layout.minimumLineSpacing = 20
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()
    private let writeButton = UIButton(type: .custom)
    let interval = UIEdgeInsets(top: 19, left: 20, bottom: 10, right: 20)
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setSearchBar()
        setAddTarget()
        setConfigure()
        setConstraints()
        setUpCollectionView()
        NotificationCenter.default.addObserver(self, selector: #selector(dataChanged), name: NSNotification.Name("FoodTalkDataChanged"), object: nil)
        request()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isTranslucent = false
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        foodCollectionView.collectionViewLayout.invalidateLayout()
        updateContentSize()
    }
    
    @objc private func dataChanged() {
        lastFoodTalkId = Int.max
        lastest.removeAll()
        request()
    }
    
    private func updateContentSize() {
        foodCollectionView.contentSize = CGSize(width: foodCollectionView.bounds.width, height: foodCollectionView.collectionViewLayout.collectionViewContentSize.height)
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
            $0.setTitleColor(.turquoiseGreen, for: .normal)
            $0.titleLabel?.font = .captionMedium13
            $0.isSelected = true
            $0.makeBorder(width: 1.56, color: .turquoiseGreen)
            $0.makeCornerRound(radius: 17)
            selectedButton = mainButton
        }
        
        weekButton.do {
            $0.backgroundColor = UIColor(r: 30, g: 32, b: 33)
            $0.setTitle("#주간_BEST", for: .normal)
            $0.setTitleColor(UIColor(r: 204, g: 204, b: 204), for: .normal)
            $0.titleLabel?.font = .captionMedium13
            $0.makeBorder(width: 1.56, color: UIColor(r: 204, g: 204, b: 204))
            $0.makeCornerRound(radius: 17)
        }
        
        breakfastButton.do {
            $0.backgroundColor = UIColor(r: 30, g: 32, b: 33)
            $0.setTitle("#아침", for: .normal)
            $0.setTitleColor(UIColor(r: 204, g: 204, b: 204), for: .normal)
            $0.titleLabel?.font = .captionMedium13
            $0.makeBorder(width: 1.56, color: UIColor(r: 204, g: 204, b: 204))
            $0.makeCornerRound(radius: 17)
        }
        
        lunchButton.do {
            $0.backgroundColor = UIColor(r: 30, g: 32, b: 33)
            $0.setTitle("#점심", for: .normal)
            $0.setTitleColor(UIColor(r: 204, g: 204, b: 204), for: .normal)
            $0.titleLabel?.font = .captionMedium13
            $0.makeBorder(width: 1.56, color: UIColor(r: 204, g: 204, b: 204))
            $0.makeCornerRound(radius: 17)
        }
        
        dinnerButton.do {
            $0.backgroundColor = UIColor(r: 30, g: 32, b: 33)
            $0.setTitle("#저녁", for: .normal)
            $0.setTitleColor(UIColor(r: 204, g: 204, b: 204), for: .normal)
            $0.titleLabel?.font = .captionMedium13
            $0.makeBorder(width: 1.56, color: UIColor(r: 204, g: 204, b: 204))
            $0.makeCornerRound(radius: 17)
        }
        
        foodCollectionView.do {
            $0.backgroundColor = UIColor(r: 30, g: 32, b: 33)
            $0.showsVerticalScrollIndicator = false
            $0.alwaysBounceVertical = true
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
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-16)
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
        writeButton.addTarget(self, action: #selector(isWriteButtonTapped), for: .touchUpInside)
    }
    
    private func setUpCollectionView() {
        foodCollectionView.dataSource = self
        foodCollectionView.delegate = self
        foodCollectionView.prefetchDataSource = self
        foodCollectionView.register(FoodTalkCollectionViewCell.self, forCellWithReuseIdentifier: FoodTalkCollectionViewCell.identifier)
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
    
    @objc func isHashTagButtonTapped(_ sender: UIButton) {
        if let selectedButton = selectedButton {
            selectedButton.isSelected = false
            selectedButton.layer.borderColor = UIColor(named: "warmgray")?.cgColor
            selectedButton.setTitleColor(.warmgray, for: .normal)
        }
        sender.isSelected = true
        sender.layer.borderColor = UIColor(named: "turquoiseGreen")?.cgColor
        sender.setTitleColor(.turquoiseGreen, for: .normal)
        selectedButton = sender

        // 전체글 버튼을 클릭했을 때 selectedTag를 nil로 설정
        if sender == mainButton {
            selectedTag = nil
        } else if let tag = sender.titleLabel?.text?.replacingOccurrences(of: "#", with: "") {
            selectedTag = tag
        }

        lastFoodTalkId = Int.max // Reset lastFoodTalkId for new tag
        lastest.removeAll() // Clear current data
        foodCollectionView.reloadData()
        request()
    }
    
    @objc func isWriteButtonTapped(_ sender: Any) {
        let nextVC = RecipeWriteViewController()
        nextVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func request() {
        guard !isLoading else { return }
        isLoading = true
        
        let bodyDTO = LatestOrderRequestBodyDTO(search: search ?? "", tag: selectedTag ?? "", lastFoodTalkId: lastFoodTalkId)
        NetworkService.shared.foodTalkService.latestOrder(bodyDTO: bodyDTO) { [weak self] response in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch response {
                case .success(let data):
                    print("성공: 데이터가 반환되었습니다")
                    self.lastest.append(contentsOf: data.data)
                    self.lastFoodTalkId = self.lastest.last?.foodTalkId ?? Int.max
                    self.isLoading = false
                    self.foodCollectionView.reloadData()
                    self.foodCollectionView.layoutIfNeeded()
                default:
                    print("데이터 저장 실패")
                    self.isLoading = false
                }
            }
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y + scrollView.frame.size.height > scrollView.contentSize.height - 100 {
            request()
            print("Reached the bottom of the collection view")
        }
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

//MARK: - Extension
extension FoodTalkViewController: UISearchBarDelegate {
    
    func setSearchBar() {
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
        searchBar.resignFirstResponder() // 키보드 숨기기
    }
    
    func performSearch(with searchText: String) {
        lastFoodTalkId = Int.max
        lastest.removeAll()
        foodCollectionView.reloadData()
        request()
    }
}

extension FoodTalkViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDataSourcePrefetching {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return lastest.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FoodTalkCollectionViewCell", for: indexPath) as? FoodTalkCollectionViewCell else {
            return UICollectionViewCell()
        }
        let foodTalk = lastest[indexPath.item]
        cell.configure(with: foodTalk)
        cell.backgroundColor = UIColor(r: 42, g: 42, b: 44)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let foodTalk = lastest[indexPath.item]
        let nextVC = FoodPostViewController(foodTalkId: foodTalk.foodTalkId)
        navigationController?.pushViewController(nextVC, animated: true)
    }

    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        guard let maxRow = indexPaths.map({ $0.row }).max(), maxRow > lastest.count - 3 else {
            return
        }
        request()
    }
}

extension FoodTalkViewController: UICollectionViewDelegateFlowLayout {
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
