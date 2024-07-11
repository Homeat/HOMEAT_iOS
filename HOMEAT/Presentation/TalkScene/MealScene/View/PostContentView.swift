//
//  PostContentView.swift
//  HOMEAT
//
//  Created by 이지우 on 5/6/24.
//

import Foundation
import UIKit
import SnapKit
import Then
import Kingfisher

protocol HeaderViewDelegate: AnyObject {
    func recipeViewButtonTapped()
    func declareViewButtonTapped()
    func deletePostButtonTapped()
}

class PostContentView: UITableViewHeaderFooterView, UIScrollViewDelegate {
    weak var delegate: HeaderViewDelegate?
    var currentItsMe : String?
    //MARK: - Property
    var profileIcon = UIImageView()
    var userName = UILabel()
    var dateLabel = UILabel()
    private let declareButton = UIButton()
    var hashtagButton = UIButton()
    var titleLabel = UILabel()
    var contentLabel = UILabel()
    var pageControl = UIPageControl()
    private let scrollView = UIScrollView()
    var reactionView = ReplyReactionView()
    private let underLine = UIView()
    private let recipeViewButton = UIButton()
    
    var images = [UIImage]()
    var imageViews = [UIImageView]()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setConfigure()
        setConstraint()
        setPageControl()
        setAddTarget()
        self.currentItsMe = UserDefaults.standard.string(forKey: "userNickname")
        print(currentItsMe)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        profileIcon.layer.cornerRadius = profileIcon.frame.width / 2

        // 높이 계산
        let contentWidth = self.bounds.width - 40 // 좌우 패딩
        let titleLabelSize = titleLabel.sizeThatFits(CGSize(width: contentWidth, height: CGFloat.greatestFiniteMagnitude))
        let contentLabelSize = contentLabel.sizeThatFits(CGSize(width: contentWidth, height: CGFloat.greatestFiniteMagnitude))

        var totalHeight = 0.0
        totalHeight += 20.0 + Double(titleLabelSize.height) // 프로필 아이콘 높이 + 마진
        totalHeight += 20 + titleLabelSize.height // 해시태그 버튼 높이 + 마진
        totalHeight += 8 + titleLabelSize.height // 제목 라벨 위의 마진 + 높이
        totalHeight += 5 + contentLabelSize.height // 컨텐츠 라벨 위의 마진 + 높이
        totalHeight += 19 + 257 // 이미지 뷰 위의 마진 + 고정 높이
        totalHeight += 12 + 20 + 19 // 페이지 컨트롤러와 반응 뷰 위의 마진들
        totalHeight += Double(underLine.frame.height + 20) // 언더라인 높이 + 마진

        // 헤더뷰의 높이 조정
        self.frame.size.height = totalHeight
    }
    //MARK: - SetUI
    private func setConfigure() {
        profileIcon.do {
            $0.backgroundColor = UIColor(named: "turquoiseGreen")
            $0.image = UIImage(named: "profileIcon")
            $0.layer.cornerRadius = $0.frame.width / 2 // 원형으로 만들기 위해 반지름을 설정
            $0.layer.borderWidth = 1.3
            $0.layer.borderColor = UIColor.white.cgColor
            $0.contentMode = .scaleAspectFill
            $0.clipsToBounds = true // 원형 모양을 유지하기 위해 필요
        }
        
        userName.do {
            $0.text = "사용자이름"
            $0.font = .bodyMedium15
            $0.textColor = .white
        }
        
        dateLabel.do {
            $0.text = "mm월 dd일 12:00"
            $0.font = .captionMedium10
            $0.textColor = .warmgray8
        }
        
        declareButton.do {
            $0.setImage(UIImage(named: "dots"), for: .normal)
            $0.setTitleColor(UIColor(named: "warmgray8"), for: .normal)
            $0.titleLabel?.font = .captionMedium10
            $0.contentMode = .scaleAspectFit
        }
        
        hashtagButton.do {
            $0.setTitle("#아침", for: .normal)
            $0.setTitleColor(UIColor(named: "turquoiseGreen"), for: .normal)
            $0.layer.cornerRadius = 10
            $0.layer.borderWidth = 1.2
            $0.layer.borderColor = UIColor(named: "turquoiseGreen")?.cgColor
            $0.titleLabel?.font = .captionMedium10
        }
        
        titleLabel.do {
            $0.text = "연어 샐러드"
            $0.font = .bodyMedium18
            $0.textColor = UIColor(named: "turquoiseGreen")
        }
        
        contentLabel.do {
            $0.text = "메모내용이 들어갈 자리입니다."
            $0.font = .bodyMedium15
            $0.textColor = .white
            $0.numberOfLines = 0
        }
        
        scrollView.do {
            $0.delegate = self
            $0.isPagingEnabled = true
        }
        
        underLine.do {
            $0.backgroundColor = UIColor(named: "turquoiseDarkGray")
        }
        
        recipeViewButton.do {
            $0.setTitle("레시피 보기", for: .normal)
            $0.setTitleColor(UIColor(named: "turquoiseGreen"), for: .normal)
            $0.titleLabel?.font = .captionMedium13
            $0.layer.cornerRadius = 18.5
            $0.layer.borderWidth = 2
            $0.layer.borderColor = UIColor(named: "turquoiseGreen")?.cgColor
        }
    }
    
    private func setConstraint() {
        addSubviews(profileIcon, userName, dateLabel, declareButton, hashtagButton, titleLabel, contentLabel, pageControl, scrollView, reactionView, underLine, recipeViewButton)
        
        profileIcon.snp.makeConstraints {
            $0.top.equalTo(contentView.snp.top)
            $0.leading.equalTo(contentView.snp.leading).offset(20)
            $0.width.equalTo(37.8)
            $0.height.equalTo(37.8)
        }
        
        userName.snp.makeConstraints {
            $0.top.equalTo(profileIcon.snp.top)
            $0.leading.equalTo(profileIcon.snp.trailing).offset(11.2)
            $0.height.equalTo(22)
        }
        
        dateLabel.snp.makeConstraints {
            $0.leading.equalTo(userName.snp.leading)
            $0.bottom.equalTo(profileIcon.snp.bottom)
            $0.height.equalTo(14)
        }
        
        declareButton.snp.makeConstraints {
            $0.top.equalTo(userName.snp.top)
            $0.bottom.equalTo(dateLabel.snp.bottom)
            $0.trailing.equalTo(self.snp.trailing).inset(20)
        }
        
        hashtagButton.snp.makeConstraints {
            $0.top.equalTo(profileIcon.snp.bottom).offset(20.2)
            $0.leading.equalTo(profileIcon.snp.leading)
            $0.width.equalTo(41)
            $0.height.equalTo(20)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(hashtagButton.snp.bottom).offset(8)
            $0.leading.equalTo(profileIcon.snp.leading)
        }
        
        contentLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(5)
            $0.leading.equalTo(profileIcon.snp.leading)
            $0.trailing.equalTo(self.snp.trailing).offset(-20)
        }
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(contentLabel.snp.bottom).offset(19)
            $0.leading.equalTo(profileIcon.snp.leading)
            $0.trailing.equalTo(self.snp.trailing).offset(-20)
            $0.height.equalTo(257)
        }
        
        pageControl.snp.makeConstraints {
            $0.top.equalTo(scrollView.snp.bottom).offset(12)
            $0.centerX.equalTo(self.snp.centerX)
        }
        
        reactionView.snp.makeConstraints {
            $0.top.equalTo(pageControl.snp.bottom).offset(19)
            $0.leading.equalTo(scrollView.snp.leading)
        }
        
        underLine.snp.makeConstraints {
            $0.bottom.equalTo(self.snp.bottom)
            $0.leading.equalTo(self.snp.leading)
            $0.trailing.equalTo(self.snp.trailing)
            $0.height.equalTo(4)
        }
        
        recipeViewButton.snp.makeConstraints {
            $0.top.equalTo(hashtagButton.snp.top)
            $0.trailing.equalTo(declareButton.snp.trailing)
            $0.height.equalTo(35)
            $0.width.equalTo(97)
        }
    }
        
    private func setAddTarget() {
        declareButton.addTarget(self, action: #selector(declareButtonTapped), for: .touchUpInside)
        recipeViewButton.addTarget(self, action: #selector(recipeButtonTapped), for: .touchUpInside)
    }
    
    //MARK: - Method
    private func addContentScrollView() {
        for i in 0..<images.count {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFit
            imageView.frame = CGRect(x: scrollView.bounds.width * CGFloat(i), y: 0, width: scrollView.bounds.width, height: scrollView.bounds.height)
            imageView.image = images[i]
            scrollView.addSubview(imageView)
            imageViews.append(imageView)
        }
        scrollView.contentSize.width = scrollView.bounds.width * CGFloat(images.count)
    }
        
    private func setPageControl() {
        pageControl.numberOfPages = images.count
    }
        
    private func setPageControlSelectedPage(currentPage: Int) {
        pageControl.currentPage = currentPage
    }
        
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let value = scrollView.contentOffset.x / scrollView.frame.size.width
        setPageControlSelectedPage(currentPage: Int(round(value)))
    }
    
    func updateContent(userName: String, date: String, title: String, memo: String, tag: String, love: String, comment: String, foodPictureImages: [String], foodTalkRecipes: [FoodTalkRecipe], profileImg: String) {
        DispatchQueue.main.async {
            if let url = URL(string: profileImg) {
                self.profileIcon.kf.setImage(with: url, placeholder: nil, options: nil, progressBlock: nil) { result in
                    switch result {
                    case .success(let value):
                        print("Image successfully loaded: \(value.source.url?.absoluteString ?? "")")
                    case .failure(let error):
                        print("Error loading image: \(error.localizedDescription)")
                    }
                }
            }
        }
        self.userName.text = userName
        print(userName)
        self.titleLabel.text = title
        self.dateLabel.text = date
        self.hashtagButton.setTitle("#" + tag, for: .normal)
        self.contentLabel.text = memo
        reactionView.updateContent(love: love, comment: comment)
        
        // 이미지 로드를 위한 초기화
        images.removeAll()
        imageViews.forEach { $0.removeFromSuperview() }
        imageViews.removeAll()
        scrollView.contentSize.width = 0
        
        loadImagesWithKingfisher(from: foodPictureImages)
        
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
    

    private func loadImagesWithKingfisher(from urls: [String]) {
        for urlString in urls {
            guard let url = URL(string: urlString) else { continue }
            
            // Kingfisher를 사용하여 비동기로 이미지 다운로드
            let imageView = UIImageView()
            imageView.kf.setImage(with: url, placeholder: UIImage(named: "placeholder"), options: [.transition(.fade(0.2)), .cacheOriginalImage]) { result in
                switch result {
                case .success(let value):
                    DispatchQueue.main.async {
                        self.images.append(value.image)
                        self.addImageToScrollView(value.image)
                        self.pageControl.numberOfPages = self.images.count
                        self.updateScrollViewContentSize()
                    }
                case .failure(let error):
                    print("Error: \(error)")
                }
            }
        }
    }

    private func addImageToScrollView(_ image: UIImage) {
        let imageView = UIImageView()
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        let xPos = scrollView.frame.width * CGFloat(images.count - 1)
        imageView.frame = CGRect(x: xPos, y: 0, width: scrollView.bounds.width, height: scrollView.bounds.height)
        scrollView.addSubview(imageView)
        imageViews.append(imageView)
    }

    private func updateScrollViewContentSize() {
        scrollView.contentSize.width = scrollView.bounds.width * CGFloat(images.count)
    }

    //MARK: - @objc
    @objc private func declareButtonTapped() {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
       
        if currentItsMe == userName.text {
            actionSheet.addAction(UIAlertAction(title: "게시글 삭제", style: .destructive, handler: { (_) in
                self.delegate?.deletePostButtonTapped()
            }))
        } else {
            actionSheet.addAction(UIAlertAction(title: "게시글 신고", style: .default, handler: { (_) in
                self.delegate?.declareViewButtonTapped()
            }))
        }
        actionSheet.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        
        if let viewController = delegate as? UIViewController {
            viewController.present(actionSheet, animated: true, completion: nil)
        }
    }
    @objc func recipeButtonTapped() {
        delegate?.recipeViewButtonTapped()
    }
}

