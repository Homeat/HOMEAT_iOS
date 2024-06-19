//
//  LoveOrderResponseDTO.swift
//  HOMEAT
//
//  Created by 이지우 on 5/26/24.
//

import Foundation

struct LoveOrderResponseDTO: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let pageIdx: Int
    let pageSize: Int
    let hasNext: Bool
    let data: [FoodTalk]
}

