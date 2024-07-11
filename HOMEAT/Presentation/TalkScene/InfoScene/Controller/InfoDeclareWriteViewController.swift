//
//  InfoDeclareWriteViewController.swift
//  HOMEAT
//
//  Created by 김민솔 on 7/6/24.
//

import UIKit
import SnapKit
import Then

class InfoDeclareWriteViewController: BaseViewController {
    var activeField: UIView?
    var optionLabel: String?
    private let declareTitle = UILabel()
    private let reasonButton = UIButton()
    private let declareTextField = UITextView()
    private let textLength = UILabel()
    private let declareSendButton = UIButton()
    let textViewPlaceHolder = "신고 내용을 입력해주세요."
    var infoTalkId: Int
    
    init(infoTalkId: Int) {
        self.infoTalkId = infoTalkId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigation()
    }
    
    //MARK: - SetUI
    override func setConfigure() {
        view.backgroundColor = UIColor(named: "homeBackgroundColor")
        
        declareTitle.do {
            $0.text = "신고하는 이유가 무엇인가요?"
            $0.font = UIFont.systemFont(ofSize: 24, weight: .bold)
            $0.textColor = .white
            $0.numberOfLines = 1
            $0.textAlignment = .center
        }
        
        reasonButton.do {
            $0.setTitle(optionLabel, for: .normal)
            $0.setTitleColor(.white, for: .normal)
            $0.backgroundColor = UIColor(r: 54, g: 56, b: 57)
            $0.layer.borderWidth = 1
            $0.layer.cornerRadius = 10
            $0.layer.borderColor = UIColor(r: 187, g: 187, b: 187).cgColor
            $0.contentHorizontalAlignment = .left
            $0.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
            $0.contentEdgeInsets = UIEdgeInsets(top: 0, left: 18, bottom: 0, right: 0)
        }
        
        declareTextField.do {
            $0.backgroundColor = UIColor(r: 54, g: 56, b: 57)
            $0.text = textViewPlaceHolder
            $0.textColor = UIColor(r: 216, g: 216, b: 216)
            $0.font = .systemFont(ofSize: 16, weight: .medium)
            $0.textContainerInset = UIEdgeInsets(top: 15.0, left: 15.0, bottom: 0, right: 0)
            $0.delegate = self
            $0.layer.cornerRadius = 10
        }
        
        textLength.do {
            $0.text = "300자 이내"
            $0.font = UIFont.systemFont(ofSize: 10, weight: .medium)
            $0.textColor = UIColor(r: 216, g: 216, b: 216)
        }
        
        declareSendButton.do {
            $0.setTitle("신고하기", for: .normal)
            $0.backgroundColor = UIColor(named: "turquoiseGreen")
            $0.setTitleColor(.black, for: .normal)
            $0.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
            $0.layer.cornerRadius = 10
            $0.addTarget(self, action: #selector(declareSendAction), for: .touchUpInside)
        }
    }
    
    override func setConstraints() {
        view.addSubviews(declareTitle, reasonButton, declareTextField, textLength, declareSendButton)
        
        declareTitle.snp.makeConstraints {
            $0.leading.equalTo(view.snp.leading).offset(52)
            $0.trailing.equalTo(view.snp.trailing).offset(-52)
            $0.top.equalTo(view.snp.top).offset(139)
        }
        
        reasonButton.snp.makeConstraints {
            $0.leading.equalTo(view.snp.leading).offset(22)
            $0.trailing.equalTo(view.snp.trailing).offset(-21)
            $0.top.equalTo(declareTitle.snp.bottom).offset(50)
            $0.height.equalTo(47)
        }
        
        declareTextField.snp.makeConstraints {
            $0.leading.equalTo(reasonButton.snp.leading)
            $0.trailing.equalTo(reasonButton.snp.trailing)
            $0.top.equalTo(reasonButton.snp.bottom).offset(30)
            $0.height.equalTo(144)
        }
        
        textLength.snp.makeConstraints {
            $0.trailing.equalTo(declareTextField.snp.trailing)
            $0.top.equalTo(declareTextField.snp.bottom).offset(10)
            $0.height.equalTo(14)
        }
        
        declareSendButton.snp.makeConstraints {
            $0.leading.equalTo(reasonButton.snp.leading)
            $0.trailing.equalTo(reasonButton.snp.trailing)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-19)
            $0.height.equalTo(57)
        }
    }
    
    private func setNavigation() {
        self.navigationItem.title = "게시글 신고하기"
        let backbutton = UIBarButtonItem()
        backbutton.tintColor = .white
        navigationController?.navigationBar.topItem?.backBarButtonItem = backbutton
        navigationController?.navigationBar.barTintColor = UIColor(named: "homeBackgroundColor")
    }
     
    @objc func declareSendAction() {
        guard declareTextField.text.count <= 300 else {
            let alertController = UIAlertController(title: "경고", message: "300자 이내로 작성해주세요", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
            return
        }
        let bodyDTO = ComplainPostRequestBodyDTO(postId: infoTalkId)
        NetworkService.shared.infoTalkService.complainPost(bodyDTO: bodyDTO) { response in
            switch response {
            case .success(let data):
                print("신고하기 성공")
                let alertController = UIAlertController(title: "신고 접수", message: "신고가 접수되었습니다", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "확인", style: .default) { _ in
                    if let viewControllers = self.navigationController?.viewControllers {
                        let targetViewController = viewControllers[max(0, viewControllers.count - 3)]
                        self.navigationController?.popToViewController(targetViewController, animated: true)
                    }
                }
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
            default:
                print("신고하기 실패")
            }
        }
    }
}

extension InfoDeclareWriteViewController: UITextFieldDelegate, UITextViewDelegate {
    func adjustViewForKeyboard(show: Bool, keyboardHeight: CGFloat) {
        guard let activeField = self.activeField else { return }
        
        let adjustmentHeight = (show ? keyboardHeight : 0)
    
        var aRect = self.view.frame
        aRect.size.height -= adjustmentHeight
        
        if show {
            if let activeFieldFrame = activeField.superview?.convert(activeField.frame, to: self.view) {
                if !aRect.contains(activeFieldFrame.origin) {
                    let scrollPoint = CGPoint(x: 0, y: activeFieldFrame.origin.y - keyboardHeight)
                    UIView.animate(withDuration: 0.3) {
                        self.view.frame.origin.y = -scrollPoint.y
                    }
                }
            }
        } else {
            UIView.animate(withDuration: 0.3) {
                self.view.frame.origin.y = 0
            }
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        activeField = textView
        if textView.text == textViewPlaceHolder {
            textView.text = nil
            textView.textColor = .warmgray
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        activeField = nil
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.text = textViewPlaceHolder
            textView.textColor = .warmgray
        }
    }
    
    private func textViewShouldReturn(_ textView: UITextView) -> Bool{
        // 키보드 내리면서 동작
        textView.resignFirstResponder()
        return true
    }
}
