import UIKit
import SnapKit
import Kingfisher

class FoodTalkCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "FoodTalkCollectionViewCell"
    
    let foodName: UILabel = {
        let label = UILabel()
        label.font = .bodyMedium15
        label.textColor = .white
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 1
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    let foodImageView: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 11
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    private var imageDownloadTask: URLSessionDataTask?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        foodImageView.image = nil
        foodName.text = nil
        imageDownloadTask?.cancel()
        imageDownloadTask = nil
    }
    
    private func setUI() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 4
        layer.cornerRadius = 10
        layer.masksToBounds = false
        
        addSubviews(foodName, foodImageView)
        
        foodImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(14)
            make.height.equalToSuperview().multipliedBy(0.7)
            make.width.equalTo(foodImageView.snp.height).multipliedBy(1.2)
        }
        
        foodName.snp.makeConstraints { make in
            make.top.equalTo(foodImageView.snp.bottom).offset(3)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(-5)
            make.height.equalTo(20).priority(.high)
        }
    }
    
    func configure(with foodTalk: FoodTalk) {
        foodName.text = foodTalk.foodName
        let photoUrl = foodTalk.url
        let url = URL(string: photoUrl)
        foodImageView.kf.setImage(with: url)
    }
}

