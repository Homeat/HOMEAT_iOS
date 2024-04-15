//
//  WeekLookViewController.swift
//  HOMEAT
//
//  Created by 김민솔 on 4/3/24.
//

import UIKit
import Then
import SnapKit

class WeekLookViewController: BaseViewController {
    //MARK: - Property
    let imageNames = ["egg_meat", "born_meat", "baby_meat", "infant_meat", "toddler_meat", "student_meat", "magic_meat", "adult_meat", "angel_meat"]
    let lockImage = UIImage(named: "lockReport")
    private var smileImg = UIImageView()
    private var nicknameLable = UILabel()
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 28, left: 20, bottom: 0, right: 20)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.alwaysBounceVertical = true
        collectionView.register(WeekCollectionViewCell.self, forCellWithReuseIdentifier: WeekCollectionViewCell.id)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor.init(named: "turquoiseDarkGray")
        collectionView.isScrollEnabled = false
        collectionView.layer.cornerRadius = 35
        collectionView.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner)
        collectionView.clipsToBounds = true
        return collectionView
    }()
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setConfigure() {
        smileImg.do {
            $0.image = UIImage(named: "smileIcon")
        }
        nicknameLable.do {
            $0.text = "홈잇러버 예진님"
            $0.textColor = .white
            $0.font = .bodyMedium15
        }
    }
    
    override func setConstraints() {
        view.addSubviews(smileImg,nicknameLable,collectionView)
        smileImg.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(22)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(64)
            $0.height.equalTo(15)
            $0.width.equalTo(15)
        }
        
        nicknameLable.snp.makeConstraints {
            $0.leading.equalTo(smileImg.snp.trailing).offset(6)
            $0.top.equalTo(smileImg.snp.top)
            $0.bottom.equalTo(smileImg.snp.bottom)
        }
        collectionView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.top.equalTo(nicknameLable.snp.bottom).offset(21)
        }
    }
    
    override func setting() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

// MARK: - Extension
extension WeekLookViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeekCollectionViewCell.id, for: indexPath) as? WeekCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.updateWeekLabel(withWeekIndex: indexPath.row + 1)
        
        if indexPath.item == 8 {
            cell.cellView.weekLabel.isHidden = true
            cell.successMoney.isHidden = true
            cell.failMoney.isHidden = true
            cell.cellView.backgroundColor = UIColor(named: "turquoiseGray")
            cell.cellView.imageView.image = lockImage
        } else {
            if indexPath.item == 1 {
                cell.cellView.backgroundColor = UIColor(named: "turquoiseRed")
            } else {
                cell.cellView.backgroundColor = UIColor(named: "turquoiseGreen")
            }
            let imageName = imageNames[indexPath.item]
            let model = WeekCellModel(weekIndex: indexPath.item + 1, imageName: imageName)
            cell.model = model
        }
        return cell
    }
}

extension WeekLookViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 155)
    }
}
