//
//  TagPlusViewController.swift
//  HOMEAT
//
//  Created by 김민솔 on 5/19/24.
//

import UIKit
import SnapKit
import Then
import Alamofire

protocol TagPlusViewControllerDelegate: AnyObject {
    func didUpdateTags(_ tags: [String])
}
class TagPlusViewController: BaseViewController {
    //MARK: -- Property
    weak var delegate: TagPlusViewControllerDelegate?
    var selectedTags: [String] = []
    var tags: [TagItem] = defaultTags
    private let tagPlusField = UITextField()
    private let plusButton = UIButton()
    private let saveButton = UIButton()
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 17
        layout.minimumInteritemSpacing = 5
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor(named: "turquoiseGray2")
        collectionView.register(TagPlusCollectionViewCell.self, forCellWithReuseIdentifier: TagPlusCollectionViewCell.reuseIdentifier)
        return collectionView
    }()
    override func viewDidLoad() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewDidTap))
        self.view.addGestureRecognizer(tapGesture)
        super.viewDidLoad()
        setCollection()
        setNavigationBar()
        
    }
    // MARK: - 탭바제거
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let tabBarController = self.tabBarController as? HOMEATTabBarController {
            tabBarController.tabBar.isHidden = true
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if let tabBarController = self.tabBarController as? HOMEATTabBarController {
            tabBarController.tabBar.isHidden = false
        }
    }
    
    
    private func setNavigationBar() {
        self.navigationItem.title = "해시태그 추가"
        let titleAttributes: [NSAttributedString.Key: Any] = [
            .font:  UIFont.bodyMedium18,
            .foregroundColor: UIColor.white
        ]
        navigationController?.navigationBar.titleTextAttributes = titleAttributes
        let backbutton = UIBarButtonItem()
        backbutton.tintColor = .white
        navigationController?.navigationBar.topItem?.backBarButtonItem = backbutton
        navigationController?.navigationBar.barTintColor = UIColor(named: "homeBackgroundColor")
    }
    private func setCollection() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    //MARK: - SetUI
    override func setConfigure() {
        view.do {
            $0.backgroundColor = UIColor(named: "homeBackgroundColor")
        }
        
        tagPlusField.do {
            $0.placeholder = "다양한 해시태그를 추가해보세요!"
            $0.font = .bodyMedium16
            $0.textColor = UIColor.warmgray
            $0.layer.cornerRadius = 10
            $0.clipsToBounds = true
            $0.backgroundColor = .turquoiseDarkGray
            $0.attributedPlaceholder = NSAttributedString(string: "다양한 해시태그를 추가해보세요!", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "font5") ?? UIColor.gray])
            $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: $0.frame.height))
            $0.leftViewMode = .always
        }
        
        plusButton.do {
            $0.setImage(UIImage(named: "tagPlusButton"), for: .normal)
            $0.imageView?.contentMode = .scaleAspectFit
            $0.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
        }
        
        saveButton.do {
            $0.setTitle("저장", for: .normal)
            $0.setTitleColor(UIColor.white, for: .normal)
            $0.layer.cornerRadius = 10
            $0.layer.masksToBounds = true
            $0.backgroundColor = UIColor.init(named: "turquoiseDarkGray")
            $0.titleLabel?.font = .bodyBold16
            $0.addTarget(self, action: #selector(navigatetToInfoWritingViewController), for: .touchUpInside)
        }
    }
    
    override func setConstraints() {
        view.addSubviews(tagPlusField,collectionView,saveButton)
        tagPlusField.addSubview(plusButton)
        
        tagPlusField.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(23)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(50)
        }
        
        plusButton.snp.makeConstraints {
            $0.top.equalTo(tagPlusField.snp.top).offset(5)
            $0.trailing.equalTo(tagPlusField.snp.trailing).inset(20)
            $0.height.equalTo(40)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(tagPlusField.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(saveButton.snp.top).offset(-20)
        }
        
        saveButton.snp.makeConstraints {
            $0.top.equalTo(collectionView.snp.bottom).offset(-20)
            $0.bottom.equalToSuperview().inset(76)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(57)
        }
    }
    
    //MARK: -- objc
    @objc func viewDidTap(gesture: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    @objc private func plusButtonTapped() {
        if let newTag = tagPlusField.text, !newTag.isEmpty {
            tags.append(TagItem(tagTitle: newTag))
            collectionView.reloadData()
            tagPlusField.text = nil
        }
    }
    @objc func navigatetToInfoWritingViewController() {
        delegate?.didUpdateTags(selectedTags)
        navigationController?.popViewController(animated: true)
    }
}
extension TagPlusViewController: TagPlusDelegate {
    func tagChangeByClick(isSelect: Bool, tag: String) {
        if isSelect {
            selectedTags.append(tag)
            saveButton.backgroundColor = UIColor.turquoiseGreen
        } else {
            if let index = selectedTags.firstIndex(of: tag) {
                selectedTags.remove(at: index)
                
            }
            if selectedTags.isEmpty {
                saveButton.backgroundColor = UIColor.turquoiseDarkGray
            }
        }
        print("Selected Tags: \(selectedTags)")
    }
}
extension TagPlusViewController: UICollectionViewDelegate {
    
}
extension TagPlusViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagPlusCollectionViewCell.reuseIdentifier, for: indexPath) as! TagPlusCollectionViewCell
        let tagTitle = tags[indexPath.item].tagTitle
        let isSelected = selectedTags.contains(tagTitle)
        cell.configure(with: tagTitle, isSelected: isSelected)
        cell.delegate = self
        return cell
    }
}
extension TagPlusViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let tagItem = tags[indexPath.item]
        let titleSize = NSString(string: tagItem.tagTitle).size(withAttributes: [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)
        ])
        let cellWidth = titleSize.width + 40
        return CGSize(width: cellWidth, height: 45)
    }
}
