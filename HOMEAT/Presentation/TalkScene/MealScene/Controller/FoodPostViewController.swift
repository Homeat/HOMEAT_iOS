//
//  FoodPostViewController.swift
//  HOMEAT
//
//  Created by 이지우 on 5/5/24.
//

import UIKit
import Then
import SnapKit

class FoodPostViewController: BaseViewController, HeaderViewDelegate, UITextFieldDelegate {
    
    //MARK: - Property
    private let tableView = UITableView(frame: CGRect.zero, style: .grouped)
    var postContent = PostContentView()
    private let replyTextView = UIView()
    let replyTextField = UITextField()
    private let heartButton = UIButton()
    private let sendButton = UIButton()
    var commentViewBottomConstraint: NSLayoutConstraint?
    var foodTalkId: Int?
    var foodTalkRecipes: [FoodTalkRecipe] = []
    var comments: [FoodTalkComment] = []

    //MARK: - Initializer
    init(foodTalkId: Int) {
        self.foodTalkId = foodTalkId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        setTableView()
        setTabbar()
        setupKeyboardEvent()
        PostRequest()
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 91, right: 0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardUp), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDown), name: UIResponder.keyboardWillHideNotification, object: nil)
        tabBarController?.tabBar.isHidden = true
        tabBarController?.tabBar.isTranslucent = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    //MARK: - SetUI
    override func setConfigure() {
        
        view.do {
            $0.backgroundColor = UIColor(named: "homeBackgroundColor")
        }
        
        tableView.do {
            $0.backgroundColor = UIColor(named: "homeBackgroundColor")
        }
        
        replyTextView.do {
            $0.backgroundColor = .turquoiseDarkGray
            $0.layer.cornerRadius = 10
        }
        
        heartButton.do {
            $0.setImage(UIImage(named: "isHeartUnselected"), for: .normal)
            $0.contentMode = .scaleAspectFit
        }
        
        replyTextField.do {
            $0.placeholder = "댓글을 남겨보세요."
            $0.font = .bodyMedium16
            $0.textColor = .white
            $0.layer.cornerRadius = 20
            $0.backgroundColor = .turquoiseDarkGray
            $0.attributedPlaceholder = NSAttributedString(string: "댓글을 남겨보세요.", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "font5") ?? UIColor.gray])
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: $0.frame.height))
            $0.leftViewMode = .always
            $0.layer.borderColor = UIColor.init(named: "font7")?.cgColor
            $0.layer.borderWidth = 1.0
        }
        
        sendButton.do {
            $0.setImage(UIImage(named: "sendIcon"), for: .normal)
            $0.contentMode = .scaleAspectFit
            $0.addTarget(self, action: #selector(sendButtonTapped), for: .touchUpInside)
        }
    }
    
    override func setConstraints() {
        
        commentViewBottomConstraint = replyTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        view.addSubviews(tableView, replyTextView)
        
        tableView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        replyTextView.snp.makeConstraints {
            $0.bottom.equalTo(view.snp.bottom)
            $0.leading.equalTo(view.snp.leading)
            $0.trailing.equalTo(view.snp.trailing)
            $0.height.equalTo(91)
        }
        
        replyTextView.addSubviews(heartButton, replyTextField, sendButton)
        
        heartButton.snp.makeConstraints {
            $0.leading.equalTo(replyTextView.snp.leading).offset(20)
            $0.centerY.equalTo(replyTextField.snp.centerY)
            $0.height.equalTo(22.6)
            $0.width.equalTo(22.6)
        }
        
        replyTextField.snp.makeConstraints {
            $0.leading.equalTo(heartButton.snp.trailing).offset(10)
            $0.top.equalTo(replyTextView.snp.top).offset(24)
            $0.bottom.equalTo(replyTextView.snp.bottom).inset(24)
            $0.trailing.equalTo(replyTextView.snp.trailing).inset(20)
        }
        
        sendButton.snp.makeConstraints {
            $0.centerY.equalTo(replyTextField.snp.centerY)
            $0.trailing.equalTo(replyTextField.snp.trailing).inset(8)
        }
    }
    
    private func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.register(FoodTalkReplyCell.self, forCellReuseIdentifier: "FoodTalkReplyCell")
        tableView.register(PostContentView.self, forHeaderFooterViewReuseIdentifier: "PostContentView")
        tableView.separatorStyle = .none
        tableView.reloadData()
        tableView.layoutIfNeeded()
    }
    
    private func setNavigationBar() {
        self.navigationItem.title = "집밥토크"
        let backbutton = UIBarButtonItem()
        backbutton.tintColor = .white
        navigationController?.navigationBar.topItem?.backBarButtonItem = backbutton
        navigationController?.navigationBar.barTintColor = UIColor(named: "homeBackgroundColor")
    }
    
    private func setTabbar() {
        tabBarController?.tabBar.isHidden = true
        tabBarController?.tabBar.isTranslucent = true
    }
    
    func setupKeyboardEvent() {
        replyTextField.delegate = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    //MARK: - Method
    func recipeViewButtonTapped() {
        let nextVC = RecipeViewController(foodTalkRecipes: foodTalkRecipes)
        nextVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func declareViewButtonTapped() {
        let nextVC = DeclareViewController()
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func PostRequest() {
        guard let foodTalkId = foodTalkId else { return }
        let bodyDTO = CheckOneRequestBodyDTO(id: foodTalkId)
        NetworkService.shared.foodTalkService.checkOne(bodyDTO: bodyDTO) { [weak self] response in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch response {
                case .success(let data):
                    print("성공: 데이터가 반환되었습니다")
                    let userName = data.data.postNickName
                    let titleLabel = data.data.name
                    // 날짜 형식 변환
                    let dateString = data.data.createdAt
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSSS"
                    
                    var displayDate = ""
                    if let date = dateFormatter.date(from: dateString) {
                        let displayFormatter = DateFormatter()
                        displayFormatter.dateFormat = "MM월 dd일 HH:mm"
                        displayDate = displayFormatter.string(from: date)
                        print("변환된 날짜: \(displayDate)")
                    } else {
                        print("날짜 형식 변환 실패")
                    }
                    let tag = data.data.tag
                    let memo = data.data.memo
                    let love = String(data.data.love)
                    let comment = String(data.data.commentNumber)
                    let foodPictureImages = data.data.foodPictureImages
                    let receivedRecipes = data.data.foodTalkRecipes
                    self.comments = data.data.foodTalkComments
                    print("받은 레시피 수: \(receivedRecipes.count)")
                    for recipe in receivedRecipes {
                        print("레시피: \(recipe)")
                    }
                    self.foodTalkRecipes = receivedRecipes
                    if let headerView = self.tableView.headerView(forSection: 0) as? PostContentView {
                        headerView.updateContent(userName: userName, date: displayDate, title: titleLabel, memo: memo, tag: tag, love: love, comment: comment, foodPictureImages: foodPictureImages, foodTalkRecipes: self.foodTalkRecipes)
                    }
                    self.tableView.reloadData()
                default:
                    print("데이터 저장 실패")
                }
            }
            
        }
    }

    // MARK: -- objc
    @objc func sendButtonTapped() {
        // 작성한 댓글을 서버로 전달
        guard let foodTalkId = self.foodTalkId,
              let content = replyTextField.text, !content.isEmpty else {
            print("댓글 내용이 없습니다.")
            return
        }
        
        let bodyDTO = CommentWriteRequestBodyDTO(id: foodTalkId, content: content)
        NetworkService.shared.foodTalkService.commentWrite(bodyDTO: bodyDTO) { [weak self] response in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch response {
                case .success:
                    print("성공: 댓글이 저장되었습니다")
                    self.replyTextField.text = ""
                    self.dismissKeyboard()
                    self.PostRequest()
                    self.scrollToBottom()
                default:
                    print("댓글 저장 실패")
                }
            }
        }
    }
    
    private func scrollToBottom() {
        let lastRowIndex = self.comments.count - 1
        if lastRowIndex > 0 {
            let indexPath = IndexPath(row: lastRowIndex, section: 0)
            self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func keyboardUp(notification: NSNotification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            
            UIView.animate(withDuration: 0.3) {
                self.view.transform = CGAffineTransform(translationX: 0, y: -keyboardHeight)
                // 키보드가 나타날 때 테이블 뷰의 하단 여유 공간을 키보드 높이로 설정
                self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight + 91, right: 0)
            }
        }
    }

    @objc func keyboardDown() {
        UIView.animate(withDuration: 0.3) {
            self.view.transform = .identity
            // 키보드가 사라질 때 테이블 뷰의 하단 여유 공간을 원래대로 설정
            self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 91, right: 0)
        }
    }
}

//MARK: - Extension
extension FoodPostViewController: UITableViewDelegate, UITableViewDataSource, FoodTalkReplyCellDelgate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count // 댓글의 개수를 반환
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FoodTalkReplyCell") as! FoodTalkReplyCell
        cell.backgroundColor = UIColor(named: "homeBackgroundColor")
        cell.delegate = self
        
        let comment = comments[indexPath.row]
        cell.updateContent(comment: comment)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 95
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "PostContentView") as! PostContentView
        view.delegate = self
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 520
    }
    
    func replyDeclareButtonTapped(_ cell: FoodTalkReplyCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let nextVC = CommentDeclareViewController()
        navigationController?.pushViewController(nextVC, animated: true)
    }
}
