//
//  ReportBadge.swift
//  HOMEAT
//
//  Created by 김민솔 on 5/22/24.
//

import Foundation
struct ReportBadge : Codable {
    let homeatTier : String
    let nickname: String
    let week_id : Int
    let goal_price : Int
    let exceed_price : Int
    let weekStatus : String
    let badge_url : String
}
