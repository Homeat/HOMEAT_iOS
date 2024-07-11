//
//  CircularImageView.swift
//  HOMEAT
//
//  Created by 김민솔 on 7/9/24.
//

import Foundation
import UIKit

class CircularImageView: UIImageView {
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.bounds.width / 2
        self.layer.masksToBounds = true
    }
}
