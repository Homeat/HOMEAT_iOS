//
//  AnalysisWeekResponseDTO.swift
//  HOMEAT
//
//  Created by 김민솔 on 5/5/24.
//

import Foundation

struct AnalysisWeekResponseDTO: Codable {
    let ageRange: String
    let income: String
    let gender: String
    let nickname: String
    let jipbapSave: Int
    let outSave: Int
    let jipbapAverage: Int
    let weekJipbapPrice: Int
    let outAverage: Int
    let weekOutPrice: Int
}
