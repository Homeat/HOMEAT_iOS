//
//  PhotoManager.swift
//  HOMEAT
//
//  Created by 이지우 on 6/21/24.
//

import Foundation
import UIKit

class PhotoManager {
    static let shared = PhotoManager()
    
    private init() {}
    var essentialImage : UIImage = UIImage()
    var foodPhotos : [Data]? = []

}
