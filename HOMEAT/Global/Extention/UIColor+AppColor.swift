//
//  UIColor+AppColor.swift
//  HOMEAT
//
//  Created by 강석호 on 3/29/24.
//

import Foundation
import UIKit

extension UIColor {
    static func appColor(_ colorset: ColorSet) -> UIColor {
        return UIColor(hexCode: colorset.hexCode)
    }
}
