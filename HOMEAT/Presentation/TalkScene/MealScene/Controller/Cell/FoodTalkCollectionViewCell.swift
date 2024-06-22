import UIKit
import SnapKit

class ImageCache {
    static let shared = NSCache<NSString, UIImage>()
}

class FoodTalkCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "FoodTalkCollectionViewCell"
    
    let foodName: UILabel = {
        let label = UILabel()
        label.font = .bodyMedium15
        label.textColor = .white
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
            make.height.equalTo(100)
            make.width.equalTo(120)
        }
        
        foodName.snp.makeConstraints { make in
            make.top.equalTo(foodImageView.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(self.snp.bottom).offset(-5)
        }
    }
    
    func configure(with foodTalk: FoodTalk) {
        foodName.text = foodTalk.foodName
        
        if let url = URL(string: foodTalk.url) {
            // 캐시에서 이미지 확인
            if let cachedImage = ImageCache.shared.object(forKey: url.absoluteString as NSString) {
                foodImageView.image = cachedImage
            } else {
                // URL로부터 이미지 비동기적으로 로드
                imageDownloadTask = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
                    guard let self = self, let data = data, error == nil, let image = UIImage(data: data) else {
                        return
                    }
                    // 캐시에 저장
                    ImageCache.shared.setObject(image, forKey: url.absoluteString as NSString)
                    DispatchQueue.main.async {
                        self.foodImageView.image = image
                    }
                }
                imageDownloadTask?.resume()
            }
        } else {
            foodImageView.image = nil
        }
    }
}
