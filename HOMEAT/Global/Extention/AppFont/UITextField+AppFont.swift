//
//  UITextField+AppFont.swift
//  HOMEAT
//
//  Created by 강석호 on 3/29/24.
//

import Foundation
import UIKit

extension UITextField {
    
    func setAppFont(_ appFont: FontSet) {
        if let text = text {
            
            let font = UIFont.appFont(appFont)
            
            let style = NSMutableParagraphStyle()
            style.maximumLineHeight = appFont.lineHeight
            style.minimumLineHeight = appFont.lineHeight
            
            let attributes: [NSAttributedString.Key: Any] = [
                .font: font as Any,
                .paragraphStyle: style,
                .baselineOffset: (appFont.lineHeight - font.lineHeight) / 4
            ]
            
            let attrString = NSAttributedString(
                string: text,
                attributes: attributes
            )
            
            attributedText = attrString
        }
    }
}
