//
//  FontSet.swift
//  HOMEAT
//
//  Created by 강석호 on 3/29/24.
//

import Foundation

enum FontSet {
    case title1
    case title2
    case bodyBold
    case body
    case caption
    case caption2
    
    var size: CGFloat {
        switch self {
        case .title1:
            return 22
        case .title2:
            return 14
        case .bodyBold:
            return 13
        case .body:
            return 13
        case .caption:
            return 12
        case .caption2:
            return 11
        }
    }
    
    var lineHeight: CGFloat {
        switch self {
        case .title1:
            return 30
        case .title2:
            return 20
        case .bodyBold:
            return 18
        case .body:
            return 18
        case .caption:
            return 18
        case .caption2:
            return 18
        }
    }
    
    var fontName: String {
        switch self {
        case .title1, .title2, .bodyBold:
            return "SF-Pro-Text-Bold"
        case .body, .caption, .caption2:
            return "SF-Pro-Text-Regular"
            
        }
    }
}
