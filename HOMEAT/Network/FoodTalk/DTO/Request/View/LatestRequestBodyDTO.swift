//
//  LatestRequestBody.swift
//  HOMEAT
//
//  Created by 이지우 on 5/26/24.
//

import Foundation

struct LatestRequestBodyDTO: Codable {
    let search: String
    let tag: String
    let lastFoodTalkId: Int
}
