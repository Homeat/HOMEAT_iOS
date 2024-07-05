//
//  PayDetail.swift
//  HOMEAT
//
//  Created by 김민솔 on 7/5/24.
//

import Foundation

struct PayDetailsResponseDTO: Codable {
    let type: String
    let memo: String
    let usedMoney: Int
    let remainingGoal: Int
}
