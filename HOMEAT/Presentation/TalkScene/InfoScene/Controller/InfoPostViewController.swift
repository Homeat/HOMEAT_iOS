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

class InfoPostViewController: BaseViewController, InfoHeaderViewDelegate {
    func declareViewButtonTapped() {
        
    }
    //MARK: - Property
    var postId: Int = 0
    private let tableView = UITableView(frame: CGRect.zero, style: .grouped)
    private let postContent = InfoPostContentView()
    private let replyTextView = InfoReplyTextView()
    var commentViewBottomConstraint: NSLayoutConstraint?
    //var comment = [InfoTalkComments] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        setTableView()
        updatePost()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        self.tabBarController?.tabBar.isTranslucent = true
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
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
        tableView.register(InfoPostContentView.self, forHeaderFooterViewReuseIdentifier: "InfoPostContentView")
        tableView.separatorStyle = .none
        tableView.reloadData()
        tableView.layoutIfNeeded()
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
    }
    
    //MARK: - 서버 통신 func
    private func updateHeart() {
        let bodyDTO = InfoLoveRequestBodyDTO(id: postId)
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
        let request = PostInfoRequestBodyDTO(id: postId)
        NetworkService.shared.infoTalkService.postReport(queryDTO: request) { [weak self] response in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch response {
                case .success(let data):
                    print("서버연동 성공")
                    let userName = data.data?.postNickName ?? ""
                    let titleLabel = data.data?.title ?? ""
                    let content = data.data?.content ?? ""
                    // 날짜 형식 변환
                    let dateString = data.data?.createdAt ?? ""
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSSS"
                    let love = String(data.data?.love ?? 0)
                    let comment = String(data.data?.commentNumber ?? 0)
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
                    if let headerView = self.tableView.headerView(forSection: 0) as? InfoPostContentView {
                        headerView.updateContent(userName: userName, date: displayDate , title: titleLabel, content: content,love: love,comment: comment,InfoPictureImages: infoImage,tags: cleanedTags)
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
        
//        let bodyDTO = InfoCommentRequestBodyDTO(id: postId, content: <#T##String#>)
//        NetworkService.shared.infoTalkService.commentWrite(bodyDTO: bodyDTO) { [weak self] response in
//            guard let self = self else { return }
//            DispatchQueue.main.async {
//                switch response {
//                case .success:
//                    print("성공 댓글 저장 완료")
//                    
//                default:
//                    print("댓글 저장 실패")
//                }
//                
//            }
//            
//        }
    }
}

extension InfoPostViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InfoReplyTableViewCell") as! InfoReplyTableViewCell
        cell.backgroundColor =  UIColor(named: "homeBackgroundColor")
        return cell
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "InfoPostContentView") as! InfoPostContentView
        view.delegate = self
        return view
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 520
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 95
    }
}
