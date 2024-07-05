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
    private var weekData: [ReportBadge] = []
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
        updateServer(lastWeekId: 0)
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
                guard let responseData = data.data?.reportBadge else {
                    self.isDataEmpty = true
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                    return
                }
                self.weekData = responseData
                self.isDataEmpty = responseData.isEmpty
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            case .requestErr(let statusResponse):
                print("요청 에러: \(statusResponse.message)")
            case .pathErr:
                print("경로 에러")
            case .serverErr:
                print("서버 에러")
            case .networkErr:
                print("네트워크 에러")
            case .failure:
                print("실패")
            }
        }
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
        cell.configureAsLock()
//        cell.updateWeekLabel(withWeekIndex: <#T##Int#>)
//        if isDataEmpty {
//            cell.configureAsLock()
//        } else {
//            let weekItem = weekData[indexPath.item]
//            cell.configure(with: weekItem)
//        }
        return cell
    }
}


extension WeekLookViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 155)
    }
}
