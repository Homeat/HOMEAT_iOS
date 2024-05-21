//
//  InfoWriteViewController.swift
//  HOMEAT
//
//  Created by 김민솔 on 5/19/24.
//

import UIKit
import AVFoundation
import Photos
import PhotosUI

class InfoWriteViewController: BaseViewController {
    
    //MARK: - Property
    private let hashContainer = UIStackView()
    private let infoCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    private let addImageButton = UIButton()
    private let imageView = UIImageView()
    private let tagCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    private let tagImage = UIButton()
    private let titleLabel = UILabel()
    private let titleField = UITextField()
    private let contentLabel = UILabel()
    private let contentField = UITextView()
    private let imageConfig = UIImage.SymbolConfiguration(pointSize: 50, weight: .light)

    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    //MARK: - SetUI
    override func setConfigure() {
        hashContainer.do {
            $0.distribution = .fillEqually
            $0.spacing = 20
            $0.axis = .horizontal
            $0.alignment = .fill
        }
        
        infoCollectionView.do {
            $0.delegate = self
            $0.dataSource = self
            $0.backgroundColor = .clear
            $0.showsHorizontalScrollIndicator = false
            $0.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: "PhotoCell")
        }
        
        addImageButton.do {
            $0.setTitle("사진추가", for: .normal)
            //$0.setImage(image, for: .normal)
            //$0.layer?.cornerRadius = 14
            //$0.clipsToBounds = true
            
        }
        
        imageView.do {
            $0.layer.cornerRadius = 14
            $0.clipsToBounds = true
        }
        
        
    }
    private var isCameraAuthorized: Bool {
       AVCaptureDevice.authorizationStatus(for: .video) == .authorized
     }
    
    

}

extension InfoWriteViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    

}
