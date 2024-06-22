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
    private let postContent = PostContentView()
    private let replyTextView = UIView()
    let replyTextField = UITextField()
    private let heartButton = UIButton()
    private let sendButton = UIButton()
    var commentViewBottomConstraint: NSLayoutConstraint?
  
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        setTableView()
        setTabbar()
        setupKeyboardEvent()
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
            $0.textColor = UIColor(named: "font5")
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
        let nextVC = RecipeViewController()
        nextVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func declareViewButtonTapped() {
        let nextVC = DeclareViewController()
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    // MARK: -- objc
    @objc func sendButtonTapped() {
        //작성한 댓글을 서버로 전달
        //작성한 댓글 삭제
        //키보드 내림
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func keyboardUp(notification: NSNotification) {
        if let keyboardFrame:NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            
            UIView.animate(
                withDuration: 0.3
                , animations: {
                    self.view.transform = CGAffineTransform(translationX: 0, y: -keyboardRectangle.height)
                }
            )
        }
    }
    
    @objc func keyboardDown() {
        self.view.transform = .identity
    }
}

//MARK: - Extension
extension FoodPostViewController: UITableViewDelegate, UITableViewDataSource, FoodTalkReplyCellDelgate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FoodTalkReplyCell") as! FoodTalkReplyCell
        cell.backgroundColor = UIColor(named: "homeBackgroundColor")
        cell.delegate = self
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
