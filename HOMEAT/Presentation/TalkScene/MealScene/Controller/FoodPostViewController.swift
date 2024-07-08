//
//  FoodPostViewController.swift
//  HOMEAT
//
//  Created by 이지우 on 5/5/24.
//

import UIKit
import Then
import SnapKit
import Kingfisher

class FoodPostViewController: BaseViewController, HeaderViewDelegate, UITextFieldDelegate {
    var commentViewBottomConstraint: NSLayoutConstraint?
    var foodTalkId: Int?
    var commentId: Int?
    var postUserName: String?
    var commentNickname: String?
    var titleLabel = ""
    var foodTalkRecipes: [FoodTalkRecipe] = []
    var comments: [FoodTalkComment] = []
    var recomments : [FoodTalkReply] = []
    var currentReplyContext: (isComment: Bool, id: Int)?
    var currentItsMe : String?
    //MARK: - Property
    private let tableView = UITableView(frame: CGRect.zero, style: .grouped)
    var postContent = PostContentView()
    private let replyTextView = UIView()
    let replyTextField = UITextField()
    private let heartButton = UIButton()
    private let sendButton = UIButton()
    

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
        setHeartButton()
        setTabbar()
        setupKeyboardEvent()
        PostRequest()
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 91, right: 0)
        self.currentItsMe = UserDefaults.standard.string(forKey: "userNickname")
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
            $0.isSelected = false
            $0.addTarget(self, action: #selector(heartButtonTapped), for: .touchUpInside)
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
        let headerView = PostContentView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 520))
        headerView.delegate = self
        tableView.tableHeaderView = headerView
        tableView.separatorStyle = .none
        tableView.reloadData()
        tableView.layoutIfNeeded()
    }
    
    private func setHeartButton() {
           heartButton.addTarget(self, action: #selector(heartButtonTapped), for: .touchUpInside)
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
        if foodTalkRecipes.isEmpty {
            let alert = UIAlertController(title: "알림", message: "레시피가 없습니다.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            let nextVC = RecipeViewController(postName: titleLabel, foodTalkRecipes: foodTalkRecipes)
            nextVC.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(nextVC, animated: true)
        }
    }
    
    func declareViewButtonTapped() {
        guard let foodTalkId = self.foodTalkId else {return}
        let nextVC = DeclareViewController(foodTalkId: foodTalkId)
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func deletePostButtonTapped() {
        let alert = UIAlertController(title: "게시글 삭제", message: "게시글을 정말로 삭제하시겠습니까?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "예", style: .destructive, handler: { (_) in
            self.confirmDeletePost()
        }))
        alert.addAction(UIAlertAction(title: "아니오", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func confirmDeletePost() {
        //게시글 삭제
        let bodyDTO = DeletePostRequestBodyDTO(id: foodTalkId ?? 0)
        NetworkService.shared.foodTalkService.deletePost(bodyDTO: bodyDTO) { response in
            DispatchQueue.main.async {
                switch response {
                case .success(_):
                    print("게시글 삭제 성공")
                    NotificationCenter.default.post(name: NSNotification.Name("FoodTalkDeleteChanged"), object: nil)
                    let talkVC = self.navigationController?.viewControllers.first(where: { $0 is TalkViewController }) as? TalkViewController
                    self.navigationController?.popToViewController(talkVC ?? TalkViewController(), animated: true)
                default:
                    print("게시글 삭제 실패")
                }
            }
        }
    }
    
    private func confirmDeleteComment(at indexPath: IndexPath) {
        let bodyDTO = DeleteCommentRequestBodyDTO(commentId: commentId ?? 0)
        NetworkService.shared.foodTalkService.deleteComment(bodyDTO: bodyDTO) { response in
            DispatchQueue.main.async {
                switch response {
                case .success(_):
                    print("댓글 삭제 성공")
                    self.comments.remove(at: indexPath.section)
                    self.tableView.deleteSections(IndexSet(integer: indexPath.section), with: .automatic)
                    NotificationCenter.default.post(name: NSNotification.Name("FoodCommentDeleteChanged"), object: nil)
                    self.PostRequest()
                default:
                    print("대글 삭제 실패")
                }
            }
        }
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
                    let url = data.data.profileImgUrl
                    self.postUserName = userName
                    self.titleLabel = data.data.name
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
                    self.comments = data.data.foodTalkComments
                    self.foodTalkRecipes = data.data.foodTalkRecipes
                    if let headerView = self.tableView.tableHeaderView as? PostContentView {
                        headerView.updateContent(userName: userName, date: displayDate, title: self.titleLabel, memo: memo, tag: tag, love: love, comment: comment, foodPictureImages: foodPictureImages, foodTalkRecipes: self.foodTalkRecipes, profileImg: url)
                    }
                    self.tableView.reloadData()
                    self.updateHeartButtonState(setLove: data.data.setLove)
                default:
                    print("데이터 저장 실패")
                }
            }
        }
    }
    
    private func updateHeartButtonState(setLove: Bool) {
          if let foodTalkId = self.foodTalkId, let currentItsMe = self.currentItsMe {
              self.heartButton.isSelected = setLove
              let imageName = setLove ? "isHeartSelected" : "isHeartUnselected"
              self.heartButton.setImage(UIImage(named: imageName), for: .normal)
              self.saveHeartButtonState(isSelected: setLove, for: currentItsMe, postId: foodTalkId)
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
        
        if let context = currentReplyContext {
            let request = ReplyWriteRequestBodyDTO(commentId: context.id, content: content)
            print("DTO값\(request)")
            NetworkService.shared.foodTalkService.replyWrite(bodyDTO: request) { [weak self] response in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    switch response {
                    case .success:
                        print("성공 대댓글 저장 완료")
                        self.replyTextField.text = ""
                        self.dismissKeyboard()
                        self.scrollToBottom()
                        self.PostRequest()
                    default:
                        print("대댓글 저장 실패")
                    }
                }
            }
        } else {
            guard let foodTalkId = self.foodTalkId else { return }
            let bodyDTO = CommentWriteRequestBodyDTO(postId: foodTalkId, content: content)
            NetworkService.shared.foodTalkService.commentWrite(bodyDTO: bodyDTO) { [weak self] response in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    switch response {
                    case .success:
                        print("성공 댓글 저장 완료")
                        self.replyTextField.text = ""
                        self.dismissKeyboard()
                        self.scrollToBottom()
                        self.PostRequest()
                    default:
                        print("댓글 저장 실패")
                    }
                }
            }
        }
    }
    
    @objc func heartButtonTapped() {
        guard let foodTalkId = self.foodTalkId, let currentItsMe = self.currentItsMe else { return }
        
        if heartButton.isSelected {
            self.heartButton.setImage(UIImage(named: "isHeartUnselected"), for: .normal)
            let bodyDTO = DeleteLoveRequestBodyDTO(id: foodTalkId)
            NetworkService.shared.foodTalkService.deleteLove(bodyDTO: bodyDTO) { [weak self] response in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    switch response {
                    case .success:
                        print("좋아요 취소 성공")
                        self.PostRequest()
                        self.heartButton.isSelected = false
                        self.saveHeartButtonState(isSelected: false, for: currentItsMe, postId: foodTalkId)
                    default:
                        print("좋아요 취소 실패")
                    }
                }
            }
        } else {
            self.heartButton.setImage(UIImage(named: "isHeartSelected"), for: .normal)
            let bodyDTO = LoveRequestBodyDTO(id: foodTalkId)
            NetworkService.shared.foodTalkService.love(bodyDTO: bodyDTO) { [weak self] response in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    switch response {
                    case .success:
                        print("좋아요 성공")
                        self.PostRequest()
                        self.heartButton.isSelected = true
                        self.saveHeartButtonState(isSelected: true, for: currentItsMe, postId: foodTalkId)
                    default:
                        print("좋아요 실패")
                    }
                }
            }
        }
    }
    
    private func saveHeartButtonState(isSelected: Bool, for user: String, postId: Int) {
        var heartState = UserDefaults.standard.dictionary(forKey: "heartState") as? [String: [String: Bool]] ?? [String: [String: Bool]]()
        var userHeartState = heartState[user] ?? [String: Bool]()
        userHeartState["\(foodTalkId)"] = isSelected
        heartState[user] = userHeartState
        UserDefaults.standard.set(heartState, forKey: "heartState")
    }

    private func loadHeartButtonState(for user: String, postId: Int) -> Bool {
        let heartState = UserDefaults.standard.dictionary(forKey: "heartState") as? [String: [String: Bool]] ?? [String: [String: Bool]]()
        let userHeartState = heartState[user] ?? [String: Bool]()
        return userHeartState["\(foodTalkId)"] ?? false
    }
    
    private func scrollToBottom() {
        let sectionIndex = self.comments.count - 1
        if sectionIndex >= 0 {
            let indexPath = IndexPath(row: 0, section: sectionIndex)
            self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
        currentReplyContext = nil
    }
    
    @objc func keyboardUp(notification: NSNotification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            
            UIView.animate(withDuration: 0.3) {
                self.view.transform = CGAffineTransform(translationX: 0, y: -keyboardHeight)
                self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight + 91, right: 0)
            }
        }
    }

    @objc func keyboardDown() {
        UIView.animate(withDuration: 0.3) {
            self.view.transform = .identity
            self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 91, right: 0)
        }
    }
}

//MARK: - Extension
extension FoodPostViewController: UITableViewDelegate, UITableViewDataSource, FoodTalkReplyCellDelgate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let comment = comments[section]
        print("Comment ID: \(comment.commentId), Replies Count: \(comment.foodTalkReplies?.count ?? 0)")
        return 1 + (comment.foodTalkReplies?.count ?? 0) // 댓글 하나와 대댓글 수
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FoodTalkReplyCell") as! FoodTalkReplyCell
        cell.backgroundColor = UIColor(named: "homeBackgroundColor")
        cell.delegate = self
        
        let comment = comments[indexPath.section]
        if indexPath.row == 0 {
            cell.updateContent(comment: comment)
        } else {
            let replyIndex = indexPath.row - 1
            print("대댓글:\(replyIndex)")
            if let replies = comment.foodTalkReplies, replies.indices.contains(replyIndex) {
                cell.updateContent(reply: replies[replyIndex])
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 95
    }
    
    func replyButtonTapped(_ cell: FoodTalkReplyCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        
        var currentRow = indexPath.row
        let comment = comments[indexPath.section]
        
        if currentRow == 0 {
            print("Current Comment ID: \(comment.commentId)")
            currentReplyContext = (isComment: true, id: comment.commentId)
        } else {
            currentRow -= 1
            if let replies = comment.foodTalkReplies, currentRow < replies.count {
                let replyId = replies[currentRow].replyId
                print("Current Reply ID: \(replyId)")
                currentReplyContext = (isComment: false, id: replies[currentRow].replyId)
            }
        }
        
        replyTextField.becomeFirstResponder()
    }
    
    func replyDeclareButtonTapped(_ cell: FoodTalkReplyCell) {
        print("댓글 삭제창 누름")
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        var currentRow = indexPath.row
        let comment = comments[indexPath.section]
        
        if currentRow == 0 {
            currentReplyContext = (isComment: true, id: comment.commentId)
        } else {
            currentRow -= 1
            if let replies = comment.foodTalkReplies, currentRow < replies.count {
                currentReplyContext = (isComment: false, id: replies[currentRow].replyId)
            }
        }
        
        // 댓글 작성자와 현재 사용자가 같은 지 비교
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        print("댓글작성자 \(commentNickname) 현재유저 \(String(describing: currentItsMe))")
        
        if commentNickname == currentItsMe {
            actionSheet.addAction(UIAlertAction(title: "댓글 삭제", style: .destructive, handler: { (_) in
                // 삭제 로직
                print("댓글 삭제 선택")
                let alert = UIAlertController(title: "댓글 삭제", message: "댓글을 정말로 삭제하시겠습니까?", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "예", style: .destructive, handler: { (_) in
                    self.confirmDeleteComment(at: indexPath)
                }))
                alert.addAction(UIAlertAction(title: "아니오", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
            }))
        } else {
            if currentReplyContext!.isComment {
                    actionSheet.addAction(UIAlertAction(title: "댓글 신고", style: .default, handler: { (_) in
                        guard let indexPath = self.tableView.indexPath(for: cell) else { return }
                        let comment = self.comments[indexPath.section]
                        let nextVC = CommentDeclareViewController()
                        nextVC.commentId = comment.commentId
                        self.navigationController?.pushViewController(nextVC, animated: true)
                    }))
                } else {
                    actionSheet.addAction(UIAlertAction(title: "댓글 신고", style: .default, handler: { (_) in
                        let replyId = self.comments[indexPath.section].foodTalkReplies?[currentRow].replyId
                        let nextVC = CommentDeclareViewController()
                        nextVC.replyId = replyId
                        self.navigationController?.pushViewController(nextVC, animated: true)
                    }))
                }
        }
        
        // 취소
        actionSheet.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        
        // 액션 시트를 표시
        DispatchQueue.main.async {
            self.present(actionSheet, animated: true, completion: nil)
        }
    }
}
