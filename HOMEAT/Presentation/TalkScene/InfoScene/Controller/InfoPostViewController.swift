//
//  InfoPostViewController.swift
//  HOMEAT
//
//  Created by 김민솔 on 5/19/24.
//

import UIKit
import Then
import SnapKit
import Kingfisher
import Alamofire

class InfoPostViewController: BaseViewController, InfoHeaderViewDelegate,UITextFieldDelegate {
    
    func deletePostButtonTapped() {
        let alert = UIAlertController(title: "게시글 삭제", message: "게시글을 정말로 삭제하시겠습니까?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "예", style: .destructive, handler: { (_) in
            self.confirmDeletePost()
        }))
        alert.addAction(UIAlertAction(title: "아니오", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func declareViewButtonTapped() {
        guard let infoTalkId = self.postId else {return}
        let nextVC = InfoDeclareViewController(infoTalkId: infoTalkId)
        navigationController?.pushViewController(nextVC, animated: true)
    }
    //MARK: - Property
    var postId: Int?
    var userName: String?
    var postUserName: String? //게시글 작성자
    var commentNickname: String?
    var commentId: Int?
    var currentReplyContext: (isComment: Bool, id: Int)?
    private let tableView = UITableView(frame: CGRect.zero, style: .grouped)
    private let postContent = InfoPostContentView()
    private let replyTextView = UIView()
    let replyTextField = UITextField()
    private let sendButton = UIButton()
    private let heartButton = UIButton()
    var commentViewBottomConstraint: NSLayoutConstraint?
    var comments : [InfoTalkComments] = []
    var currentItsMe : String?
    //MARK: - Initializer
    init(infoTalkId: Int) {
        self.postId = infoTalkId
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        setTableView()
        setupKeyboardEvent()
        setHeartButton()
        updatePost()
        
        self.currentItsMe = UserDefaults.standard.string(forKey: "userNickname")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        self.tabBarController?.tabBar.isTranslucent = true
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardUp), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDown), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func setNavigationBar() {
        self.navigationItem.title = "정보토크"
        let backbutton = UIBarButtonItem()
        backbutton.tintColor = .white
        navigationController?.navigationBar.topItem?.backBarButtonItem = backbutton
        navigationController?.navigationBar.barTintColor = UIColor(named: "homeBackgroundColor")
    }
    
    private func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.register(InfoReplyTableViewCell.self, forCellReuseIdentifier: "InfoReplyTableViewCell")
        tableView.separatorStyle = .none
        let headerView = InfoPostContentView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 520))
        headerView.delegate = self
        tableView.tableHeaderView = headerView
        tableView.reloadData()
        tableView.layoutIfNeeded()
    }
    private func setHeartButton() {
        if let infoTalkId = self.postId {
            let isSelected = loadHeartButtonState()
            self.heartButton.isSelected = isSelected
            let imageName = isSelected ? "isHeartSelected" : "isHeartUnselected"
            self.heartButton.setImage(UIImage(named: imageName), for: .normal)
        }
    }
    
    private func confirmDeletePost() {
        //게시글 삭제
        let bodyDTO = InfoDeletePostRequestBodyDTO(id: postId ?? 0)
        NetworkService.shared.infoTalkService.deletePost(bodyDTO: bodyDTO) { response in
            DispatchQueue.main.async {
                switch response {
                case .success(_):
                    print("게시글 삭제 성공")
                    NotificationCenter.default.post(name: NSNotification.Name("InfoTalkDeleteChanged"), object: nil)
                    let talkVC = self.navigationController?.viewControllers.first(where: { $0 is TalkViewController }) as? TalkViewController
                    self.navigationController?.popToViewController(talkVC ?? TalkViewController(), animated: true)
                    talkVC?.switchToInfoTalk()
                default:
                    print("게시글 삭제 실패")
                }
            }
        }
    }
    private func confirmDeleteComment(at indexPath: IndexPath) {
        let bodyDTO = InfoDeleteCommentRequestBodyDTO(commentId: commentId ?? 0)
        NetworkService.shared.infoTalkService.deleteComment(bodyDTO: bodyDTO) { response in
            DispatchQueue.main.async {
                switch response {
                case .success(_):
                    print("댓글 삭제 성공")
                    self.comments.remove(at: indexPath.section)
                    self.tableView.deleteSections(IndexSet(integer: indexPath.section), with: .automatic)
                    NotificationCenter.default.post(name: NSNotification.Name("InfoCommentDeleteChanged"), object: nil)
                    self.updatePost()
                    
                default:
                    print("댓글 삭제 실패")
                }
            }
        }
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
    func setupKeyboardEvent() {
        replyTextField.delegate = self
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        
    }
    //MARK: - 서버 통신 func
    private func updateHeart() {
        let bodyDTO = InfoLoveRequestBodyDTO(id: postId ?? 0)
        NetworkService.shared.infoTalkService.lovePost(bodyDTO: bodyDTO) { [weak self] response in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch response {
                case .success(let data):
                    print("공감 서버 연동 성공")
                default:
                    print("공감 서버 연동 실패")
                    
                }
            }
        }
    }
    private func updatePost() {
        guard let infoTalkId = postId else { return }
        let request = PostInfoRequestBodyDTO(id: infoTalkId)
        NetworkService.shared.infoTalkService.postReport(queryDTO: request) { [weak self] response in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch response {
                case .success(let data):
                    print("서버연동 성공")
                    let userName = data.data?.postNickName ?? ""
                    self.postUserName = userName
                    let url = data.data?.profileImgUrl
                    let titleLabel = data.data?.title ?? ""
                    let content = data.data?.content ?? ""
                    // 날짜 형식 변환
                    let dateString = data.data?.createdAt ?? ""
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSSS"
                    let love = String(data.data?.love ?? 0)
                    let comment = String(data.data?.commentNumber ?? 0)
                    self.comments = data.data?.infoTalkComments ?? []
                    print("댓글\(self.comments)")
                    let infoImage = data.data?.infoPictureImages ?? []
                    var displayDate = ""
                    let tagsString = data.data?.tags ?? []
                    let cleanedTags = tagsString.flatMap { tag in
                        tag.trimmingCharacters(in: CharacterSet(charactersIn: "[]\"")).components(separatedBy: "\", \"")
                    }
                    
                    if let date = dateFormatter.date(from: dateString) {
                        let displayFormatter = DateFormatter()
                        displayFormatter.dateFormat = "MM월 dd일 HH:mm"
                        displayDate = displayFormatter.string(from: date)
                        print("변환된 날짜: \(displayDate)")
                    } else {
                        print("날짜 형식 변환 실패")
                    }
                    print("이미지\(infoImage)")
                    print("프로필 url:\(url)")
                    if let headerView = self.tableView.tableHeaderView as? InfoPostContentView {
                        headerView.updateContent(userName: userName, date: displayDate, title: titleLabel, content: content, love: love, comment: comment, InfoPictureImages: infoImage, tags: cleanedTags,profileImg: url ?? "")
                    }
                    self.tableView.reloadData()
                default:
                    print("서버연동 실패")
                }
            }
        }
    }
    //MARK: - objc
    
    @objc func sendButtonTapped() {
        guard let content = replyTextField.text, !content.isEmpty else {
            print("댓글 내용이 없습니다.")
            return
        }
        
        if let context = currentReplyContext {
            let request = InfoReplyRequestBodyDTO(commentId: context.id, content: content)
            NetworkService.shared.infoTalkService.replyComment(bodyDTO: request) { [weak self] response in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    switch response {
                    case .success:
                        print("성공 대댓글 저장 완료")
                        self.replyTextField.text = ""
                        self.dismissKeyboard()
                        self.scrollToBottom()
                        self.updatePost()
                    default:
                        print("대댓글 저장 실패")
                    }
                }
            }
        } else {
            guard let infoTalkId = self.postId else { return }
            let bodyDTO = InfoCommentRequestBodyDTO(postId: infoTalkId, content: content)
            NetworkService.shared.infoTalkService.commentWrite(bodyDTO: bodyDTO) { [weak self] response in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    switch response {
                    case .success:
                        print("성공 댓글 저장 완료")
                        self.replyTextField.text = ""
                        self.updatePost()
                        self.dismissKeyboard()
                        self.scrollToBottom()
                    default:
                        print("댓글 저장 실패")
                    }
                }
            }
        }
    }
    
    
    @objc func heartButtonTapped() {
        guard let infoTalkId = self.postId else { return }
        
        if heartButton.isSelected {
            self.heartButton.setImage(UIImage(named: "isHeartUnselected"), for: .normal)
            let bodyDTO = InfoDeleteLoveRequestBodyDTO(id: infoTalkId)
            NetworkService.shared.infoTalkService.deleteLove(bodyDTO: bodyDTO) { [weak self] response in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    switch response {
                    case .success:
                        print("좋아요 취소 성공")
                        self.updatePost()
                        self.heartButton.isSelected = false
                        self.saveHeartButtonState(isSelected: false)
                    default:
                        print("좋아요 취소 실패")
                    }
                }
            }
        } else {
            self.heartButton.setImage(UIImage(named: "isHeartSelected"), for: .normal)
            let bodyDTO = InfoLoveRequestBodyDTO(id: infoTalkId)
            NetworkService.shared.infoTalkService.lovePost(bodyDTO: bodyDTO) { [weak self] response in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    switch response {
                    case .success:
                        print("좋아요 성공")
                        self.updatePost()
                        self.heartButton.isSelected = true
                        self.saveHeartButtonState(isSelected: true)
                    default:
                        print("좋아요 실패")
                    }
                }
            }
        }
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
    //MARK: - UserDefault
    func saveHeartButtonState(isSelected: Bool) {
        if let infoTalkId = self.postId {
            UserDefaults.standard.set(isSelected, forKey: "heartButtonState_\(infoTalkId)")
        }
    }
    
    func loadHeartButtonState() -> Bool {
        if let infoTalkId = self.postId {
            return UserDefaults.standard.bool(forKey: "heartButtonState_\(infoTalkId)")
        }
        return false
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource, InfoTalkReplyCellDelgate

extension InfoPostViewController: UITableViewDelegate, UITableViewDataSource, InfoTalkReplyCellDelgate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let comment = comments[section]
        print("Comment ID: \(comment.commentId), Replies Count: \(comment.infoTalkReplies?.count ?? 0)")
        return 1 + (comment.infoTalkReplies?.count ?? 0) // 댓글 하나와 대댓글 수
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InfoReplyTableViewCell", for: indexPath) as! InfoReplyTableViewCell
        cell.backgroundColor = UIColor(named: "homeBackgroundColor")
        cell.delegate = self
        
        let comment = comments[indexPath.section]
        
        if indexPath.row == 0 {
            cell.updateContent(comment: comment)
        } else {
            let replyIndex = indexPath.row - 1
            print("대댓글:\(replyIndex)")
            if let replies = comment.infoTalkReplies, replies.indices.contains(replyIndex) {
                cell.updateContent(reply: replies[replyIndex])
                
            }
            
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 95
    }
    
    func replyButtonTapped(_ cell: InfoReplyTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        
        var currentRow = indexPath.row
        let comment = comments[indexPath.section]
        
        if currentRow == 0 {
            print("Current Comment ID: \(comment.commentId)")
            currentReplyContext = (isComment: true, id: comment.commentId)
        } else {
            currentRow -= 1
            if let replies = comment.infoTalkReplies, currentRow < replies.count {
                let replyId = replies[currentRow].replyId
                print("Current Reply ID: \(replyId)")
                currentReplyContext = (isComment: false, id: replyId)
            }
        }
        
        replyTextField.becomeFirstResponder()
    }
    
    func replyDeclareButtonTapped(_ cell: InfoReplyTableViewCell) {
        print("댓글 삭제창 누름")
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        var currentRow = indexPath.row
        let comment = comments[indexPath.section]
        
        if currentRow == 0 {
            print("Current Comment ID: \(comment.commentId)")
            print("Current Comment Nickname: \(comment.commentNickName)")
            commentNickname = comment.commentNickName
            commentId = comment.commentId
            currentReplyContext = (isComment: true, id: comment.commentId)
        } else {
            currentRow -= 1
            if let replies = comment.infoTalkReplies, currentRow < replies.count {
                let replyId = replies[currentRow].replyId
                print("Current Reply ID: \(replyId)")
                commentNickname = replies[currentRow].replyNickName
                commentId = replyId
                currentReplyContext = (isComment: false, id: replyId)
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
          
            actionSheet.addAction(UIAlertAction(title: "댓글 신고", style: .default, handler: { (_) in
                   // 신고 로직
           guard let indexPath = self.tableView.indexPath(for: cell) else { return }
           let comment = self.comments[indexPath.section]
           let nextVC = InfoCommentDeclareViewController()
                   nextVC.commentId = comment.commentId
           self.navigationController?.pushViewController(nextVC, animated: true)
           }))
        }
        
        // 취소
        actionSheet.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        
        // 액션 시트를 표시
        DispatchQueue.main.async {
            self.present(actionSheet, animated: true, completion: nil)
        }
    }

}
