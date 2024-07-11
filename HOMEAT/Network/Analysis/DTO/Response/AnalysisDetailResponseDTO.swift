//
//  AnalysisDetailResponseDTO.swift
//  HOMEAT
//
//  Created by 김민솔 on 7/4/24.
//

import Foundation

struct AnalysisDetailResponseDTO: Codable {
    let type: String
    let memo: String
    let usedMoney: Int
    let ramainingGoal: Int
}
