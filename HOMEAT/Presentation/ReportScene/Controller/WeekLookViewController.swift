//
//  WeekLookViewController.swift
//  HOMEAT
//
//  Created by 김민솔 on 4/3/24.
//

import UIKit
import Then
import SnapKit
import Kingfisher

class WeekLookViewController: BaseViewController {
    //MARK: - Property
    private var weekData: [WeekLookResponseDTO] = []
    private var smileImg = UIImageView()
    private var nicknameLable = UILabel()
    private var isDataEmpty = false
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 28, left: 20, bottom: 0, right: 20)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.alwaysBounceVertical = true
        collectionView.register(WeekCollectionViewCell.self, forCellWithReuseIdentifier: WeekCollectionViewCell.id)
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
        isDataEmpty = false
        weekData = []
        updateServer(lastWeekId: 0)
        updateTier()
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
    private func updateServer(lastWeekId: Int) {
           let queryDTO = WeekLookRequestBodyDTO(lastWeekId: lastWeekId)
           NetworkService.shared.weekLookService.weekLookReport(queryDTO: queryDTO) { response in
               switch response {
               case .success(let data):
                   if let weekData = data.data {
                       self.weekData = weekData
                       self.isDataEmpty = weekData.isEmpty
                   } else {
                       self.isDataEmpty = true
                   }
                   DispatchQueue.main.async {
                       self.collectionView.reloadData()
    
                   }
               default:
                   self.isDataEmpty = true
                   DispatchQueue.main.async {
                       self.collectionView.reloadData()
                   }
                   print("실패")
               }
           }
       }
    private func updateTier() {
        NetworkService.shared.weekLookService.weekLookBadge() { response in
            switch response {
            case .success(let data):
                print("티어 서버 연동")
                
                self.nicknameLable.text = {
                    if let homeatTier = data.data?.homeatTier, let nickname = data.data?.nickname {
                        return "\(homeatTier) \(nickname)"
                    } else {
                        return "정보 없음" 
                    }
                }()            default:
                print("티어 서버연동 실패")
            }
        }
    }
    
}

// MARK: - Extension
extension WeekLookViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return isDataEmpty ? 9 : weekData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeekCollectionViewCell.id, for: indexPath) as? WeekCollectionViewCell else {
               return UICollectionViewCell()
           }
           
           if isDataEmpty {
               cell.configureAsLock()
           } else {
               let weekItem = weekData[indexPath.item]
               cell.configure(with: weekItem)
           }

           return cell
       }
}


extension WeekLookViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 155)
    }
}
