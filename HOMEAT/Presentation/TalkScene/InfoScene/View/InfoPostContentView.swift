//
//  InfoPostContentView.swift
//  HOMEAT
//
//  Created by 김민솔 on 5/19/24.
//

import Foundation
import UIKit
import SnapKit
import Then
import Kingfisher
protocol InfoHeaderViewDelegate: AnyObject {
    func declareViewButtonTapped()
    func deletePostButtonTapped()
}

class InfoPostContentView: UITableViewHeaderFooterView, UIScrollViewDelegate {
    
    weak var delegate: InfoHeaderViewDelegate?
    
    //MARK: - Property
    private let profileIcon = UIImageView()
    private let userName = UILabel()
    private let dateLabel = UILabel()
    private let declareButton = UIButton()
    private let titleLabel = UILabel()
    private let contentLabel = UILabel()
    private let pageControl = UIPageControl()
    private let scrollView = UIScrollView()
    private let reactionView = UIStackView()
    private let heartCount = UIButton()
    private let replyCount = UIButton()
    private let underLine = UIView()
    var currentItsMe : String?
    var selectedTags : [String] = []
    var images = [UIImage]()
    var imageViews = [UIImageView]()
    private lazy var tagCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(PostTagCollectionViewCell.self, forCellWithReuseIdentifier: "PostTagCell")
        return collectionView
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setConfigure()
        setConstraint()
        scrollView.delegate = self
        setPageControl()
        setAddTarget()
        self.currentItsMe = UserDefaults.standard.string(forKey: "userNickname")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - SetUI
    private func setConfigure() {
        profileIcon.do {
            $0.backgroundColor = UIColor(named: "turquoiseGreen")
            $0.image = UIImage(named: "profileIcon")
            $0.layer.cornerRadius = 20
            $0.layer.borderWidth = 1.3
            $0.layer.borderColor = UIColor.white.cgColor
            $0.contentMode = .scaleAspectFit
        }
        
        userName.do {
            $0.text = "홈잇러버 아리"
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
        }
        
        underLine.do {
            $0.backgroundColor = UIColor(named: "turquoiseDarkGray")
        }
        
        heartCount.do {
            $0.setTitle("9", for: .normal)
            $0.titleLabel?.font = .bodyMedium10
            $0.setTitleColor(UIColor.turquoiseGreen, for: .normal)
            $0.setImage(UIImage(named: "isSmallHeartSelected"), for: .normal)
            $0.imageView?.contentMode = .scaleAspectFit
            $0.imageEdgeInsets = UIEdgeInsets(top: 0, left: -5, bottom: 0, right: 0)
        }
        
        replyCount.do {
            $0.setTitle("2", for: .normal)
            $0.titleLabel?.font = .bodyMedium10
            $0.setTitleColor(UIColor.turquoiseGreen, for: .normal)
            $0.setImage(UIImage(named: "isReply"), for: .normal)
            $0.imageView?.contentMode = .scaleAspectFit
            $0.imageEdgeInsets = UIEdgeInsets(top: 0, left: -5, bottom: 0, right: 0)
        }
        
        reactionView.do {
            $0.spacing = 10
            $0.axis = .horizontal
            $0.alignment = .center
        }
    }
    
    private func setConstraint() {
        addSubviews(profileIcon, userName, dateLabel, declareButton, tagCollectionView,titleLabel, contentLabel, pageControl, scrollView, reactionView, underLine)
        reactionView.addArrangedSubview(heartCount)
        reactionView.addArrangedSubview(replyCount)
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
        
        tagCollectionView.snp.makeConstraints {
            $0.top.equalTo(profileIcon.snp.bottom).offset(20.2)
            $0.leading.equalTo(profileIcon.snp.leading)
            $0.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(30)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(tagCollectionView.snp.bottom).offset(8)
            $0.leading.equalTo(profileIcon.snp.leading)
        }
        
        contentLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(5)
            $0.leading.equalTo(profileIcon.snp.leading)
        }
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(contentLabel.snp.bottom).offset(19)
            $0.leading.equalTo(profileIcon.snp.leading)
            $0.trailing.equalToSuperview().inset(20)
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
        
    }
    
    private func setAddTarget() {
        declareButton.addTarget(self, action: #selector(declareButtonTapped), for: .touchUpInside)
    }
    
    //MARK: - Method
    private func addContentScrollView() {
        for i in 0..<images.count {
            let imageView = UIImageView()
            let xPos = scrollView.frame.width * CGFloat(i)
            imageView.frame = CGRect(x: xPos, y: 0, width: scrollView.bounds.width, height: scrollView.bounds.height)
            imageView.image = images[i]
            imageView.contentMode = .scaleAspectFit
            scrollView.addSubview(imageView)
            scrollView.contentSize = CGSize(width: scrollView.frame.width * CGFloat(images.count), height: scrollView.frame.height)
        }
    }
    
    private func setPageControl() {
        pageControl.numberOfPages = images.count
        
    }
    
    private func setPageControlSelectedPage(currentPage:Int) {
        pageControl.currentPage = currentPage
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let value = scrollView.contentOffset.x/scrollView.frame.size.width
        setPageControlSelectedPage(currentPage: Int(round(value)))
    }
    func updateUIWithImages() {
        scrollView.subviews.forEach { $0.removeFromSuperview() }
        for(index, image) in images.enumerated() {
            let imageView = UIImageView(image: image)
            imageView.contentMode = .scaleAspectFill
            let xPos = CGFloat(index) * scrollView.bounds.width
            imageView.frame = CGRect(x: xPos, y: 0, width: scrollView.bounds.width, height: scrollView.bounds.height)
            scrollView.addSubview(imageView)
        }
        scrollView.contentSize = CGSize(width: scrollView.bounds.width * CGFloat(images.count), height: scrollView.bounds.height)
        pageControl.numberOfPages = images.count
    }
    private func loadImages(from urls: [String]) {
        images.removeAll()
        let group = DispatchGroup()
        
        for urlString in urls {
            guard let url = URL(string: urlString) else { continue }
            group.enter()
            KingfisherManager.shared.retrieveImage(with: url) { result in
                switch result {
                case .success(let value):
                    self.images.append(value.image)
                case .failure(let error):
                    print("Error loading image: \(error)")
                }
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            self.updateUIWithImages()
        }
    }
    private func updateScrollViewContentSize() {
        scrollView.contentSize.width = scrollView.bounds.width * CGFloat(images.count)
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
    func updateContent(userName: String,date: String, title:String,content:String, love: String, comment: String, InfoPictureImages: [String],tags: [String]) {
        self.userName.text = userName
        self.dateLabel.text = date
        self.titleLabel.text = title
        self.contentLabel.text = content
        // 이미지 로드를 위한 초기화
        images.removeAll()
        imageViews.forEach { $0.removeFromSuperview() }
        imageViews.removeAll()
        scrollView.contentSize.width = 0
        self.heartCount.setTitle(love, for: .normal)
        self.replyCount.setTitle(comment, for: .normal)
        print(love)
        print(comment)
        let cleanedTags = tags.flatMap { tag in
            tag.trimmingCharacters(in: CharacterSet(charactersIn: "[]\"")).components(separatedBy: "\", \"")
        }
        if cleanedTags.isEmpty || cleanedTags == [""] {
            self.tagCollectionView.isHidden = true
        } else {
            self.tagCollectionView.isHidden = false
            self.selectedTags = cleanedTags
            self.tagCollectionView.reloadData()
        }
        loadImages(from: InfoPictureImages)
        print("정보토크이미지\(InfoPictureImages)")
        self.setNeedsLayout()
        self.layoutIfNeeded()
        self.tagCollectionView.reloadData()
    }
    
    //MARK: - @objc 
    @objc private func declareButtonTapped() {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        if currentItsMe == userName.text {
            // 게시글 수정
            //            actionSheet.addAction(UIAlertAction(title: "게시글 수정", style: .default, handler: { (_) in
            //                // self.delegate?.editPostButtonTapped()
            //            }))
            
            // 게시글 삭제
            actionSheet.addAction(UIAlertAction(title: "게시글 삭제", style: .destructive, handler: { (_) in
                self.delegate?.deletePostButtonTapped()
            }))
        } else {
            // 게시글 신고
            actionSheet.addAction(UIAlertAction(title: "게시글 신고", style: .default, handler: { (_) in
                self.delegate?.declareViewButtonTapped()
            }))
        }
        
        // 취소
        actionSheet.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        
        if let viewController = delegate as? UIViewController {
            viewController.present(actionSheet, animated: true, completion: nil)
        }
    }
    
}

extension InfoPostContentView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedTags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PostTagCell", for: indexPath) as! PostTagCollectionViewCell
        let tag = selectedTags[indexPath.item]
        cell.configure(with: tag)
        return cell
    }
}
extension InfoPostContentView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let tag = selectedTags[indexPath.item]
        let tagWidth = tag.width(withConstrainedHeight: 35, font: UIFont.systemFont(ofSize: 10), margin: 30)
        return CGSize(width: tagWidth, height: 30)
    }
}
