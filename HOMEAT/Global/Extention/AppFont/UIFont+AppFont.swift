//
//  UIFont+AppFont.swift
//  HOMEAT
//
//  Created by 강석호 on 3/29/24.
//

import Foundation
import UIKit


extension UIFont {
    static func appFont(_ appFont: FontSet) -> UIFont {
        return UIFont(name: appFont.fontName, size: appFont.size)!
    }
}
