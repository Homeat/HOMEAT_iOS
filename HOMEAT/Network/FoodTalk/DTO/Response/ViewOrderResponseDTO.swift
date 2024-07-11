//
//  ViewOrderResponseDTO.swift
//  HOMEAT
//
//  Created by 이지우 on 6/15/24.
//

import Foundation

struct ViewOrderResponseDTO: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let pageIdx: Int
    let pageSize: Int
    let hasNext: Bool
    let data: [FoodTalk]
}
