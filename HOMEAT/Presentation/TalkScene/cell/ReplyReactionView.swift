//
//  ReplyReactionView.swift
//  HOMEAT
//
//  Created by 이지우 on 5/10/24.
//

import Foundation
import UIKit
import Then
import SnapKit

final class ReplyReactionView: UIStackView {
    
    private let heartCount: UIButton = {
        let button = UIButton()
        button.setTitle("9", for: .normal)
        button.titleLabel?.font = .captionMedium10
        button.setTitleColor(UIColor(named: "turquoiseGreen"), for: .normal)
        button.setImage(UIImage(named: "isHeartSelected"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -5, bottom: 0, right: 0)
        return button
    }()
    
    private let replyLabel: UIButton = {
        let button = UIButton()
        button.setTitle("2", for: .normal)
        button.titleLabel?.font = .captionMedium10
        button.setTitleColor(UIColor(named: "turquoiseGreen"), for: .normal)
        button.setImage(UIImage(named: "isReply"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -5, bottom: 0, right: 0)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setConfigure()
    
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setConfigure() {
        self.spacing = 10
        self.axis = .horizontal
        self.alignment = .center
        
        addArrangedSubview(heartCount)
        addArrangedSubview(replyLabel)
    }
    
}
