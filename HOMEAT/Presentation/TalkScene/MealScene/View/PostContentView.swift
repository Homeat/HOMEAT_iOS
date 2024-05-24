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

protocol HeaderViewDelegate: AnyObject {
    func recipeViewButtonTapped()
    func declareViewButtonTapped()
}

class PostContentView: UITableViewHeaderFooterView, UIScrollViewDelegate {
    
    weak var delegate: HeaderViewDelegate?
    
    //MARK: - Property
    private let profileIcon = UIImageView()
    private let userName = UILabel()
    private let dateLabel = UILabel()
    private let declareButton = UIButton()
    private let hashtagButton = UIButton()
    private let titleLabel = UILabel()
    private let contentLabel = UILabel()
    private let pageControl = UIPageControl()
    private let scrollView = UIScrollView()
    private let reactionView = ReplyReactionView()
    private let underLine = UIView()
    private let recipeViewButton = UIButton()
    
    var images = [UIImage(imageLiteralResourceName: "baseCharacter"), UIImage(imageLiteralResourceName: "baseCharacter"), UIImage(imageLiteralResourceName: "baseCharacter")]
    var imageViews = [UIImageView]()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setConfigure()
        setConstraint()
        scrollView.delegate = self
        addContentScrollView()
        setPageControl()
        setAddTarget()
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
            $0.setTitle("신고하기", for: .normal)
            $0.setTitleColor(UIColor(named: "warmgray8"), for: .normal)
            $0.titleLabel?.font = .captionMedium10
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
        addSubviews(profileIcon, userName, dateLabel, declareButton, hashtagButton,titleLabel, contentLabel, pageControl, scrollView, reactionView, underLine, recipeViewButton)
        
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
            $0.top.equalTo(dateLabel.snp.top)
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
        }
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(contentLabel.snp.bottom).offset(19)
            $0.leading.equalTo(profileIcon.snp.leading)
            $0.trailing.equalTo(profileIcon.snp.leading)
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
                let xPos = scrollView.frame.width * CGFloat(i)
                imageView.frame = CGRect(x: xPos, y: 0, width: scrollView.bounds.width, height: scrollView.bounds.height)
                imageView.image = images[i]
                scrollView.addSubview(imageView)
                scrollView.contentSize.width = imageView.frame.width * CGFloat(i + 1)
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

    //MARK: - @objc
    @objc func declareButtonTapped() {
        delegate?.declareViewButtonTapped()
    }
    
    @objc func recipeButtonTapped() {
        delegate?.recipeViewButtonTapped()
    }
}
