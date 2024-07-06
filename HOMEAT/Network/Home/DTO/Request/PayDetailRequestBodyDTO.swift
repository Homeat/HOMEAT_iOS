//
//  PayDetailRequestBodyDTO.swift
//  HOMEAT
//
//  Created by 김민솔 on 7/4/24.
//

import Foundation

struct PayDetailRequestBodyDTO: Codable {
    let year: String
    let month: String
    let day: String
    let remainingGoal: Int
}
