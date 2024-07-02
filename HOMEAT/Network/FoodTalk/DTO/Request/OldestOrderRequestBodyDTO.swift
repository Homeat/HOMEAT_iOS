//
//  OldestOrderRequestBodyDTO.swift
//  HOMEAT
//
//  Created by 이지우 on 6/15/24.
//

import Foundation

struct OldestOrderRequestBodyDTO: Codable {
    let search: String
    let tag: String
    let OldestFoodTalkId: Int
}
